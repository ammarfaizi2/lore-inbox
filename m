Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVDBVLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVDBVLz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVDBVLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:11:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30125 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261283AbVDBVKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:10:25 -0500
Date: Sat, 2 Apr 2005 23:09:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Fix u32 vs. pm_message_t in drivers/char
Message-ID: <20050402210958.GA2041@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here are fixes for drivers/char. [These patches are independend and
change no object code; therefore not numbered].

Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
                                                        Pavel

--- clean-cvs/drivers/char/agp/efficeon-agp.c	2005-03-29 13:29:41.000000000 +0200
+++ linux-cvs/drivers/char/agp/efficeon-agp.c	2005-03-31 23:54:43.000000000 +0200
@@ -408,7 +408,7 @@
 	agp_put_bridge(bridge);
 }
 
-static int agp_efficeon_suspend(struct pci_dev *dev, u32 state)
+static int agp_efficeon_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return 0;
 }
--- clean-cvs/drivers/char/s3c2410-rtc.c	2005-03-29 13:29:40.000000000 +0200
+++ linux-cvs/drivers/char/s3c2410-rtc.c	2005-03-31 23:54:43.000000000 +0200
@@ -515,7 +515,7 @@
 
 static int ticnt_save;
 
-static int s3c2410_rtc_suspend(struct device *dev, u32 state, u32 level)
+static int s3c2410_rtc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct rtc_time tm;
 	struct timespec time;
--- clean-cvs/drivers/char/sonypi.c	2005-03-29 13:29:40.000000000 +0200
+++ linux-cvs/drivers/char/sonypi.c	2005-03-31 23:54:43.000000000 +0200
@@ -1103,7 +1103,7 @@
 #ifdef CONFIG_PM
 static int old_camera_power;
 
-static int sonypi_suspend(struct device *dev, u32 state, u32 level)
+static int sonypi_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_DISABLE) {
 		old_camera_power = sonypi_device.camera_power;
--- clean-cvs/drivers/char/tpm/tpm.c	2005-03-31 23:33:09.000000000 +0200
+++ linux-cvs/drivers/char/tpm/tpm.c	2005-03-31 23:54:43.000000000 +0200
@@ -567,7 +567,7 @@
  * We are about to suspend. Save the TPM state
  * so that it can be restored.
  */
-int tpm_pm_suspend(struct pci_dev *pci_dev, u32 pm_state)
+int tpm_pm_suspend(struct pci_dev *pci_dev, pm_message_t pm_state)
 {
 	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
 	if (chip == NULL)
--- clean-cvs/drivers/char/tpm/tpm.h	2005-03-31 23:33:09.000000000 +0200
+++ linux-cvs/drivers/char/tpm/tpm.h	2005-03-31 23:54:43.000000000 +0200
@@ -89,5 +89,5 @@
 			 loff_t *);
 extern ssize_t tpm_read(struct file *, char __user *, size_t, loff_t *);
 extern void __devexit tpm_remove(struct pci_dev *);
-extern int tpm_pm_suspend(struct pci_dev *, u32);
+extern int tpm_pm_suspend(struct pci_dev *, pm_message_t);
 extern int tpm_pm_resume(struct pci_dev *);


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
