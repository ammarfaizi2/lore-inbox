Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbUKWHX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbUKWHX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 02:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbUKWHX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 02:23:57 -0500
Received: from pv106075.reshsg.uci.edu ([128.195.106.75]:135 "EHLO
	alpha.blx4.net") by vger.kernel.org with ESMTP id S262281AbUKWHXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 02:23:52 -0500
Message-ID: <41A2E581.2010305@blx4.net>
Date: Mon, 22 Nov 2004 23:23:45 -0800
From: Mathias Kretschmer <posting@blx4.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VIA VT610 IDE support for 2.4.28 (trivial)
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030800020704010909080507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030800020704010909080507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

hi,

I found an older version of this patch (against 2.4.22) on some website. 
After a little bit of editing it applied cleanly to 2.4.27 (and now 
2.4.28). It works fine for me on a ASUS P4P800-Deluxe with 4x 300GB disks.

Maybe someone finds this patch helpful. Any reason why the original 
patch did not make it into the kernel ?

-Mathias

--------------030800020704010909080507
Content-Type: text/plain;
 name="2.4.28-vt610.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.28-vt610.patch"

diff -u -r -N linux-2.4.28/drivers/ide/pci/generic.c linux-2.4.28-vt610/drivers/ide/pci/generic.c
--- linux-2.4.28/drivers/ide/pci/generic.c	2004-08-07 16:26:04.000000000 -0700
+++ linux-2.4.28-vt610/drivers/ide/pci/generic.c	2004-11-22 21:50:25.000000000 -0800
@@ -66,6 +66,9 @@
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
+	if (hwif->pci_dev->device == PCI_DEVICE_ID_VIA_610) 
+   		hwif->udma_four = 1; /* mj */
+
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;
@@ -143,6 +146,7 @@
 	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_PICCOLO,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
 	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
 	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
+	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_610,             PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
 	{ 0, },
 };
 
diff -u -r -N linux-2.4.28/drivers/ide/pci/generic.h linux-2.4.28-vt610/drivers/ide/pci/generic.h
--- linux-2.4.28/drivers/ide/pci/generic.h	2004-08-07 16:26:04.000000000 -0700
+++ linux-2.4.28-vt610/drivers/ide/pci/generic.h	2004-11-22 21:50:13.000000000 -0800
@@ -157,6 +157,19 @@
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
+	},{	/* 12 */
+	        .vendor         = PCI_VENDOR_ID_VIA,
+	        .device         = PCI_DEVICE_ID_VIA_610,
+	        .name           = "VIA_610",
+	        .init_chipset   = init_chipset_generic,
+	        .init_iops      = NULL,
+	        .init_hwif      = init_hwif_generic,
+	        .init_dma       = init_dma_generic,
+	        .channels       = 2,
+	        .autodma        = AUTODMA,
+	        .enablebits     = {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+	        .bootable       = ON_BOARD,
+	        .extra          = 0,
 	},{
 		.vendor		= 0,
 		.device		= 0,
diff -u -r -N linux-2.4.28/include/linux/pci_ids.h linux-2.4.28-vt610/include/linux/pci_ids.h
--- linux-2.4.28/include/linux/pci_ids.h	2004-11-17 03:54:22.000000000 -0800
+++ linux-2.4.28-vt610/include/linux/pci_ids.h	2004-11-22 21:54:09.000000000 -0800
@@ -1123,6 +1123,7 @@
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
 #define PCI_DEVICE_ID_VIA_P4M266	0x3148
 #define PCI_DEVICE_ID_VIA_8237_SATA	0x3149
+#define PCI_DEVICE_ID_VIA_610		0x3164
 #define PCI_DEVICE_ID_VIA_P4X333	0x3168
 #define PCI_DEVICE_ID_VIA_8235		0x3177
 #define PCI_DEVICE_ID_VIA_8377_0	0x3189

--------------030800020704010909080507--
