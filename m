Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUAHRqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUAHRoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:44:17 -0500
Received: from AToulouse-105-1-16-198.w80-11.abo.wanadoo.fr ([80.11.14.198]:26884
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S265806AbUAHRmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:42:51 -0500
Date: Thu, 8 Jan 2004 18:43:53 +0100
From: =?iso-8859-15?B?Suly9G1lIEF1Z+k=?= <eguaj@free.fr>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Support for Toshiba Piccolo in drivers/ide/pci/generic.c
Message-ID: <20040108174353.GA1889@satellite.workgroup.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: none
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

The 2.4 kernel have support for settting/using DMA with the Toshiba
Piccolo IDE controller, but it seems it did not went into the 2.6.

So, here is a patch (taken from Alan Cox modifications) for the 2.6
kernel. Could you apply it on the current 2.6 tree ?

Thanks and happy new year,
Jérôme

-- 
<ESC>:r $HOME/.signature<CR>

--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="linux-2.6.1-rc2-toshiba-piccolo.patch"

--- linux-2.6.1-rc2/drivers/ide/pci/generic.c.old	2004-01-07 16:03:37.000000000 +0100
+++ linux-2.6.1-rc2/drivers/ide/pci/generic.c	2004-01-07 16:08:37.000000000 +0100
@@ -136,6 +136,7 @@
 	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
 	{ PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
 	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237_SATA,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
+	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_PICCOLO,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
 	{ 0, },
 };
 
--- linux-2.6.1-rc2/drivers/ide/pci/generic.h.old	2004-01-07 16:03:40.000000000 +0100
+++ linux-2.6.1-rc2/drivers/ide/pci/generic.h	2004-01-07 16:07:30.000000000 +0100
@@ -129,6 +129,18 @@
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
 		.extra		= 0,
+	},{	/* 10 */
+		.vendor		= PCI_VENDOR_ID_TOSHIBA,
+		.device		= PCI_DEVICE_ID_TOSHIBA_PICCOLO,
+		.name		= "Piccolo",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
 		.vendor		= 0,
 		.device		= 0,
--- linux-2.6.1-rc2/include/linux/pci_ids.h.old	2004-01-07 16:07:51.000000000 +0100
+++ linux-2.6.1-rc2/include/linux/pci_ids.h	2004-01-07 16:08:22.000000000 +0100
@@ -1355,6 +1355,7 @@
 #define PCI_DEVICE_ID_SBE_WANXL400	0x0104
 
 #define PCI_VENDOR_ID_TOSHIBA		0x1179
+#define PCI_DEVICE_ID_TOSHIBA_PICCOLO	0x0102
 #define PCI_DEVICE_ID_TOSHIBA_601	0x0601
 #define PCI_DEVICE_ID_TOSHIBA_TOPIC95	0x060a
 #define PCI_DEVICE_ID_TOSHIBA_TOPIC95_A 0x0603

--ZoaI/ZTpAVc4A5k6--
