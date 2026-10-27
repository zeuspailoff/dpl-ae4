#!/usr/bin/env bash
set -euo pipefail

mkdir -p data

docker compose build
docker compose up -d

for i in $(seq 1 30); do
  if curl -sf http://localhost:8000/healthz >/dev/null; then
    echo "Despliegue correcto: /healthz responde 200"
    exit 0
  fi
  sleep 2
done

echo "ERROR: /healthz no respondió a tiempo" >&2
exit 1