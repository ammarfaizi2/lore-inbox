Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVDBVsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVDBVsw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVDBVjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:39:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51404 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261401AbVDBVaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:30:15 -0500
Date: Sat, 2 Apr 2005 23:29:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: fix u32 vs. pm_message_t in drivers/mmc,mtd,scsi
Message-ID: <20050402212954.GA2152@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes u32 vs. pm_message_t in drivers/mmc, drivers/mtd and
drivers/scsi. [These patches are independend and change no object
code; therefore not numbered].

This is last of the series. I tried to submit patches through their
mainainers (when they were easy to determine, our MAINTAINERS file
sucks). Unfortunately that probably means some patches will fail to
propagate and I'll have to fix up after -rc2 or something. Hopefully
diff will be fairly small by that time.

Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
                                                        Pavel

--- clean-cvs/drivers/mmc/mmc.c	2005-01-04 11:40:44.000000000 +0100
+++ linux-cvs/drivers/mmc/mmc.c	2005-03-31 23:54:45.000000000 +0200
@@ -884,7 +884,7 @@
  *	@host: mmc host
  *	@state: suspend mode (PM_SUSPEND_xxx)
  */
-int mmc_suspend_host(struct mmc_host *host, u32 state)
+int mmc_suspend_host(struct mmc_host *host, pm_message_t state)
 {
 	mmc_claim_host(host);
 	mmc_deselect_cards(host);
--- clean-cvs/drivers/mmc/mmci.c	2005-01-11 01:37:06.000000000 +0100
+++ linux-cvs/drivers/mmc/mmci.c	2005-03-31 23:54:46.000000000 +0200
@@ -603,7 +603,7 @@
 }
 
 #ifdef CONFIG_PM
-static int mmci_suspend(struct amba_device *dev, u32 state)
+static int mmci_suspend(struct amba_device *dev, pm_message_t state)
 {
 	struct mmc_host *mmc = amba_get_drvdata(dev);
 	int ret = 0;
--- clean-cvs/drivers/mmc/pxamci.c	2005-03-29 13:29:59.000000000 +0200
+++ linux-cvs/drivers/mmc/pxamci.c	2005-03-31 23:54:46.000000000 +0200
@@ -558,7 +558,7 @@
 }
 
 #ifdef CONFIG_PM
-static int pxamci_suspend(struct device *dev, u32 state, u32 level)
+static int pxamci_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	int ret = 0;
--- clean-cvs/drivers/mmc/wbsd.c	2005-01-31 00:27:36.000000000 +0100
+++ linux-cvs/drivers/mmc/wbsd.c	2005-03-31 23:54:46.000000000 +0200
@@ -1563,7 +1563,7 @@
  */
 
 #ifdef CONFIG_PM
-static int wbsd_suspend(struct device *dev, u32 state, u32 level)
+static int wbsd_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	DBGF("Not yet supported\n");
 
--- clean-cvs/drivers/mtd/maps/sa1100-flash.c	2004-11-19 12:19:52.000000000 +0100
+++ linux-cvs/drivers/mtd/maps/sa1100-flash.c	2005-03-31 23:54:46.000000000 +0200
@@ -403,7 +403,7 @@
 }
 
 #ifdef CONFIG_PM
-static int sa1100_mtd_suspend(struct device *dev, u32 state, u32 level)
+static int sa1100_mtd_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct sa_info *info = dev_get_drvdata(dev);
 	int ret = 0;
 
--- clean-cvs/drivers/scsi/mesh.c	2004-12-09 21:46:11.000000000 +0100
+++ linux-cvs/drivers/scsi/mesh.c	2005-03-31 23:54:47.000000000 +0200
@@ -1757,7 +1757,7 @@
 
 
 #ifdef CONFIG_PM
-static int mesh_suspend(struct macio_dev *mdev, u32 state)
+static int mesh_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct mesh_state *ms = (struct mesh_state *)macio_get_drvdata(mdev);
 	unsigned long flags;
--- clean-cvs/drivers/scsi/nsp32.c	2005-01-11 01:37:23.000000000 +0100
+++ linux-cvs/drivers/scsi/nsp32.c	2005-03-31 23:54:47.000000000 +0200
@@ -3435,7 +3435,7 @@
 #ifdef CONFIG_PM
 
 /* Device suspended */
-static int nsp32_suspend(struct pci_dev *pdev, u32 state)
+static int nsp32_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
 
@@ -3443,7 +3443,7 @@
 
 	pci_save_state     (pdev);
 	pci_disable_device (pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
@@ -3457,8 +3457,8 @@
 
 	nsp32_msg(KERN_INFO, "pci-resume: pdev=0x%p, slot=%s, host=0x%p", pdev, pci_name(pdev), host);
 
-	pci_set_power_state(pdev, 0);
-	pci_enable_wake    (pdev, 0, 0);
+	pci_set_power_state(pdev, PCI_D0);
+	pci_enable_wake    (pdev, PCI_D0, 0);
 	pci_restore_state  (pdev);
 
 	reg = nsp32_read2(data->BaseAddress, INDEX_REG);
@@ -3479,7 +3479,7 @@
 }
 
 /* Enable wake event */
-static int nsp32_enable_wake(struct pci_dev *pdev, u32 state, int enable)
+static int nsp32_enable_wake(struct pci_dev *pdev, pci_power_t state, int enable)
 {
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
