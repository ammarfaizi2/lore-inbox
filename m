Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315428AbSESWe7>; Sun, 19 May 2002 18:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSESWe6>; Sun, 19 May 2002 18:34:58 -0400
Received: from hera.cwi.nl ([192.16.191.8]:27587 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315428AbSESWe4>;
	Sun, 19 May 2002 18:34:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 20 May 2002 00:34:55 +0200 (MEST)
Message-Id: <UTC200205192234.g4JMYtZ24518.aeb@smtp.cwi.nl>
To: dalecki@evision-ventures.com
Subject: [PATCH] HPT366 again
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Martin,

Earlier this evening I wanted to test my new usb-storage code,
but saw that both IDE and USB are broken for me under 2.5.16.
The IDE part must be familiar to you, we had this conversation
already once.

With CONFIG_BLK_DEV_IDEDMA_PCI and CONFIG_BLK_DEV_HPT366, that is,
when hpt366.c is compiled in, my 2.5.16 kernel hangs at boot,
trying to read the partition table from a disk that hangs off
an off-board HPT366.

Without these options, that is, without hpt366.c, this board and
the disks hanging off it are not seen at all.
The below patch makes them visible again in the latter case.

Andries

--- ide-pci.c~	Sat May 18 16:25:57 2002
+++ ide-pci.c	Mon May 20 00:18:24 2002
@@ -764,7 +764,7 @@
 		vendor: PCI_VENDOR_ID_INTEL,
 		device: PCI_DEVICE_ID_INTEL_82371MX,
 		enablebits: {{0x6D,0x80,0x80}, {0x00,0x00,0x00}},
-		bootable: ON_BOARD, 0,
+		bootable: ON_BOARD,
 		flags: ATA_F_NODMA
 	},
 	{
@@ -790,6 +790,13 @@
 		device: PCI_DEVICE_ID_VIA_82C561,
 		bootable: ON_BOARD,
 		flags: ATA_F_NOADMA
+	},
+	{
+		vendor: PCI_VENDOR_ID_TTI,
+		device: PCI_DEVICE_ID_TTI_HPT366,
+		bootable: OFF_BOARD,
+		extra: 240,
+		flags: ATA_F_IRQ | ATA_F_HPTHACK
 	}
 };
 
