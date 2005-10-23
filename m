Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVJWTAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVJWTAI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 15:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVJWTAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 15:00:08 -0400
Received: from xenotime.net ([66.160.160.81]:23019 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751084AbVJWTAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 15:00:06 -0400
Date: Sun, 23 Oct 2005 11:57:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh <greg@kroah.com>
Subject: [PATCH] kernel-doc: PCI fixes
Message-Id: <20051023115738.40b68e9f.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

PCI: add descriptions for missing function parameters.
Eliminate all kernel-doc warnings here.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/pci/msi.c        |    2 ++
 drivers/pci/pci-driver.c |   13 +++++++++----
 drivers/pci/pci.c        |    7 ++++---
 drivers/pci/probe.c      |    1 +
 4 files changed, 16 insertions(+), 7 deletions(-)

diff -Naurp linux-2614-rc5/drivers/pci/probe.c~kdoc_pci linux-2614-rc5/drivers/pci/probe.c
--- linux-2614-rc5/drivers/pci/probe.c~kdoc_pci	2005-10-20 18:55:34.000000000 -0700
+++ linux-2614-rc5/drivers/pci/probe.c	2005-10-22 22:31:21.000000000 -0700
@@ -669,6 +669,7 @@ static void pci_release_dev(struct devic
 
 /**
  * pci_cfg_space_size - get the configuration space size of the PCI device.
+ * @dev: PCI device
  *
  * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express devices
  * have 4096 bytes.  Even if the device is capable, that doesn't mean we can
diff -Naurp linux-2614-rc5/drivers/pci/msi.c~kdoc_pci linux-2614-rc5/drivers/pci/msi.c
--- linux-2614-rc5/drivers/pci/msi.c~kdoc_pci	2005-10-20 18:55:34.000000000 -0700
+++ linux-2614-rc5/drivers/pci/msi.c	2005-10-22 22:34:00.000000000 -0700
@@ -575,6 +575,8 @@ static int msi_capability_init(struct pc
 /**
  * msix_capability_init - configure device's MSI-X capability
  * @dev: pointer to the pci_dev data structure of MSI-X device function
+ * @entries: pointer to an array of struct msix_entry entries
+ * @nvec: number of @entries
  *
  * Setup the MSI-X capability structure of device function with a
  * single MSI-X vector. A return of zero indicates the successful setup of
diff -Naurp linux-2614-rc5/drivers/pci/pci.c~kdoc_pci linux-2614-rc5/drivers/pci/pci.c
--- linux-2614-rc5/drivers/pci/pci.c~kdoc_pci	2005-10-20 18:55:34.000000000 -0700
+++ linux-2614-rc5/drivers/pci/pci.c	2005-10-22 22:37:54.000000000 -0700
@@ -252,6 +252,8 @@ pci_restore_bars(struct pci_dev *dev)
 		pci_update_resource(dev, &dev->resource[i], i);
 }
 
+int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t t);
+
 /**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to be suspended
@@ -266,7 +268,6 @@ pci_restore_bars(struct pci_dev *dev)
  * -EIO if device does not support PCI PM.
  * 0 if we can successfully change the power state.
  */
-int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t t);
 int
 pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
@@ -808,8 +809,8 @@ pci_clear_mwi(struct pci_dev *dev)
 
 /**
  * pci_intx - enables/disables PCI INTx for device dev
- * @dev: the PCI device to operate on
- * @enable: boolean
+ * @pdev: the PCI device to operate on
+ * @enable: boolean: whether to enable or disable PCI INTx
  *
  * Enables/disables PCI INTx for device dev
  */
diff -Naurp linux-2614-rc5/drivers/pci/pci-driver.c~kdoc_pci linux-2614-rc5/drivers/pci/pci-driver.c
--- linux-2614-rc5/drivers/pci/pci-driver.c~kdoc_pci	2005-10-20 18:55:34.000000000 -0700
+++ linux-2614-rc5/drivers/pci/pci-driver.c	2005-10-22 23:26:01.000000000 -0700
@@ -26,7 +26,10 @@ struct pci_dynid {
 #ifdef CONFIG_HOTPLUG
 
 /**
- * store_new_id
+ * store_new_id - add a new PCI device ID to this driver and re-probe devices
+ * @driver: target device driver
+ * @buf: buffer for scanning device ID data
+ * @count: input size
  *
  * Adds a new dynamic pci device ID to this driver,
  * and causes the driver to probe for all devices again.
@@ -194,8 +197,10 @@ static int pci_call_probe(struct pci_dri
 
 /**
  * __pci_device_probe()
+ * @drv: driver to call to check if it wants the PCI device
+ * @pci_dev: PCI device being probed
  * 
- * returns 0  on success, else error.
+ * returns 0 on success, else error.
  * side-effect: pci_dev->driver is set to drv when drv claims pci_dev.
  */
 static int
@@ -436,11 +441,11 @@ pci_dev_driver(const struct pci_dev *dev
 
 /**
  * pci_bus_match - Tell if a PCI device structure has a matching PCI device id structure
- * @ids: array of PCI device id structures to search in
  * @dev: the PCI device structure to match against
+ * @drv: the device driver to search for matching PCI device id structures
  * 
  * Used by a driver to check whether a PCI device present in the
- * system is in its list of supported devices.Returns the matching
+ * system is in its list of supported devices. Returns the matching
  * pci_device_id structure or %NULL if there is no match.
  */
 static int pci_bus_match(struct device *dev, struct device_driver *drv)


---
