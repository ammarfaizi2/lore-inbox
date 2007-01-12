Return-Path: <linux-kernel-owner+w=401wt.eu-S1030525AbXALE0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbXALE0N (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbXALEYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:24:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34837 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030488AbXALEXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:23:40 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=HeI5CvqM9N+nZTr2nsmX0+gFu0l15s9xx58brsrtRnLXYw4A1/sW9edb7CGU0VPWBlSae8dsKir+bH+Iihr2d164QpxAGB2GT6jzRyg+rrNouM7exbY9U/ik9PZSwUcKxU5pbsI4vfPquoYiHoLkT71H+NKI0ZaXr/R6cviidWc=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:27:16 +0100
Message-Id: <20070112042716.28794.40732.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 11/19] ide: remove ide_pci_device_t tables with only one entry
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: remove ide_pci_device_t tables with only one entry

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/cy82c693.c |   21 +++++++++------------
 drivers/ide/pci/sgiioc4.c  |    7 ++-----
 2 files changed, 11 insertions(+), 17 deletions(-)

Index: a/drivers/ide/pci/cy82c693.c
===================================================================
--- a.orig/drivers/ide/pci/cy82c693.c
+++ a/drivers/ide/pci/cy82c693.c
@@ -478,21 +478,18 @@ static void __devinit init_iops_cy82c693
 	}
 }
 
-static ide_pci_device_t cy82c693_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "CY82C693",
-		.init_chipset	= init_chipset_cy82c693,
-		.init_iops	= init_iops_cy82c693,
-		.init_hwif	= init_hwif_cy82c693,
-		.channels	= 1,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
+static ide_pci_device_t cy82c693_chipset __devinitdata = {
+	.name		= "CY82C693",
+	.init_chipset	= init_chipset_cy82c693,
+	.init_iops	= init_iops_cy82c693,
+	.init_hwif	= init_hwif_cy82c693,
+	.channels	= 1,
+	.autodma	= AUTODMA,
+	.bootable	= ON_BOARD,
 };
 
 static int __devinit cy82c693_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &cy82c693_chipsets[id->driver_data];
 	struct pci_dev *dev2;
 	int ret = -ENODEV;
 
@@ -501,7 +498,7 @@ static int __devinit cy82c693_init_one(s
         if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE &&
 	    PCI_FUNC(dev->devfn) == 1) {
 		dev2 = pci_get_slot(dev->bus, dev->devfn + 1);
-		ret = ide_setup_pci_devices(dev, dev2, d);
+		ret = ide_setup_pci_devices(dev, dev2, &cy82c693_chipset);
 		/* We leak pci refs here but thats ok - we can't be unloaded */
 	}
 	return ret;
Index: a/drivers/ide/pci/sgiioc4.c
===================================================================
--- a.orig/drivers/ide/pci/sgiioc4.c
+++ a/drivers/ide/pci/sgiioc4.c
@@ -729,8 +729,7 @@ out:
 	return ret;
 }
 
-static ide_pci_device_t sgiioc4_chipsets[] __devinitdata = {
-	{
+static ide_pci_device_t sgiioc4_chipset __devinitdata = {
 	 /* Channel 0 */
 	 .name = "SGIIOC4",
 	 .init_hwif = ide_init_sgiioc4,
@@ -739,7 +738,6 @@ static ide_pci_device_t sgiioc4_chipsets
 	 .autodma = AUTODMA,
 	 /* SGI IOC4 doesn't have enablebits. */
 	 .bootable = ON_BOARD,
-	}
 };
 
 int
@@ -751,8 +749,7 @@ ioc4_ide_attach_one(struct ioc4_driver_d
 	if (idd->idd_variant == IOC4_VARIANT_PCI_RT)
 		return 0;
 
-	return pci_init_sgiioc4(idd->idd_pdev,
-				&sgiioc4_chipsets[idd->idd_pci_id->driver_data]);
+	return pci_init_sgiioc4(idd->idd_pdev, &sgiioc4_chipset);
 }
 
 static struct ioc4_submodule ioc4_ide_submodule = {
