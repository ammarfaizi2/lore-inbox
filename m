Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVDMESJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVDMESJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVDLTEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:04:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:58057 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262219AbVDLKcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:41 -0400
Message-Id: <200504121032.j3CAWR7p005597@shell0.pdx.osdl.net>
Subject: [patch 115/198] fix u32 vs. pm_message_t in PCI, PCIE
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

This fixes drivers/pci (mostly pcie stuff).

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/pci/hotplug/pciehp_core.c |    2 +-
 25-akpm/drivers/pci/pcie/portdrv.h        |    2 +-
 25-akpm/drivers/pci/pcie/portdrv_bus.c    |    4 ++--
 25-akpm/drivers/pci/pcie/portdrv_core.c   |    6 +++---
 25-akpm/drivers/pci/pcie/portdrv_pci.c    |    2 +-
 25-akpm/include/linux/pcieport_if.h       |    2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff -puN drivers/pci/hotplug/pciehp_core.c~fix-u32-vs-pm_message_t-in-pci-pcie drivers/pci/hotplug/pciehp_core.c
--- 25/drivers/pci/hotplug/pciehp_core.c~fix-u32-vs-pm_message_t-in-pci-pcie	2005-04-12 03:21:31.183396304 -0700
+++ 25-akpm/drivers/pci/hotplug/pciehp_core.c	2005-04-12 03:21:31.192394936 -0700
@@ -578,7 +578,7 @@ static void pciehp_remove (struct pcie_d
 }
 
 #ifdef CONFIG_PM
-static int pciehp_suspend (struct pcie_device *dev, u32 state)
+static int pciehp_suspend (struct pcie_device *dev, pm_message_t state)
 {
 	printk("%s ENTRY\n", __FUNCTION__);	
 	return 0;
diff -puN drivers/pci/pcie/portdrv_bus.c~fix-u32-vs-pm_message_t-in-pci-pcie drivers/pci/pcie/portdrv_bus.c
--- 25/drivers/pci/pcie/portdrv_bus.c~fix-u32-vs-pm_message_t-in-pci-pcie	2005-04-12 03:21:31.184396152 -0700
+++ 25-akpm/drivers/pci/pcie/portdrv_bus.c	2005-04-12 03:21:31.193394784 -0700
@@ -15,7 +15,7 @@
 #include <linux/pcieport_if.h>
 
 static int pcie_port_bus_match(struct device *dev, struct device_driver *drv);
-static int pcie_port_bus_suspend(struct device *dev, u32 state);
+static int pcie_port_bus_suspend(struct device *dev, pm_message_t state);
 static int pcie_port_bus_resume(struct device *dev);
 
 struct bus_type pcie_port_bus_type = {
@@ -46,7 +46,7 @@ static int pcie_port_bus_match(struct de
 	return 1;
 }
 
-static int pcie_port_bus_suspend(struct device *dev, u32 state)
+static int pcie_port_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
diff -puN drivers/pci/pcie/portdrv_core.c~fix-u32-vs-pm_message_t-in-pci-pcie drivers/pci/pcie/portdrv_core.c
--- 25/drivers/pci/pcie/portdrv_core.c~fix-u32-vs-pm_message_t-in-pci-pcie	2005-04-12 03:21:31.185396000 -0700
+++ 25-akpm/drivers/pci/pcie/portdrv_core.c	2005-04-12 03:21:31.193394784 -0700
@@ -61,7 +61,7 @@ static int pcie_port_remove_service(stru
 
 static void pcie_port_shutdown_service(struct device *dev) {}
 
-static int pcie_port_suspend_service(struct device *dev, u32 state, u32 level)
+static int pcie_port_suspend_service(struct device *dev, pm_message_t state, u32 level)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
@@ -76,7 +76,7 @@ static int pcie_port_suspend_service(str
 	return 0;
 }
 
-static int pcie_port_resume_service(struct device *dev, u32 state)
+static int pcie_port_resume_service(struct device *dev, u32 level)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
@@ -317,7 +317,7 @@ int pcie_port_device_register(struct pci
 }
 
 #ifdef CONFIG_PM
-int pcie_port_device_suspend(struct pci_dev *dev, u32 state)
+int pcie_port_device_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	struct list_head 		*head, *tmp;
 	struct device 			*parent, *child;
diff -puN drivers/pci/pcie/portdrv.h~fix-u32-vs-pm_message_t-in-pci-pcie drivers/pci/pcie/portdrv.h
--- 25/drivers/pci/pcie/portdrv.h~fix-u32-vs-pm_message_t-in-pci-pcie	2005-04-12 03:21:31.187395696 -0700
+++ 25-akpm/drivers/pci/pcie/portdrv.h	2005-04-12 03:21:31.194394632 -0700
@@ -31,7 +31,7 @@ extern struct bus_type pcie_port_bus_typ
 extern int pcie_port_device_probe(struct pci_dev *dev);
 extern int pcie_port_device_register(struct pci_dev *dev);
 #ifdef CONFIG_PM
-extern int pcie_port_device_suspend(struct pci_dev *dev, u32 state);
+extern int pcie_port_device_suspend(struct pci_dev *dev, pm_message_t state);
 extern int pcie_port_device_resume(struct pci_dev *dev);
 #endif
 extern void pcie_port_device_remove(struct pci_dev *dev);
diff -puN drivers/pci/pcie/portdrv_pci.c~fix-u32-vs-pm_message_t-in-pci-pcie drivers/pci/pcie/portdrv_pci.c
--- 25/drivers/pci/pcie/portdrv_pci.c~fix-u32-vs-pm_message_t-in-pci-pcie	2005-04-12 03:21:31.188395544 -0700
+++ 25-akpm/drivers/pci/pcie/portdrv_pci.c	2005-04-12 03:21:31.194394632 -0700
@@ -67,7 +67,7 @@ static void pcie_portdrv_remove (struct 
 }
 
 #ifdef CONFIG_PM
-static int pcie_portdrv_suspend (struct pci_dev *dev, u32 state)
+static int pcie_portdrv_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	return pcie_port_device_suspend(dev, state);
 }
diff -puN include/linux/pcieport_if.h~fix-u32-vs-pm_message_t-in-pci-pcie include/linux/pcieport_if.h
--- 25/include/linux/pcieport_if.h~fix-u32-vs-pm_message_t-in-pci-pcie	2005-04-12 03:21:31.189395392 -0700
+++ 25-akpm/include/linux/pcieport_if.h	2005-04-12 03:21:31.194394632 -0700
@@ -59,7 +59,7 @@ struct pcie_port_service_driver {
 	int (*probe) (struct pcie_device *dev, 
 		const struct pcie_port_service_id *id);
 	void (*remove) (struct pcie_device *dev);
-	int (*suspend) (struct pcie_device *dev, u32 state);
+	int (*suspend) (struct pcie_device *dev, pm_message_t state);
 	int (*resume) (struct pcie_device *dev);
 
 	const struct pcie_port_service_id *id_table;
_
