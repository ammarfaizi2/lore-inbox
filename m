Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263872AbTCUTg3>; Fri, 21 Mar 2003 14:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263871AbTCUTfZ>; Fri, 21 Mar 2003 14:35:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:133
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263869AbTCUTfD>; Fri, 21 Mar 2003 14:35:03 -0500
Date: Fri, 21 Mar 2003 20:50:13 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212050.h2LKoDYk026539@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: add ICH5 and Centrino to PIIX4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/piix.c linux-2.5.65-ac2/drivers/ide/pci/piix.c
--- linux-2.5.65/drivers/ide/pci/piix.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/piix.c	2003-03-21 14:38:22.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/piix.c	Version 0.42	January 11, 2003
+ *  linux/drivers/ide/pci/piix.c	Version 0.44	March 20, 2003
  *
  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
@@ -146,7 +146,9 @@
 			case PCI_DEVICE_ID_INTEL_82801BA_9:
 			case PCI_DEVICE_ID_INTEL_82801CA_10:
 			case PCI_DEVICE_ID_INTEL_82801CA_11:
+			case PCI_DEVICE_ID_INTEL_82801DB_10:
 			case PCI_DEVICE_ID_INTEL_82801DB_11:
+			case PCI_DEVICE_ID_INTEL_82801EB_11:
 			case PCI_DEVICE_ID_INTEL_82801E_11:
 				p += sprintf(p, "PIIX4 Ultra 100 ");
 				break;
@@ -279,7 +281,9 @@
 		case PCI_DEVICE_ID_INTEL_82801CA_10:
 		case PCI_DEVICE_ID_INTEL_82801CA_11:
 		case PCI_DEVICE_ID_INTEL_82801E_11:
+		case PCI_DEVICE_ID_INTEL_82801DB_10:
 		case PCI_DEVICE_ID_INTEL_82801DB_11:
+		case PCI_DEVICE_ID_INTEL_82801EB_11:
 			mode = 3;
 			break;
 		/* UDMA 66 capable */
@@ -551,7 +555,7 @@
 
 	drive->init_speed = 0;
 
-	if (id && (id->capability & 1) && drive->autodma) {
+	if ((id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (hwif->ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
@@ -605,7 +609,9 @@
 		case PCI_DEVICE_ID_INTEL_82801BA_9:
 		case PCI_DEVICE_ID_INTEL_82801CA_10:
 		case PCI_DEVICE_ID_INTEL_82801CA_11:
+		case PCI_DEVICE_ID_INTEL_82801DB_10:
 		case PCI_DEVICE_ID_INTEL_82801DB_11:
+		case PCI_DEVICE_ID_INTEL_82801EB_11:
 		case PCI_DEVICE_ID_INTEL_82801E_11:
 		{
 			unsigned int extra = 0;
@@ -794,7 +800,9 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_11,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_11,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_11, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_11,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_11, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_10,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17},
 	{ 0, },
 };
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/piix.h linux-2.5.65-ac2/drivers/ide/pci/piix.h
--- linux-2.5.65/drivers/ide/pci/piix.h	2003-02-10 18:38:02.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/piix.h	2003-03-20 18:41:31.000000000 +0000
@@ -251,6 +251,20 @@
 		.extra		= 0,
 	},{	/* 15 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_82801EB_11,
+		.name		= "ICH5",
+		.init_setup	= init_setup_piix,
+		.init_chipset	= init_chipset_piix,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_piix,
+		.init_dma	= init_dma_piix,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},{	/* 16 */
+		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_82801E_11,
 		.name		= "C-ICH",
 		.init_setup	= init_setup_piix,
@@ -263,6 +277,34 @@
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
+	},{	/* 17 */
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_82801DB_10,
+		.name		= "ICH4",
+		.init_setup	= init_setup_piix,
+		.init_chipset	= init_chipset_piix,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_piix,
+		.init_dma	= init_dma_piix,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},{	/* 17 */
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_82801DB_10,
+		.name		= "ICH4",
+		.init_setup	= init_setup_piix,
+		.init_chipset	= init_chipset_piix,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_piix,
+		.init_dma	= init_dma_piix,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
 		.vendor		= 0,
 		.device		= 0,
