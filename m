Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTBCWiE>; Mon, 3 Feb 2003 17:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTBCWh4>; Mon, 3 Feb 2003 17:37:56 -0500
Received: from pppoe-66-112-25-82.rb.spt.centurytel.net ([66.112.25.82]:18816
	"EHLO pioneer") by vger.kernel.org with ESMTP id <S267068AbTBCWhp>;
	Mon, 3 Feb 2003 17:37:45 -0500
Date: Mon, 3 Feb 2003 16:47:13 -0600
From: James Curbo <phoenix@sandwich.net>
To: linux-kernel@vger.kernel.org
Subject: [2.5.59] nforce2 IDE support for the amd74xx driver
Message-ID: <20030203224713.GA2625@carthage>
Reply-To: James Curbo <phoenix@sandwich.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The amd74xx IDE driver in 2.5.59 has support for the nforce IDE
controller, but not explicitly for the nforce2 IDE controller (which has
a different PCI ID, which is in the kernel already). I'm not sure if the
nforce and nforce2 controllers are identical, but I made a small patch
that made the amd74xx driver recognize the nforce2 IDE, and it boots for
me, seems to work fine, as my drives were tuned to their highest
transfer rate automatically (udma5). 

I don't know if this patch is proper or correct, but it Works for 
Me [tm]. Patch is attached.

-- 
James Curbo <hannibal@adtrw.org> <phoenix@sandwich.net>

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nforce2.patch"

diff -u linux-2.5.59-orig/drivers/ide/pci/amd74xx.c linux-2.5.59/drivers/ide/pci/amd74xx.c
--- linux-2.5.59-orig/drivers/ide/pci/amd74xx.c	2003-01-16 20:22:59.000000000 -0600
+++ linux-2.5.59/drivers/ide/pci/amd74xx.c	2003-02-03 15:39:25.000000000 -0600
@@ -60,6 +60,8 @@
 	{ PCI_DEVICE_ID_AMD_OPUS_7441, 0x00, 0x40, AMD_UDMA_100 },			/* AMD-768 Opus */
 	{ PCI_DEVICE_ID_AMD_8111_IDE,  0x00, 0x40, AMD_UDMA_100 },			/* AMD-8111 */
         { PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, 0x00, 0x50, AMD_UDMA_100 },                  /* nVidia nForce */
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, 0x00, 0x50, AMD_UDMA_100 },
+	/* nVidia nForce 2 */
 
 	{ 0 }
 };
@@ -446,6 +448,7 @@
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7441,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_IDE, 	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
 	{ 0, },
 };
 
diff -u linux-2.5.59-orig/drivers/ide/pci/amd74xx.h linux-2.5.59/drivers/ide/pci/amd74xx.h
--- linux-2.5.59-orig/drivers/ide/pci/amd74xx.h	2003-01-16 20:21:37.000000000 -0600
+++ linux-2.5.59/drivers/ide/pci/amd74xx.h	2003-02-03 15:36:02.000000000 -0600
@@ -110,6 +110,20 @@
 		.bootable	= ON_BOARD,
 		.extra		= 0,
 	},
+	{	/* 6 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,
+		.name		= "NFORCE2",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x01,0x01}, {0x50,0x02,0x02}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},
 	{
 		.vendor		= 0,
 		.device		= 0,

--ew6BAiZeqk4r7MaW--
