Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVDLTQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVDLTQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVDLTQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:16:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:41929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262204AbVDLKcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:33 -0400
Message-Id: <200504121032.j3CAWKD2005561@shell0.pdx.osdl.net>
Subject: [patch 106/198] Fix u32 vs. pm_message_t in drivers/char
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

Here are fixes for drivers/char.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/char/agp/efficeon-agp.c |    2 +-
 25-akpm/drivers/char/s3c2410-rtc.c      |    2 +-
 25-akpm/drivers/char/sonypi.c           |    2 +-
 25-akpm/drivers/char/tpm/tpm.c          |    2 +-
 25-akpm/drivers/char/tpm/tpm.h          |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/char/agp/efficeon-agp.c~fix-u32-vs-pm_message_t-in-drivers-char drivers/char/agp/efficeon-agp.c
--- 25/drivers/char/agp/efficeon-agp.c~fix-u32-vs-pm_message_t-in-drivers-char	2005-04-12 03:21:28.505803360 -0700
+++ 25-akpm/drivers/char/agp/efficeon-agp.c	2005-04-12 03:21:28.514801992 -0700
@@ -408,7 +408,7 @@ static void __devexit agp_efficeon_remov
 	agp_put_bridge(bridge);
 }
 
-static int agp_efficeon_suspend(struct pci_dev *dev, u32 state)
+static int agp_efficeon_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return 0;
 }
diff -puN drivers/char/s3c2410-rtc.c~fix-u32-vs-pm_message_t-in-drivers-char drivers/char/s3c2410-rtc.c
--- 25/drivers/char/s3c2410-rtc.c~fix-u32-vs-pm_message_t-in-drivers-char	2005-04-12 03:21:28.507803056 -0700
+++ 25-akpm/drivers/char/s3c2410-rtc.c	2005-04-12 03:21:28.514801992 -0700
@@ -515,7 +515,7 @@ static struct timespec s3c2410_rtc_delta
 
 static int ticnt_save;
 
-static int s3c2410_rtc_suspend(struct device *dev, u32 state, u32 level)
+static int s3c2410_rtc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct rtc_time tm;
 	struct timespec time;
diff -puN drivers/char/sonypi.c~fix-u32-vs-pm_message_t-in-drivers-char drivers/char/sonypi.c
--- 25/drivers/char/sonypi.c~fix-u32-vs-pm_message_t-in-drivers-char	2005-04-12 03:21:28.508802904 -0700
+++ 25-akpm/drivers/char/sonypi.c	2005-04-12 03:21:28.516801688 -0700
@@ -1103,7 +1103,7 @@ static int sonypi_disable(void)
 #ifdef CONFIG_PM
 static int old_camera_power;
 
-static int sonypi_suspend(struct device *dev, u32 state, u32 level)
+static int sonypi_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_DISABLE) {
 		old_camera_power = sonypi_device.camera_power;
diff -puN drivers/char/tpm/tpm.c~fix-u32-vs-pm_message_t-in-drivers-char drivers/char/tpm/tpm.c
--- 25/drivers/char/tpm/tpm.c~fix-u32-vs-pm_message_t-in-drivers-char	2005-04-12 03:21:28.510802600 -0700
+++ 25-akpm/drivers/char/tpm/tpm.c	2005-04-12 03:21:28.517801536 -0700
@@ -567,7 +567,7 @@ static u8 savestate[] = {
  * We are about to suspend. Save the TPM state
  * so that it can be restored.
  */
-int tpm_pm_suspend(struct pci_dev *pci_dev, u32 pm_state)
+int tpm_pm_suspend(struct pci_dev *pci_dev, pm_message_t pm_state)
 {
 	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
 	if (chip == NULL)
diff -puN drivers/char/tpm/tpm.h~fix-u32-vs-pm_message_t-in-drivers-char drivers/char/tpm/tpm.h
--- 25/drivers/char/tpm/tpm.h~fix-u32-vs-pm_message_t-in-drivers-char	2005-04-12 03:21:28.511802448 -0700
+++ 25-akpm/drivers/char/tpm/tpm.h	2005-04-12 03:21:28.517801536 -0700
@@ -89,5 +89,5 @@ extern ssize_t tpm_write(struct file *, 
 			 loff_t *);
 extern ssize_t tpm_read(struct file *, char __user *, size_t, loff_t *);
 extern void __devexit tpm_remove(struct pci_dev *);
-extern int tpm_pm_suspend(struct pci_dev *, u32);
+extern int tpm_pm_suspend(struct pci_dev *, pm_message_t);
 extern int tpm_pm_resume(struct pci_dev *);
_
