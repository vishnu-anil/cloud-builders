          #!/bin/bash
          CLUSTER_NAME=$1
          REGION=$2
          
          cd /
          set -x
          whoami 
          apt-get update
          apt install wget git -y
          wget https://github.com/mikefarah/yq/releases/download/v4.2.0/yq_linux_amd64 \
          && chmod +x yq_linux_amd64 \
          && mv yq_linux_amd64 yq \
          && cp yq /usr/local/bin
          curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
          && chmod 700 get_helm.sh \
          && ./get_helm.sh
          wget -O helmfile_linux_amd64 https://github.com/roboll/helmfile/releases/download/v0.135.0/helmfile_linux_amd64
          chmod +x helmfile_linux_amd64
          mv helmfile_linux_amd64 /bin/helmfile
          apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y 
          apt-get install kubectl -y 
          export KUBECONFIG=$HOME/.kube/config
          gcloud services enable cloudbuild.googleapis.com --project=$PROJECT
          gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION
      
