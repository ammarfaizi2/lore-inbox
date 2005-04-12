Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVDMEFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVDMEFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVDLTIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:08:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:47817 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262212AbVDLKcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:36 -0400
Message-Id: <200504121032.j3CAWOSc005581@shell0.pdx.osdl.net>
Subject: [patch 111/198] fix u32 vs. pm_message_t in drivers/mmc,mtd,scsi
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

This fixes u32 vs.  pm_message_t in drivers/mmc, drivers/mtd and
drivers/scsi.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/mmc/mmc.c               |    2 +-
 25-akpm/drivers/mmc/mmci.c              |    2 +-
 25-akpm/drivers/mmc/pxamci.c            |    2 +-
 25-akpm/drivers/mmc/wbsd.c              |    2 +-
 25-akpm/drivers/mtd/maps/sa1100-flash.c |    2 +-
 25-akpm/drivers/scsi/mesh.c             |    2 +-
 25-akpm/drivers/scsi/nsp32.c            |   10 +++++-----
 7 files changed, 11 insertions(+), 11 deletions(-)

diff -puN drivers/mmc/mmc.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi drivers/mmc/mmc.c
--- 25/drivers/mmc/mmc.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi	2005-04-12 03:21:30.196546328 -0700
+++ 25-akpm/drivers/mmc/mmc.c	2005-04-12 03:21:30.208544504 -0700
@@ -884,7 +884,7 @@ EXPORT_SYMBOL(mmc_free_host);
  *	@host: mmc host
  *	@state: suspend mode (PM_SUSPEND_xxx)
  */
-int mmc_suspend_host(struct mmc_host *host, u32 state)
+int mmc_suspend_host(struct mmc_host *host, pm_message_t state)
 {
 	mmc_claim_host(host);
 	mmc_deselect_cards(host);
diff -puN drivers/mmc/mmci.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi drivers/mmc/mmci.c
--- 25/drivers/mmc/mmci.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi	2005-04-12 03:21:30.197546176 -0700
+++ 25-akpm/drivers/mmc/mmci.c	2005-04-12 03:21:30.208544504 -0700
@@ -603,7 +603,7 @@ static int mmci_remove(struct amba_devic
 }
 
 #ifdef CONFIG_PM
-static int mmci_suspend(struct amba_device *dev, u32 state)
+static int mmci_suspend(struct amba_device *dev, pm_message_t state)
 {
 	struct mmc_host *mmc = amba_get_drvdata(dev);
 	int ret = 0;
diff -puN drivers/mmc/pxamci.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi drivers/mmc/pxamci.c
--- 25/drivers/mmc/pxamci.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi	2005-04-12 03:21:30.198546024 -0700
+++ 25-akpm/drivers/mmc/pxamci.c	2005-04-12 03:21:30.209544352 -0700
@@ -558,7 +558,7 @@ static int pxamci_remove(struct device *
 }
 
 #ifdef CONFIG_PM
-static int pxamci_suspend(struct device *dev, u32 state, u32 level)
+static int pxamci_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	int ret = 0;
diff -puN drivers/mmc/wbsd.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi drivers/mmc/wbsd.c
--- 25/drivers/mmc/wbsd.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi	2005-04-12 03:21:30.200545720 -0700
+++ 25-akpm/drivers/mmc/wbsd.c	2005-04-12 03:21:30.210544200 -0700
@@ -1563,7 +1563,7 @@ static int wbsd_remove(struct device* de
  */
 
 #ifdef CONFIG_PM
-static int wbsd_suspend(struct device *dev, u32 state, u32 level)
+static int wbsd_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	DBGF("Not yet supported\n");
 
diff -puN drivers/mtd/maps/sa1100-flash.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi drivers/mtd/maps/sa1100-flash.c
--- 25/drivers/mtd/maps/sa1100-flash.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi	2005-04-12 03:21:30.201545568 -0700
+++ 25-akpm/drivers/mtd/maps/sa1100-flash.c	2005-04-12 03:21:30.211544048 -0700
@@ -403,7 +403,7 @@ static int __exit sa1100_mtd_remove(stru
 }
 
 #ifdef CONFIG_PM
-static int sa1100_mtd_suspend(struct device *dev, u32 state, u32 level)
+static int sa1100_mtd_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct sa_info *info = dev_get_drvdata(dev);
 	int ret = 0;
diff -puN drivers/scsi/mesh.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi drivers/scsi/mesh.c
--- 25/drivers/scsi/mesh.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi	2005-04-12 03:21:30.203545264 -0700
+++ 25-akpm/drivers/scsi/mesh.c	2005-04-12 03:21:30.212543896 -0700
@@ -1757,7 +1757,7 @@ static void set_mesh_power(struct mesh_s
 
 
 #ifdef CONFIG_PM
-static int mesh_suspend(struct macio_dev *mdev, u32 state)
+static int mesh_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct mesh_state *ms = (struct mesh_state *)macio_get_drvdata(mdev);
 	unsigned long flags;
diff -puN drivers/scsi/nsp32.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi drivers/scsi/nsp32.c
--- 25/drivers/scsi/nsp32.c~fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi	2005-04-12 03:21:30.204545112 -0700
+++ 25-akpm/drivers/scsi/nsp32.c	2005-04-12 03:21:30.215543440 -0700
@@ -3435,7 +3435,7 @@ static int nsp32_prom_read_bit(nsp32_hw_
 #ifdef CONFIG_PM
 
 /* Device suspended */
-static int nsp32_suspend(struct pci_dev *pdev, u32 state)
+static int nsp32_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
 
@@ -3443,7 +3443,7 @@ static int nsp32_suspend(struct pci_dev 
 
 	pci_save_state     (pdev);
 	pci_disable_device (pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
@@ -3457,8 +3457,8 @@ static int nsp32_resume(struct pci_dev *
 
 	nsp32_msg(KERN_INFO, "pci-resume: pdev=0x%p, slot=%s, host=0x%p", pdev, pci_name(pdev), host);
 
-	pci_set_power_state(pdev, 0);
-	pci_enable_wake    (pdev, 0, 0);
+	pci_set_power_state(pdev, PCI_D0);
+	pci_enable_wake    (pdev, PCI_D0, 0);
 	pci_restore_state  (pdev);
 
 	reg = nsp32_read2(data->BaseAddress, INDEX_REG);
@@ -3479,7 +3479,7 @@ static int nsp32_resume(struct pci_dev *
 }
 
 /* Enable wake event */
-static int nsp32_enable_wake(struct pci_dev *pdev, u32 state, int enable)
+static int nsp32_enable_wake(struct pci_dev *pdev, pci_power_t state, int enable)
 {
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
 
_
