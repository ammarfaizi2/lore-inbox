Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVJYPVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVJYPVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 11:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVJYPVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 11:21:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:25008 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932181AbVJYPV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 11:21:26 -0400
Subject: [PATCH 3 of 6] tpm: change from pci_dev to dev power management
	functions
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Date: Tue, 25 Oct 2005 10:21:55 -0500
Message-Id: <1130253715.4839.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is in support of moving away from the lpc bus pci_dev.  The
power management prototypes used by platform drivers is different but
the functionality remains the same.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com
---

diff --exclude='*.o' --exclude='*.ko' --exclude='*.mod*' --exclude='tpm_*' --exclude='.*' --exclude='Makefile*' --exclude='Kconfig*' -uprN linux-2.6.13/drivers/char/tpm/tpm.c linux-2.6.13-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.13/drivers/char/tpm/tpm.c	2005-10-19 14:27:57.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm.c	2005-10-18 15:22:55.000000000 -0500
@@ -484,9 +484,9 @@ static u8 savestate[] = {
  * We are about to suspend. Save the TPM state
  * so that it can be restored.
  */
-int tpm_pm_suspend(struct pci_dev *pci_dev, pm_message_t pm_state)
+int tpm_pm_suspend(struct device *dev, pm_message_t pm_state, u32 level)
 {
-	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -500,9 +500,9 @@ EXPORT_SYMBOL_GPL(tpm_pm_suspend);
  * Resume from a power safe. The BIOS already restored
  * the TPM state.
  */
-int tpm_pm_resume(struct pci_dev *pci_dev)
+int tpm_pm_resume(struct device *dev, u32 level)
 {
-	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 
 	if (chip == NULL)
 		return -ENODEV;
diff --exclude='*.o' --exclude='*.ko' --exclude='*.mod*' --exclude='tpm_*' --exclude='.*' --exclude='Makefile*' --exclude='Kconfig*' -uprN linux-2.6.13/drivers/char/tpm/tpm.h linux-2.6.13-tpm/drivers/char/tpm/tpm.h
--- linux-2.6.13/drivers/char/tpm/tpm.h	2005-10-19 14:27:57.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm.h	2005-10-18 15:17:32.000000000 -0500
@@ -100,5 +100,5 @@ extern ssize_t tpm_write(struct file *, 
 			 loff_t *);
 extern ssize_t tpm_read(struct file *, char __user *, size_t, loff_t *);
 extern void tpm_remove_hardware(struct device *);
-extern int tpm_pm_suspend(struct pci_dev *, pm_message_t);
-extern int tpm_pm_resume(struct pci_dev *);
+extern int tpm_pm_suspend(struct device *, pm_message_t,u32);
+extern int tpm_pm_resume(struct device *, u32);


