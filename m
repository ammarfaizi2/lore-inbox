Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVBDHiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVBDHiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVBDHfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:35:55 -0500
Received: from [211.58.254.17] ([211.58.254.17]:40617 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263292AbVBDHNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:13:23 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 07/14] ide_pci: Merges it8172.h into it8172.c
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42032014.1020606@home-tj.org>
References: <42032014.1020606@home-tj.org>
Message-Id: <20050204071318.9595F132656@htj.dyndns.org>
Date: Fri,  4 Feb 2005 16:13:18 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


07_ide_pci_it8172_merge.patch

	Merges ide/pci/it8172.h into it8172.c.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/it8172.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/it8172.c	2005-02-04 16:07:36.750383827 +0900
+++ linux-idepci-export/drivers/ide/pci/it8172.c	2005-02-04 16:08:25.574432096 +0900
@@ -42,8 +42,6 @@
 #include <asm/io.h>
 #include <asm/it8172/it8172_int.h>
 
-#include "it8172.h"
-
 /*
  * Prototypes
  */
@@ -266,6 +264,18 @@ static void __init init_hwif_it8172 (ide
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+static ide_pci_device_t it8172_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "IT8172G",
+		.init_chipset	= init_chipset_it8172,
+		.init_hwif	= init_hwif_it8172,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x40,0x00,0x01}},
+		.bootable	= ON_BOARD,
+	}
+};
+
 static int __devinit it8172_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
         if ((!(PCI_FUNC(dev->devfn) & 1) ||
Index: linux-idepci-export/drivers/ide/pci/it8172.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/it8172.h	2005-02-04 16:07:36.750383827 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,31 +0,0 @@
-#ifndef ITE8172G_H
-#define ITE8172G_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-static u8 it8172_ratemask(ide_drive_t *drive);
-static void it8172_tune_drive(ide_drive_t *drive, u8 pio);
-static u8 it8172_dma_2_pio(u8 xfer_rate);
-static int it8172_tune_chipset(ide_drive_t *drive, u8 xferspeed);
-#ifdef CONFIG_BLK_DEV_IDEDMA
-static int it8172_config_chipset_for_dma(ide_drive_t *drive);
-#endif
-
-static unsigned int init_chipset_it8172(struct pci_dev *, const char *);
-static void init_hwif_it8172(ide_hwif_t *);
-
-static ide_pci_device_t it8172_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "IT8172G",
-		.init_chipset	= init_chipset_it8172,
-		.init_hwif	= init_hwif_it8172,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x40,0x00,0x01}},
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* ITE8172G_H */
