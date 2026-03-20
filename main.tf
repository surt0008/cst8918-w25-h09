resource "azurerm_resource_group" "rg" {
  name     = "${var.labelPrefix}-aks-rg"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "app" {
  name                = "${var.labelPrefix}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.labelPrefix}aks"

  kubernetes_version = null

  default_node_pool {
    name                 = "systemnp"
    vm_size              = "Standard_B2s"
    auto_scaling_enabled = true
    min_count            = 1
    max_count            = 3
    node_count           = 1
    os_disk_size_gb      = 30
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    course = "CST8918"
    lab    = "H09"
  }
}