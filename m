Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbTBLTiu>; Wed, 12 Feb 2003 14:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267597AbTBLTiu>; Wed, 12 Feb 2003 14:38:50 -0500
Received: from www.goron.de ([62.208.59.25]:35214 "EHLO www.goron.de")
	by vger.kernel.org with ESMTP id <S267581AbTBLTit>;
	Wed, 12 Feb 2003 14:38:49 -0500
Date: Wed, 12 Feb 2003 20:48:15 +0100
From: Andreas Arens <ari@goron.de>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] AMD IDE oops in current 2.4-ac
Message-ID: <20030212204815.A8782@www.goron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current 2.4.21-pre4-ac kernels oops in amd74xx.c with
certain chipsets due to a table order problem. The
problem is correctly detected by a BUG() in the pci probe
routine, which should trigger for all non-nforce chipsets.

Regards
Andy

The fix, tested on a 7409 Viper board, is simple:

--- linux-2.4.21-pre4-ac4/drivers/ide/pci/amd74xx.c	Wed Feb 12 00:19:56 2003
+++ linux/drivers/ide/pci/amd74xx.c	Tue Feb 11 23:26:32 2003
@@ -54,11 +54,11 @@
 	unsigned long base;
 	unsigned char flags;
 } amd_ide_chips[] = {
-	{ PCI_DEVICE_ID_AMD_8111_IDE,  0x00, 0x40, AMD_UDMA_100 },			/* AMD-8111 */
-	{ PCI_DEVICE_ID_AMD_OPUS_7441, 0x00, 0x40, AMD_UDMA_100 },			/* AMD-768 Opus */
-	{ PCI_DEVICE_ID_AMD_VIPER_7411, 0x00, 0x40, AMD_UDMA_100 | AMD_BAD_FIFO },	/* AMD-766 Viper */
-	{ PCI_DEVICE_ID_AMD_VIPER_7409, 0x00, 0x40, AMD_UDMA_66 | AMD_CHECK_SWDMA },	/* AMD-756 Viper */
 	{ PCI_DEVICE_ID_AMD_COBRA_7401, 0x00, 0x40, AMD_UDMA_33 | AMD_BAD_SWDMA },	/* AMD-755 Cobra */
+	{ PCI_DEVICE_ID_AMD_VIPER_7409, 0x00, 0x40, AMD_UDMA_66 | AMD_CHECK_SWDMA },	/* AMD-756 Viper */
+	{ PCI_DEVICE_ID_AMD_VIPER_7411, 0x00, 0x40, AMD_UDMA_100 | AMD_BAD_FIFO },	/* AMD-766 Viper */
+	{ PCI_DEVICE_ID_AMD_OPUS_7441, 0x00, 0x40, AMD_UDMA_100 },			/* AMD-768 Opus */
+	{ PCI_DEVICE_ID_AMD_8111_IDE,  0x00, 0x40, AMD_UDMA_100 },			/* AMD-8111 */
         { PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, 0x00, 0x50, AMD_UDMA_100 },                  /* nVidia nForce */
         { PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, 0x00, 0x50, AMD_UDMA_100 },                  /* nVidia nForce */
 


