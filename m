Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVBDHiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVBDHiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbVBDH34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:29:56 -0500
Received: from [211.58.254.17] ([211.58.254.17]:44457 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263398AbVBDHNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:13:24 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 12/14] ide_pci: Merges piix.h into piix.c
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42032014.1020606@home-tj.org>
References: <42032014.1020606@home-tj.org>
Message-Id: <20050204071319.618DB132701@htj.dyndns.org>
Date: Fri,  4 Feb 2005 16:13:19 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


12_ide_pci_piix_merge.patch

	Merges ide/pci/piix.h into piix.c.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/piix.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/piix.c	2005-02-04 16:07:36.404440170 +0900
+++ linux-idepci-export/drivers/ide/pci/piix.c	2005-02-04 16:08:26.627260629 +0900
@@ -103,8 +103,6 @@
 
 #include <asm/io.h>
 
-#include "piix.h"
-
 static int no_piix_dma;
 
 /**
@@ -530,6 +528,56 @@ static void __devinit init_hwif_piix(ide
 	hwif->drives[0].autodma = hwif->autodma;
 }
 
+/*
+ *	Table of the various PIIX capability blocks
+ */
+
+#define DECLARE_PIIX_DEV(name_str) \
+	{						\
+		.name		= name_str,		\
+		.init_chipset	= init_chipset_piix,	\
+		.init_hwif	= init_hwif_piix,	\
+		.channels	= 2,			\
+		.autodma	= AUTODMA,		\
+		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
+		.bootable	= ON_BOARD,		\
+	}
+
+static ide_pci_device_t piix_pci_info[] __devinitdata = {
+	/*  0 */ DECLARE_PIIX_DEV("PIIXa"),
+	/*  1 */ DECLARE_PIIX_DEV("PIIXb"),
+
+	{	/* 2 */
+		.name		= "MPIIX",
+		.init_hwif	= init_hwif_piix,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.enablebits	= {{0x6D,0x80,0x80}, {0x6F,0x80,0x80}},
+		.bootable	= ON_BOARD,
+	},
+
+	/*  3 */ DECLARE_PIIX_DEV("PIIX3"),
+	/*  4 */ DECLARE_PIIX_DEV("PIIX4"),
+	/*  5 */ DECLARE_PIIX_DEV("ICH0"),
+	/*  6 */ DECLARE_PIIX_DEV("PIIX4"),
+	/*  7 */ DECLARE_PIIX_DEV("ICH"),
+	/*  8 */ DECLARE_PIIX_DEV("PIIX4"),
+	/*  9 */ DECLARE_PIIX_DEV("PIIX4"),
+	/* 10 */ DECLARE_PIIX_DEV("ICH2"),
+	/* 11 */ DECLARE_PIIX_DEV("ICH2M"),
+	/* 12 */ DECLARE_PIIX_DEV("ICH3M"),
+	/* 13 */ DECLARE_PIIX_DEV("ICH3"),
+	/* 14 */ DECLARE_PIIX_DEV("ICH4"),
+	/* 15 */ DECLARE_PIIX_DEV("ICH5"),
+	/* 16 */ DECLARE_PIIX_DEV("C-ICH"),
+	/* 17 */ DECLARE_PIIX_DEV("ICH4"),
+	/* 18 */ DECLARE_PIIX_DEV("ICH5-SATA"),
+	/* 19 */ DECLARE_PIIX_DEV("ICH5"),
+	/* 20 */ DECLARE_PIIX_DEV("ICH6"),
+	/* 21 */ DECLARE_PIIX_DEV("ICH7"),
+	/* 22 */ DECLARE_PIIX_DEV("ICH4"),
+};
+
 /**
  *	piix_init_one	-	called when a PIIX is found
  *	@dev: the piix device
Index: linux-idepci-export/drivers/ide/pci/piix.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/piix.h	2005-02-04 16:07:36.404440170 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,62 +0,0 @@
-#ifndef PIIX_H
-#define PIIX_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-static unsigned int __devinit init_chipset_piix(struct pci_dev *, const char *);
-static void init_hwif_piix(ide_hwif_t *);
-
-#define DECLARE_PIIX_DEV(name_str) \
-	{						\
-		.name		= name_str,		\
-		.init_chipset	= init_chipset_piix,	\
-		.init_hwif	= init_hwif_piix,	\
-		.channels	= 2,			\
-		.autodma	= AUTODMA,		\
-		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
-		.bootable	= ON_BOARD,		\
-	}
-
-/*
- *	Table of the various PIIX capability blocks
- *
- */
- 
-static ide_pci_device_t piix_pci_info[] __devinitdata = {
-	/*  0 */ DECLARE_PIIX_DEV("PIIXa"),
-	/*  1 */ DECLARE_PIIX_DEV("PIIXb"),
-
-	{	/* 2 */
-		.name		= "MPIIX",
-		.init_hwif	= init_hwif_piix,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.enablebits	= {{0x6D,0x80,0x80}, {0x6F,0x80,0x80}},
-		.bootable	= ON_BOARD,
-	},
-
-	/*  3 */ DECLARE_PIIX_DEV("PIIX3"),
-	/*  4 */ DECLARE_PIIX_DEV("PIIX4"),
-	/*  5 */ DECLARE_PIIX_DEV("ICH0"),
-	/*  6 */ DECLARE_PIIX_DEV("PIIX4"),
-	/*  7 */ DECLARE_PIIX_DEV("ICH"),
-	/*  8 */ DECLARE_PIIX_DEV("PIIX4"),
-	/*  9 */ DECLARE_PIIX_DEV("PIIX4"),
-	/* 10 */ DECLARE_PIIX_DEV("ICH2"),
-	/* 11 */ DECLARE_PIIX_DEV("ICH2M"),
-	/* 12 */ DECLARE_PIIX_DEV("ICH3M"),
-	/* 13 */ DECLARE_PIIX_DEV("ICH3"),
-	/* 14 */ DECLARE_PIIX_DEV("ICH4"),
-	/* 15 */ DECLARE_PIIX_DEV("ICH5"),
-	/* 16 */ DECLARE_PIIX_DEV("C-ICH"),
-	/* 17 */ DECLARE_PIIX_DEV("ICH4"),
-	/* 18 */ DECLARE_PIIX_DEV("ICH5-SATA"),
-	/* 19 */ DECLARE_PIIX_DEV("ICH5"),
-	/* 20 */ DECLARE_PIIX_DEV("ICH6"),
-	/* 21 */ DECLARE_PIIX_DEV("ICH7"),
-	/* 22 */ DECLARE_PIIX_DEV("ICH4"),
-};
-
-#endif /* PIIX_H */
