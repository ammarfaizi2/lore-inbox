Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUFAWlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUFAWlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265286AbUFAWj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:39:56 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13221 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265269AbUFAWac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:30:32 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update [4/10]
Date: Wed, 2 Jun 2004 00:18:45 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406020018.45211.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: merge amd74xx.h into amd74xx.c

While at it add DECLARE_AMD_DEV() and DECLARE_NV_DEV() macros
(ala piix.h:DECLARE_PIIX_DEV() added by jgarzik).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/amd74xx.c |   42 +++++
 linux-2.6.7-rc2-bk2/drivers/ide/pci/amd74xx.h          |  129 -----------------
 2 files changed, 41 insertions(+), 130 deletions(-)

diff -puN -L drivers/ide/pci/amd74xx.h drivers/ide/pci/amd74xx.h~amd74xx_header /dev/null
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/amd74xx.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,129 +0,0 @@
-#ifndef AMD74XX_H
-#define AMD74XX_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define DISPLAY_AMD_TIMINGS
-
-static unsigned int init_chipset_amd74xx(struct pci_dev *, const char *);
-static void init_hwif_amd74xx(ide_hwif_t *);
-
-static ide_pci_device_t amd74xx_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "AMD7401",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "AMD7409",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},{	/* 2 */
-		.name		= "AMD7411",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},{	/* 3 */
-		.name		= "AMD7441",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},{	/* 4 */
-		.name		= "AMD8111",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.autodma	= AUTODMA,
-		.channels	= 2,
-		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 5 */
-		.name		= "NFORCE",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 6 */
-		.name		= "NFORCE2",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 7 */
-		.name		= "NFORCE2S",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 8 */
-		.name		= "NFORCE2S-SATA",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 9 */
-		.name		= "NFORCE3",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 10 */
-		.name		= "NFORCE3S",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 11 */
-		.name		= "NFORCE3S-SATA",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 12 */
-		.name		= "NFORCE3S-SATA2",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* AMD74XX_H */
diff -puN drivers/ide/pci/amd74xx.c~amd74xx_header drivers/ide/pci/amd74xx.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/amd74xx.c~amd74xx_header	2004-06-01 19:20:29.263268808 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/amd74xx.c	2004-06-01 19:20:29.270267744 +0200
@@ -26,7 +26,8 @@
 #include <asm/io.h>
 
 #include "ide-timing.h"
-#include "amd74xx.h"
+
+#define DISPLAY_AMD_TIMINGS
 
 #define AMD_IDE_ENABLE		(0x00 + amd_config->base)
 #define AMD_IDE_CONFIG		(0x01 + amd_config->base)
@@ -441,6 +442,45 @@ static void __init init_hwif_amd74xx(ide
         hwif->drives[1].autodma = hwif->autodma;
 }
 
+#define DECLARE_AMD_DEV(name_str)					\
+	{								\
+		.name		= name_str,				\
+		.init_chipset	= init_chipset_amd74xx,			\
+		.init_hwif	= init_hwif_amd74xx,			\
+		.channels	= 2,					\
+		.autodma	= AUTODMA,				\
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},	\
+		.bootable	= ON_BOARD,				\
+	}
+
+#define DECLARE_NV_DEV(name_str)					\
+	{								\
+		.name		= name_str,				\
+		.init_chipset	= init_chipset_amd74xx,			\
+		.init_hwif	= init_hwif_amd74xx,			\
+		.channels	= 2,					\
+		.autodma	= AUTODMA,				\
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},	\
+		.bootable	= ON_BOARD,				\
+	}
+
+static ide_pci_device_t amd74xx_chipsets[] __devinitdata = {
+	/*  0 */ DECLARE_AMD_DEV("AMD7401"),
+	/*  1 */ DECLARE_AMD_DEV("AMD7409"),
+	/*  2 */ DECLARE_AMD_DEV("AMD7411"),
+	/*  3 */ DECLARE_AMD_DEV("AMD7441"),
+	/*  4 */ DECLARE_AMD_DEV("AMD8111"),
+
+	/*  5 */ DECLARE_NV_DEV("NFORCE"),
+	/*  6 */ DECLARE_NV_DEV("NFORCE2"),
+	/*  7 */ DECLARE_NV_DEV("NFORCE2S"),
+	/*  8 */ DECLARE_NV_DEV("NFORCE2S-SATA"),
+	/*  9 */ DECLARE_NV_DEV("NFORCE3"),
+	/* 10 */ DECLARE_NV_DEV("NFORCE3S"),
+	/* 11 */ DECLARE_NV_DEV("NFORCE3S-SATA"),
+	/* 12 */ DECLARE_NV_DEV("NFORCE3S-SATA2")
+};
+
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	amd_chipset = amd74xx_chipsets + id->driver_data;

_

