Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264291AbUDVQG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUDVQG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbUDVQGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:06:18 -0400
Received: from cpc2-hitc2-5-0-cust191.lutn.cable.ntl.com ([81.99.81.191]:42185
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S264259AbUDVQDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:03:45 -0400
Message-ID: <4087ED73.5010700@gentoo.org>
Date: Thu, 22 Apr 2004 17:06:11 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040409)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       b.w.schofield@durham.ac.uk, eguaj@free.fr
Subject: [PATCH 2.4] Generic IDE support for more Toshiba Piccolo PCI IDE
 chips
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010105080209040200070300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010105080209040200070300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adds more Toshiba IDE chips to the list supported by the generic IDE driver,
for chips with product ID 0x0103 and 0x0105
This then allows DMA to be enabled on disks.

For more info, see:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0401.1/0150.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0402.0/0129.html
(it appears that Ben's patch never appeared, and Jerome's got lost)

Against 2.4.27-pre1

Please apply,

Daniel

--------------010105080209040200070300
Content-Type: text/plain;
 name="2.4.27-pre1-toshiba-generic-ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.27-pre1-toshiba-generic-ide.patch"

Generic IDE support for more Toshiba Piccolo PCI IDE chips (2.4)

diff -uprN linux-2.4.27-pre1/drivers/ide/pci/generic.c linux-dsd/drivers/ide/pci/generic.c
--- linux-2.4.27-pre1/drivers/ide/pci/generic.c	2003-08-25 12:44:41.000000000 +0100
+++ linux-dsd/drivers/ide/pci/generic.c	2004-04-22 16:39:11.943189096 +0100
@@ -141,6 +141,8 @@ static struct pci_device_id generic_pci_
 	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
 	{ PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
 	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_PICCOLO,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
+	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
+	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
 	{ 0, },
 };
 
diff -uprN linux-2.4.27-pre1/drivers/ide/pci/generic.h linux-dsd/drivers/ide/pci/generic.h
--- linux-2.4.27-pre1/drivers/ide/pci/generic.h	2004-04-14 14:05:29.000000000 +0100
+++ linux-dsd/drivers/ide/pci/generic.h	2004-04-22 16:42:12.813692600 +0100
@@ -130,7 +130,33 @@ static ide_pci_device_t generic_chipsets
 	},{	/* 9 */
 		.vendor		= PCI_VENDOR_ID_TOSHIBA,
 		.device		= PCI_DEVICE_ID_TOSHIBA_PICCOLO,
-		.name		= "Piccolo",
+		.name		= "Piccolo0102",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},{	/* 10 */
+		.vendor		= PCI_VENDOR_ID_TOSHIBA,
+		.device		= PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,
+		.name		= "Piccolo0103",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},{	/* 11 */
+		.vendor		= PCI_VENDOR_ID_TOSHIBA,
+		.device		= PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,
+		.name		= "Piccolo0105",
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
diff -uprN linux-2.4.27-pre1/include/linux/pci_ids.h linux-dsd/include/linux/pci_ids.h
--- linux-2.4.27-pre1/include/linux/pci_ids.h	2004-04-14 14:05:40.000000000 +0100
+++ linux-dsd/include/linux/pci_ids.h	2004-04-22 16:43:00.571432320 +0100
@@ -1269,6 +1269,8 @@
 
 #define PCI_VENDOR_ID_TOSHIBA		0x1179
 #define PCI_DEVICE_ID_TOSHIBA_PICCOLO	0x0102
+#define PCI_DEVICE_ID_TOSHIBA_PICCOLO_1	0x0103
+#define PCI_DEVICE_ID_TOSHIBA_PICCOLO_2	0x0105
 #define PCI_DEVICE_ID_TOSHIBA_601	0x0601
 #define PCI_DEVICE_ID_TOSHIBA_TOPIC95	0x060a
 #define PCI_DEVICE_ID_TOSHIBA_TOPIC97	0x060f

--------------010105080209040200070300--
