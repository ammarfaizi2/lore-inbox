Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265512AbUFIDGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265512AbUFIDGo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 23:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbUFIDGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 23:06:44 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:7442 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S265512AbUFIDG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 23:06:29 -0400
Subject: [PATCH 2.4.27-pre5] add new nForce SATA/IDE ids
From: Brian Lazara <blazara@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: multipart/mixed; boundary="=-zD+J1mHTjB+6va4AfwKv"
Message-Id: <1086750417.32222.172.camel@dhcp-175-55.nvidia.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Jun 2004 20:06:57 -0700
X-OriginalArrivalTime: 09 Jun 2004 03:06:27.0787 (UTC) FILETIME=[C17AD1B0:01C44DCE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zD+J1mHTjB+6va4AfwKv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Patch against 2.4.27-pre5 to add new NVIDIA IDE and SATA controller 
device IDs. Note this is a resend of a previous patch submittal against 
2.4.27-pre2 that must have been too late to make it in.

Regards,
Brian


diff -uprN -X dontdiff linux-2.4.27-pre5/drivers/ide/pci/amd74xx.c linux-2.4.27-pre5-ck804-ide/drivers/ide/pci/amd74xx.c
--- linux-2.4.27-pre5/drivers/ide/pci/amd74xx.c 2004-04-14 06:05:29.000000000 -0700
+++ linux-2.4.27-pre5-ck804-ide/drivers/ide/pci/amd74xx.c       2004-06-08 16:37:18.000000000 -0700
@@ -1,7 +1,8 @@                                                                               

 /*
  * Version 2.13
  *
- * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s IDE driver for Linux.
+ * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04
+ * IDE driver for Linux.
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -68,6 +69,12 @@ static struct amd_ide_chip {
        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,    0x50, AMD_UDMA_133 },
        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,   0x50, AMD_UDMA_133 },
        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,  0x50, AMD_UDMA_133 },
+       { PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,        0x50, AMD_UDMA_133 },
+       { PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,       0x50, AMD_UDMA_133 },
+       { PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,      0x50, AMD_UDMA_133 },
+       { PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,        0x50, AMD_UDMA_133 },
+       { PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,       0x50, AMD_UDMA_133 },
+       { PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,      0x50, AMD_UDMA_133 },                                                                               

        { 0 }
 };
  
@@ -464,6 +471,12 @@ static struct pci_device_id amd74xx_pci_
        { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,      PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10 },
        { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11 },
        { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,    PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12 },
+       { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
+       { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
+       { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
+       { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
+       { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+       { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
        { 0, },
 };

diff -uprN -X dontdiff linux-2.4.27-pre5/drivers/ide/pci/amd74xx.h linux-2.4.27-pre5-ck804-ide/drivers/ide/pci/amd74xx.h
--- linux-2.4.27-pre5/drivers/ide/pci/amd74xx.h 2004-04-14 06:05:29.000000000 -0700
+++ linux-2.4.27-pre5-ck804-ide/drivers/ide/pci/amd74xx.h       2004-06-08 16:37:18.000000000 -0700
@@ -112,7 +112,7 @@ static ide_pci_device_t amd74xx_chipsets
        {       /* 7 */
                .vendor         = PCI_VENDOR_ID_NVIDIA,
                .device         = PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,
-               .name           = "NFORCE2S",
+               .name           = "NFORCE2-U400R",
                .init_chipset   = init_chipset_amd74xx,
                .init_hwif      = init_hwif_amd74xx,
                .channels       = 2,
@@ -123,7 +123,7 @@ static ide_pci_device_t amd74xx_chipsets
        {       /* 8 */
                .vendor         = PCI_VENDOR_ID_NVIDIA,
                .device         = PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
-               .name           = "NFORCE2S-SATA",
+               .name           = "NFORCE2-U400R-SATA",
                .init_chipset   = init_chipset_amd74xx,
                .init_hwif      = init_hwif_amd74xx,
                .channels       = 2,
@@ -134,7 +134,7 @@ static ide_pci_device_t amd74xx_chipsets
        {       /* 9 */
                .vendor         = PCI_VENDOR_ID_NVIDIA,
                .device         = PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,
-               .name           = "NFORCE3",
+               .name           = "NFORCE3-150",
                .init_chipset   = init_chipset_amd74xx,
                .init_hwif      = init_hwif_amd74xx,
                .channels       = 2,
@@ -145,7 +145,7 @@ static ide_pci_device_t amd74xx_chipsets
        {       /* 10 */
                .vendor         = PCI_VENDOR_ID_NVIDIA,
                .device         = PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,
-               .name           = "NFORCE3S",
+               .name           = "NFORCE3-250",
                .init_chipset   = init_chipset_amd74xx,
                .init_hwif      = init_hwif_amd74xx,
                .channels       = 2,
@@ -156,7 +156,7 @@ static ide_pci_device_t amd74xx_chipsets
        {       /* 11 */
                .vendor         = PCI_VENDOR_ID_NVIDIA,
                .device         = PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
-               .name           = "NFORCE3S-SATA",
+               .name           = "NFORCE3-250-SATA",
                .init_chipset   = init_chipset_amd74xx,
                .init_hwif      = init_hwif_amd74xx,
                .channels       = 2,
@@ -167,7 +167,73 @@ static ide_pci_device_t amd74xx_chipsets
        {       /* 12 */
                .vendor         = PCI_VENDOR_ID_NVIDIA,
                .device         = PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
-               .name           = "NFORCE3S-SATA2",
+               .name           = "NFORCE3-250-SATA2",
+               .init_chipset   = init_chipset_amd74xx,
+               .init_hwif      = init_hwif_amd74xx,
+               .channels       = 2,
+               .autodma        = AUTODMA,
+               .enablebits     = {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+               .bootable       = ON_BOARD,
+       },
+       {       /* 13 */
+               .vendor         = PCI_VENDOR_ID_NVIDIA,
+               .device         = PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,
+               .name           = "NFORCE-CK804",
+               .init_chipset   = init_chipset_amd74xx,
+               .init_hwif      = init_hwif_amd74xx,
+               .channels       = 2,
+               .autodma        = AUTODMA,
+               .enablebits     = {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+               .bootable       = ON_BOARD,
+       },
+       {       /* 14 */
+               .vendor         = PCI_VENDOR_ID_NVIDIA,
+               .device         = PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
+               .name           = "NFORCE-CK804-SATA",
+               .init_chipset   = init_chipset_amd74xx,
+               .init_hwif      = init_hwif_amd74xx,
+               .channels       = 2,
+               .autodma        = AUTODMA,
+               .enablebits     = {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+               .bootable       = ON_BOARD,
+       },
+       {       /* 15 */
+               .vendor         = PCI_VENDOR_ID_NVIDIA,
+               .device         = PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
+               .name           = "NFORCE-CK804-SATA2",
+               .init_chipset   = init_chipset_amd74xx,
+               .init_hwif      = init_hwif_amd74xx,
+               .channels       = 2,
+               .autodma        = AUTODMA,
+               .enablebits     = {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+               .bootable       = ON_BOARD,
+       },
+       {       /* 16 */
+               .vendor         = PCI_VENDOR_ID_NVIDIA,
+               .device         = PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,
+               .name           = "NFORCE-MCP04",
+               .init_chipset   = init_chipset_amd74xx,
+               .init_hwif      = init_hwif_amd74xx,
+               .channels       = 2,
+               .autodma        = AUTODMA,
+               .enablebits     = {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+               .bootable       = ON_BOARD,
+       },
+       {       /* 17 */
+               .vendor         = PCI_VENDOR_ID_NVIDIA,
+               .device         = PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
+               .name           = "NFORCE-MCP04-SATA",
+               .init_chipset   = init_chipset_amd74xx,
+               .init_hwif      = init_hwif_amd74xx,
+               .channels       = 2,
+               .autodma        = AUTODMA,
+               .enablebits     = {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+               .bootable       = ON_BOARD,
+       },
+       {       /* 18 */
+               .vendor         = PCI_VENDOR_ID_NVIDIA,
+               .device         = PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
+               .name           = "NFORCE-MCP04-SATA2",
                .init_chipset   = init_chipset_amd74xx,
                .init_hwif      = init_hwif_amd74xx,
                .channels       = 2,

diff -uprN -X dontdiff linux-2.4.27-pre5/include/linux/pci_ids.h linux-2.4.27-pre5-ck804-ide/include/linux/pci_ids.h
--- linux-2.4.27-pre5/include/linux/pci_ids.h   2004-06-08 16:24:50.000000000 -0700
+++ linux-2.4.27-pre5-ck804-ide/include/linux/pci_ids.h 2004-06-08 16:43:00.000000000 -0700
@@ -978,6 +978,12 @@
 #define PCI_DEVICE_ID_NVIDIA_UTNT2             0x0029
 #define PCI_DEVICE_ID_NVIDIA_VTNT2             0x002C
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2            0x002D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE  0x0035
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA 0x0036
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2        0x003e
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE  0x0053
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA 0x0054
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2        0x0055
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE       0x0065
 #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO                0x006a
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE      0x0085



--=-zD+J1mHTjB+6va4AfwKv
Content-Disposition: attachment; filename=linux-2.4.27-pre5-nforce-ck804-ide.patch
Content-Type: text/plain; name=linux-2.4.27-pre5-nforce-ck804-ide.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.4.27-pre5/drivers/ide/pci/amd74xx.c	2004-04-14 06:05:29.000000000 -0700
+++ linux-2.4.27-pre5-ck804-ide/drivers/ide/pci/amd74xx.c	2004-06-08 18:33:37.000000000 -0700
@@ -1,7 +1,8 @@
 /*
  * Version 2.13
  *
- * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s IDE driver for Linux.
+ * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04 
+ * IDE driver for Linux.
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -68,6 +69,12 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,	0x50, AMD_UDMA_133 },
 	{ 0 }
 };
 
@@ -464,6 +471,12 @@ static struct pci_device_id amd74xx_pci_
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
 	{ 0, },
 };
 
--- linux-2.4.27-pre5/drivers/ide/pci/amd74xx.h	2004-04-14 06:05:29.000000000 -0700
+++ linux-2.4.27-pre5-ck804-ide/drivers/ide/pci/amd74xx.h	2004-06-08 18:33:41.000000000 -0700
@@ -112,7 +112,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 7 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,
-		.name		= "NFORCE2S",
+		.name		= "NFORCE2-U400R",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -123,7 +123,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 8 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
-		.name		= "NFORCE2S-SATA",
+		.name		= "NFORCE2-U400R-SATA",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -134,7 +134,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 9 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,
-		.name		= "NFORCE3",
+		.name		= "NFORCE3-150",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -145,7 +145,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 10 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,
-		.name		= "NFORCE3S",
+		.name		= "NFORCE3-250",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -156,7 +156,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 11 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
-		.name		= "NFORCE3S-SATA",
+		.name		= "NFORCE3-250-SATA",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -167,7 +167,73 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 12 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
-		.name		= "NFORCE3S-SATA2",
+		.name		= "NFORCE3-250-SATA2",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 13 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,
+		.name		= "NFORCE-CK804",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 14 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
+		.name		= "NFORCE-CK804-SATA",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 15 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
+		.name		= "NFORCE-CK804-SATA2",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 16 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,
+		.name		= "NFORCE-MCP04",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 17 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
+		.name		= "NFORCE-MCP04-SATA",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 18 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
+		.name		= "NFORCE-MCP04-SATA2",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
--- linux-2.4.27-pre5/include/linux/pci_ids.h	2004-06-08 18:25:02.000000000 -0700
+++ linux-2.4.27-pre5-ck804-ide/include/linux/pci_ids.h	2004-06-08 18:36:42.000000000 -0700
@@ -978,6 +978,12 @@
 #define PCI_DEVICE_ID_NVIDIA_UTNT2		0x0029
 #define PCI_DEVICE_ID_NVIDIA_VTNT2		0x002C
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE	0x0035
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA	0x0036
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2	0x003e
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE	0x0053
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA	0x0054
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2	0x0055
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085

--=-zD+J1mHTjB+6va4AfwKv--

