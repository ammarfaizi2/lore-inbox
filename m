Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266628AbVBDWKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266628AbVBDWKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266412AbVBDWH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:07:57 -0500
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:62477 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP id S266224AbVBDWBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:01:39 -0500
Message-ID: <4203F188.5050509@gentoo.org>
Date: Fri, 04 Feb 2005 22:04:56 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: [-mm PATCH] driver model: PM type conversions in drivers/char
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050909010800060108070206"
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CxBWE-000Krj-Ma*3GZovODLfJA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050909010800060108070206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes PM driver model type checking for drivers/char.
Acked by Pavel Machek.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------050909010800060108070206
Content-Type: text/x-patch;
 name="char-pm-type-safety.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="char-pm-type-safety.patch"

diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/char/agp/efficeon-agp.c linux-dsd/drivers/char/agp/efficeon-agp.c
--- linux-2.6.11-rc2-mm2/drivers/char/agp/efficeon-agp.c	2005-02-02 21:55:19.000000000 +0000
+++ linux-dsd/drivers/char/agp/efficeon-agp.c	2005-02-02 21:45:01.000000000 +0000
@@ -408,7 +408,7 @@ static void __devexit agp_efficeon_remov
 	agp_put_bridge(bridge);
 }
 
-static int agp_efficeon_suspend(struct pci_dev *dev, u32 state)
+static int agp_efficeon_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return 0;
 }
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/char/s3c2410-rtc.c linux-dsd/drivers/char/s3c2410-rtc.c
--- linux-2.6.11-rc2-mm2/drivers/char/s3c2410-rtc.c	2005-02-02 21:54:16.000000000 +0000
+++ linux-dsd/drivers/char/s3c2410-rtc.c	2005-02-02 21:44:26.000000000 +0000
@@ -514,7 +514,7 @@ static struct timespec s3c2410_rtc_delta
 
 static int ticnt_save;
 
-static int s3c2410_rtc_suspend(struct device *dev, u32 state, u32 level)
+static int s3c2410_rtc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct rtc_time tm;
 	struct timespec time;
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/char/sonypi.c linux-dsd/drivers/char/sonypi.c
--- linux-2.6.11-rc2-mm2/drivers/char/sonypi.c	2005-02-02 21:54:16.000000000 +0000
+++ linux-dsd/drivers/char/sonypi.c	2005-02-02 21:44:45.000000000 +0000
@@ -693,7 +693,7 @@ static int sonypi_disable(void)
 #ifdef CONFIG_PM
 static int old_camera_power;
 
-static int sonypi_suspend(struct device *dev, u32 state, u32 level)
+static int sonypi_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_DISABLE) {
 		old_camera_power = sonypi_device.camera_power;
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/char/tpm/tpm.c linux-dsd/drivers/char/tpm/tpm.c
--- linux-2.6.11-rc2-mm2/drivers/char/tpm/tpm.c	2005-02-02 21:55:20.000000000 +0000
+++ linux-dsd/drivers/char/tpm/tpm.c	2005-02-02 21:45:18.000000000 +0000
@@ -564,7 +564,7 @@ static u8 savestate[] = {
  * We are about to suspend. Save the TPM state
  * so that it can be restored.
  */
-int tpm_pm_suspend(struct pci_dev *pci_dev, u32 pm_state)
+int tpm_pm_suspend(struct pci_dev *pci_dev, pm_message_t pm_state)
 {
 	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
 	if (chip == NULL)
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/char/tpm/tpm.h linux-dsd/drivers/char/tpm/tpm.h
--- linux-2.6.11-rc2-mm2/drivers/char/tpm/tpm.h	2005-02-02 21:55:20.000000000 +0000
+++ linux-dsd/drivers/char/tpm/tpm.h	2005-02-02 21:45:52.000000000 +0000
@@ -88,5 +88,5 @@ extern ssize_t tpm_write(struct file *, 
 			 loff_t *);
 extern ssize_t tpm_read(struct file *, char __user *, size_t, loff_t *);
 extern void __devexit tpm_remove(struct pci_dev *);
-extern int tpm_pm_suspend(struct pci_dev *, u32);
+extern int tpm_pm_suspend(struct pci_dev *, pm_message_t);
 extern int tpm_pm_resume(struct pci_dev *);

--------------050909010800060108070206--
