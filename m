Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbTIRDre (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 23:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbTIRDre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 23:47:34 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:60682 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S262947AbTIRDrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 23:47:20 -0400
Message-ID: <8F12FC8F99F4404BA86AC90CD0BFB04F039F7133@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "Andre Hedrick (andre@linux-ide.org)" <andre@linux-ide.org>
Cc: "LKML (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.23-pre4 support for new nForce IDE controllers
Date: Wed, 17 Sep 2003 20:47:13 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for some new and upcoming NVIDIA nForce IDE controllers to
the combined AMD / NVIDIA IDE driver.  I've also added support for udma6
(Ultra 133) as a separate patch that depends on this patch.


diff -ru -X dontdiff linux-2.4.23-pre4/drivers/ide/pci/amd74xx.c
linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.c
--- linux-2.4.23-pre4/drivers/ide/pci/amd74xx.c	2003-06-13
07:51:33.000000000 -0700
+++ linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.c	2003-09-17
19:58:46.000000000 -0700
@@ -60,7 +60,13 @@
 	{ PCI_DEVICE_ID_AMD_OPUS_7441, 0x00, 0x40, AMD_UDMA_100 },
/* AMD-768 Opus */
 	{ PCI_DEVICE_ID_AMD_8111_IDE,  0x00, 0x40, AMD_UDMA_100 },
/* AMD-8111 */
         { PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, 0x00, 0x50, AMD_UDMA_100 },
/* nVidia nForce */
-        { PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, 0x00, 0x50, AMD_UDMA_100 },
/* nVidia nForce */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, 0x00, 0x50, AMD_UDMA_100 },
/* nVidia nForce2 */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE, 0x00, 0x50, AMD_UDMA_100 },
/* nVidia nForce2s */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA, 0x00, 0x50, AMD_UDMA_100 },
/* nVidia nForce2s SATA */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE, 0x00, 0x50, AMD_UDMA_100 },
/* NVIDIA nForce3 */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE, 0x00, 0x50, AMD_UDMA_100 },
/* NVIDIA nForce3s */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA, 0x00, 0x50, AMD_UDMA_100 },
/* NVIDIA nForce3s SATA */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2, 0x00, 0x50, AMD_UDMA_100 },
/* NVIDIA nForce3s SATA2 */
 
 	{ 0 }
 };
@@ -454,6 +460,12 @@
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_IDE, 	PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 4},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 5},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
 	{ 0, },
 };
 
diff -ru -X dontdiff linux-2.4.23-pre4/drivers/ide/pci/amd74xx.h
linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.h
--- linux-2.4.23-pre4/drivers/ide/pci/amd74xx.h	2003-09-17
18:59:27.000000000 -0700
+++ linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.h	2003-09-17
19:59:15.000000000 -0700
@@ -124,6 +124,90 @@
 		.bootable	= ON_BOARD,
 		.extra		= 0,
 	},
+	{	/* 7 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,
+		.name		= "NFORCE2",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},
+	{	/* 8 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
+		.name		= "NFORCE2",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},
+	{	/* 9 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,
+		.name		= "NFORCE3",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},
+	{	/* 10 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,
+		.name		= "NFORCE3",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},
+	{	/* 11 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
+		.name		= "NFORCE3",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},
+	{	/* 12 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
+		.name		= "NFORCE3",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},
 	{
 		.vendor		= 0,
 		.device		= 0,
diff -ru -X dontdiff linux-2.4.23-pre4/include/linux/pci_ids.h
linux-2.4.23-pre4-nvide/include/linux/pci_ids.h
--- linux-2.4.23-pre4/include/linux/pci_ids.h	2003-09-17
18:56:36.000000000 -0700
+++ linux-2.4.23-pre4-nvide/include/linux/pci_ids.h	2003-09-17
19:58:46.000000000 -0700
@@ -966,7 +966,13 @@
 #define PCI_DEVICE_ID_NVIDIA_VTNT2		0x002C
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
+#define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085
+#define PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA	0x008e
 #define PCI_DEVICE_ID_NVIDIA_ITNT2		0x00A0
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA	0x00e3
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE	0x00e5
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2	0x00ee
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR	0x0100
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR	0x0101
 #define PCI_DEVICE_ID_NVIDIA_QUADRO		0x0103
