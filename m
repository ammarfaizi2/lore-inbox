Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264188AbUDVQG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbUDVQG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUDVQGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:06:02 -0400
Received: from cpc2-hitc2-5-0-cust191.lutn.cable.ntl.com ([81.99.81.191]:40649
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S264188AbUDVQDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:03:25 -0400
Message-ID: <4087ED5E.9070808@gentoo.org>
Date: Thu, 22 Apr 2004 17:05:50 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040409)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       b.w.schofield@durham.ac.uk, eguaj@free.fr
Subject: [PATCH 2.6] Generic IDE support for Toshiba Piccolo PCI IDE chips
 (2.6)
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040103080406030303070303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040103080406030303070303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adds Toshiba IDE chips to the list supported by the generic IDE driver.
The 2.4 tree already contained an entry for product:0x0102, this patch
adds that entry to 2.6 as well as two new ones (0x0103 and 0x0105).
This then allows DMA to be enabled on disks.

For more info, see:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0401.1/0150.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0402.0/0129.html
(it appears that Ben's patch never appeared, and Jerome's got lost)

Against 2.6.6-rc2

Please apply,

Daniel

--------------040103080406030303070303
Content-Type: text/plain;
 name="2.6.6-rc2-toshiba-generic-ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.6-rc2-toshiba-generic-ide.patch"

Generic IDE support for Toshiba Piccolo PCI IDE chips (2.6)

diff -uprN linux-2.6.6-rc2/drivers/ide/pci/generic.c linux-dsd/drivers/ide/pci/generic.c
--- linux-2.6.6-rc2/drivers/ide/pci/generic.c	2004-04-22 16:07:11.135196296 +0100
+++ linux-dsd/drivers/ide/pci/generic.c	2004-04-22 16:11:28.758031672 +0100
@@ -132,6 +132,9 @@ static struct pci_device_id generic_pci_
 	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
 	{ PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
 	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237_SATA,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
+	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
+	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
+	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, generic_pci_tbl);
diff -uprN linux-2.6.6-rc2/drivers/ide/pci/generic.h linux-dsd/drivers/ide/pci/generic.h
--- linux-2.6.6-rc2/drivers/ide/pci/generic.h	2004-04-22 16:07:11.139195688 +0100
+++ linux-dsd/drivers/ide/pci/generic.h	2004-04-22 16:11:28.765030608 +0100
@@ -129,6 +129,42 @@ static ide_pci_device_t generic_chipsets
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= OFF_BOARD,
 		.extra		= 0,
+	},{ /* 10 */
+		.vendor		= PCI_VENDOR_ID_TOSHIBA,
+		.device		= PCI_DEVICE_ID_TOSHIBA_PICCOLO,
+		.name 		= "Piccolo0102",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},{ /* 11 */
+		.vendor		= PCI_VENDOR_ID_TOSHIBA,
+		.device		= PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,
+		.name 		= "Piccolo0103",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},{ /* 12 */
+		.vendor		= PCI_VENDOR_ID_TOSHIBA,
+		.device		= PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,
+		.name 		= "Piccolo0105",
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
diff -uprN linux-2.6.6-rc2/include/linux/pci_ids.h linux-dsd/include/linux/pci_ids.h
--- linux-2.6.6-rc2/include/linux/pci_ids.h	2004-04-22 16:09:38.000000000 +0100
+++ linux-dsd/include/linux/pci_ids.h	2004-04-22 16:11:28.779028480 +0100
@@ -1383,6 +1383,9 @@
 #define PCI_DEVICE_ID_SBE_WANXL400	0x0104
 
 #define PCI_VENDOR_ID_TOSHIBA		0x1179
+#define PCI_DEVICE_ID_TOSHIBA_PICCOLO	0x0102
+#define PCI_DEVICE_ID_TOSHIBA_PICCOLO_1	0x0103
+#define PCI_DEVICE_ID_TOSHIBA_PICCOLO_2	0x0105
 #define PCI_DEVICE_ID_TOSHIBA_601	0x0601
 #define PCI_DEVICE_ID_TOSHIBA_TOPIC95	0x060a
 #define PCI_DEVICE_ID_TOSHIBA_TOPIC95_A 0x0603

--------------040103080406030303070303--
