Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264117AbUFKQ0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUFKQ0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUFKQ0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:26:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14233 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264155AbUFKQQU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:16:20 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.7-rc3 [2/12]
Date: Fri, 11 Jun 2004 17:51:49 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111751.49333.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: kill some useless headers for PCI drivers

They are only included from these drivers.

While at it:
- remove redundant ide_pci_device_t tables
- add DECLARE_CS_DEV() (cs5520)
- remove duplicate DISPLAY_SC1200_TIMINGS define (sc1200)
- remove unused SIIMAGE_BUFFERED_TASKFILE, SII_DEBUG
  and siiprintk() defines + add DECLARE_SII_DEV() (siimage)
- remove unused SLC90E66_DEBUG_DRIVE_INFO define (slc90e66)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/alim15x3.c  |   16 ++++-
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/cs5520.c    |   21 ++++++-
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/cs5530.c    |   14 ++++-
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/ns87415.c   |   12 +++-
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/rz1000.c    |   14 +++--
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/sc1200.c    |   13 +++-
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/siimage.c   |   20 ++++++-
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/sis5513.c   |   15 ++++-
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/sl82c105.c  |   15 ++++-
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/slc90e66.c  |   14 ++++-
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/triflex.c   |   21 ++++++-
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/trm290.c    |   12 +++-
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/via82cxxx.c |   15 ++++-
 linux-2.6.7-rc3/drivers/ide/pci/alim15x3.h           |   27 ---------
 linux-2.6.7-rc3/drivers/ide/pci/cs5520.h             |   40 --------------
 linux-2.6.7-rc3/drivers/ide/pci/cs5530.h             |   25 --------
 linux-2.6.7-rc3/drivers/ide/pci/ns87415.h            |   20 -------
 linux-2.6.7-rc3/drivers/ide/pci/rz1000.h             |   26 ---------
 linux-2.6.7-rc3/drivers/ide/pci/sc1200.h             |   24 --------
 linux-2.6.7-rc3/drivers/ide/pci/siimage.h            |   53 -------------------
 linux-2.6.7-rc3/drivers/ide/pci/sis5513.h            |   25 --------
 linux-2.6.7-rc3/drivers/ide/pci/sl82c105.h           |   25 --------
 linux-2.6.7-rc3/drivers/ide/pci/slc90e66.h           |   27 ---------
 linux-2.6.7-rc3/drivers/ide/pci/triflex.h            |   37 -------------
 linux-2.6.7-rc3/drivers/ide/pci/trm290.h             |   20 -------
 linux-2.6.7-rc3/drivers/ide/pci/via82cxxx.h          |   25 --------
 26 files changed, 169 insertions(+), 407 deletions(-)

diff -puN drivers/ide/pci/alim15x3.c~ide_pci_headers drivers/ide/pci/alim15x3.c
--- linux-2.6.7-rc3/drivers/ide/pci/alim15x3.c~ide_pci_headers	2004-06-11 16:35:00.127598560 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/alim15x3.c	2004-06-11 16:35:00.229583056 +0200
@@ -38,7 +38,7 @@
 
 #include <asm/io.h>
 
-#include "alim15x3.h"
+#define DISPLAY_ALI_TIMINGS
 
 /*
  *	ALi devices are not plug in. Otherwise these static values would
@@ -853,6 +853,16 @@ static void __init init_dma_ali15x3 (ide
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
+static ide_pci_device_t ali15x3_chipset __devinitdata = {
+	.name		= "ALI15X3",
+	.init_chipset	= init_chipset_ali15x3,
+	.init_hwif	= init_hwif_ali15x3,
+	.init_dma	= init_dma_ali15x3,
+	.channels	= 2,
+	.autodma	= AUTODMA,
+	.bootable	= ON_BOARD,
+};
+
 /**
  *	alim15x3_init_one	-	set up an ALi15x3 IDE controller
  *	@dev: PCI device to set up
@@ -863,8 +873,8 @@ static void __init init_dma_ali15x3 (ide
  
 static int __devinit alim15x3_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &ali15x3_chipsets[id->driver_data];
-	
+	ide_pci_device_t *d = &ali15x3_chipset;
+
 	if(pci_find_device(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS100, NULL))
 		printk(KERN_ERR "Warning: ATI Radeon IGP Northbridge is not yet fully tested.\n");
 
diff -puN -L drivers/ide/pci/alim15x3.h drivers/ide/pci/alim15x3.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/alim15x3.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,27 +0,0 @@
-#ifndef ALI15X3_H
-#define ALI15X3_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define DISPLAY_ALI_TIMINGS
-
-static unsigned int init_chipset_ali15x3(struct pci_dev *, const char *);
-static void init_hwif_common_ali15x3(ide_hwif_t *);
-static void init_hwif_ali15x3(ide_hwif_t *);
-static void init_dma_ali15x3(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t ali15x3_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "ALI15X3",
-		.init_chipset	= init_chipset_ali15x3,
-		.init_hwif	= init_hwif_ali15x3,
-		.init_dma	= init_dma_ali15x3,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* ALI15X3 */
diff -puN drivers/ide/pci/cs5520.c~ide_pci_headers drivers/ide/pci/cs5520.c
--- linux-2.6.7-rc3/drivers/ide/pci/cs5520.c~ide_pci_headers	2004-06-11 16:35:00.135597344 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/cs5520.c	2004-06-11 16:35:00.232582600 +0200
@@ -51,7 +51,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "cs5520.h"
+#define DISPLAY_CS5520_TIMINGS
 
 #if defined(DISPLAY_CS5520_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
@@ -251,7 +251,24 @@ static void __devinit init_hwif_cs5520(i
 	hwif->drives[0].autodma = hwif->autodma;
 	hwif->drives[1].autodma = hwif->autodma;
 }
-		
+
+#define DECLARE_CS_DEV(name_str)				\
+	{							\
+		.name		= name_str,			\
+		.init_chipset	= init_chipset_cs5520,		\
+		.init_setup_dma = cs5520_init_setup_dma,	\
+		.init_hwif	= init_hwif_cs5520,		\
+		.channels	= 2,				\
+		.autodma	= AUTODMA,			\
+		.bootable	= ON_BOARD,			\
+		.flags		= IDEPCI_FLAG_ISA_PORTS,	\
+	}
+
+static ide_pci_device_t cyrix_chipsets[] __devinitdata = {
+	/* 0 */ DECLARE_CS_DEV("Cyrix 5510"),
+	/* 1 */ DECLARE_CS_DEV("Cyrix 5520")
+};
+
 /*
  *	The 5510/5520 are a bit weird. They don't quite set up the way
  *	the PCI helper layer expects so we must do much of the set up 
diff -puN -L drivers/ide/pci/cs5520.h drivers/ide/pci/cs5520.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/cs5520.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,40 +0,0 @@
-#ifndef CS5520_H
-#define CS5520_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define DISPLAY_CS5520_TIMINGS
-
-static unsigned int init_chipset_cs5520(struct pci_dev *, const char *);
-static void init_hwif_cs5520(ide_hwif_t *);
-static void cs5520_init_setup_dma(struct pci_dev *dev, struct ide_pci_device_s *d, ide_hwif_t *hwif);
-
-static ide_pci_device_t cyrix_chipsets[] __devinitdata = {
-	{
-		.name		= "Cyrix 5510",
-		.init_chipset	= init_chipset_cs5520,
-		.init_setup_dma = cs5520_init_setup_dma,
-		.init_hwif	= init_hwif_cs5520,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-		.flags		= IDEPCI_FLAG_ISA_PORTS,
-	},
-	{
-		.name		= "Cyrix 5520",
-		.init_chipset	= init_chipset_cs5520,
-		.init_setup_dma = cs5520_init_setup_dma,
-		.init_hwif	= init_hwif_cs5520,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-		.flags		= IDEPCI_FLAG_ISA_PORTS,
-	}
-};
-
-
-#endif /* CS5520_H */
-
-
diff -puN drivers/ide/pci/cs5530.c~ide_pci_headers drivers/ide/pci/cs5530.c
--- linux-2.6.7-rc3/drivers/ide/pci/cs5530.c~ide_pci_headers	2004-06-11 16:35:00.142596280 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/cs5530.c	2004-06-11 16:35:00.234582296 +0200
@@ -31,7 +31,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "cs5530.h"
+#define DISPLAY_CS5530_TIMINGS
 
 #if defined(DISPLAY_CS5530_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
@@ -404,9 +404,19 @@ static void __init init_hwif_cs5530 (ide
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+static ide_pci_device_t cs5530_chipset __devinitdata = {
+	.name		= "CS5530",
+	.init_chipset	= init_chipset_cs5530,
+	.init_hwif	= init_hwif_cs5530,
+	.channels	= 2,
+	.autodma	= AUTODMA,
+	.bootable	= ON_BOARD,
+	.flags		= IDEPCI_FLAG_FORCE_MASTER,
+};
+
 static int __devinit cs5530_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &cs5530_chipsets[id->driver_data]);
+	ide_setup_pci_device(dev, &cs5530_chipset);
 	return 0;
 }
 
diff -puN -L drivers/ide/pci/cs5530.h drivers/ide/pci/cs5530.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/cs5530.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,25 +0,0 @@
-#ifndef CS5530_H
-#define CS5530_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define DISPLAY_CS5530_TIMINGS
-
-static unsigned int init_chipset_cs5530(struct pci_dev *, const char *);
-static void init_hwif_cs5530(ide_hwif_t *);
-
-static ide_pci_device_t cs5530_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "CS5530",
-		.init_chipset	= init_chipset_cs5530,
-		.init_hwif	= init_hwif_cs5530,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-		.flags		= IDEPCI_FLAG_FORCE_MASTER,
-	}
-};
-
-#endif /* CS5530_H */
diff -puN drivers/ide/pci/ns87415.c~ide_pci_headers drivers/ide/pci/ns87415.c
--- linux-2.6.7-rc3/drivers/ide/pci/ns87415.c~ide_pci_headers	2004-06-11 16:35:00.151594912 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/ns87415.c	2004-06-11 16:35:00.235582144 +0200
@@ -25,8 +25,6 @@
 
 #include <asm/io.h>
 
-#include "ns87415.h"
-
 static unsigned int ns87415_count = 0, ns87415_control[MAX_HWIFS] = { 0 };
 
 /*
@@ -217,9 +215,17 @@ static void __init init_hwif_ns87415 (id
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+static ide_pci_device_t ns87415_chipset __devinitdata = {
+	.name		= "NS87415",
+	.init_hwif	= init_hwif_ns87415,
+	.channels	= 2,
+	.autodma	= AUTODMA,
+	.bootable	= ON_BOARD,
+};
+
 static int __devinit ns87415_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &ns87415_chipsets[id->driver_data]);
+	ide_setup_pci_device(dev, &ns87415_chipset);
 	return 0;
 }
 
diff -puN -L drivers/ide/pci/ns87415.h drivers/ide/pci/ns87415.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/ns87415.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,20 +0,0 @@
-#ifndef NS87415_H
-#define NS87415_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-static void init_hwif_ns87415(ide_hwif_t *);
-
-static ide_pci_device_t ns87415_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "NS87415",
-		.init_hwif	= init_hwif_ns87415,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* NS87415_H */
diff -puN drivers/ide/pci/rz1000.c~ide_pci_headers drivers/ide/pci/rz1000.c
--- linux-2.6.7-rc3/drivers/ide/pci/rz1000.c~ide_pci_headers	2004-06-11 16:35:00.158593848 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/rz1000.c	2004-06-11 16:35:00.237581840 +0200
@@ -33,8 +33,6 @@
 
 #include <asm/io.h>
 
-#include "rz1000.h"
-
 static void __init init_hwif_rz1000 (ide_hwif_t *hwif)
 {
 	u16 reg;
@@ -54,15 +52,23 @@ static void __init init_hwif_rz1000 (ide
 	}
 }
 
+static ide_pci_device_t rz1000_chipset __devinitdata = {
+	.name		= "RZ100x",
+	.init_hwif	= init_hwif_rz1000,
+	.channels	= 2,
+	.autodma	= NODMA,
+	.bootable	= ON_BOARD,
+};
+
 static int __devinit rz1000_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &rz1000_chipsets[id->driver_data]);
+	ide_setup_pci_device(dev, &rz1000_chipset);
 	return 0;
 }
 
 static struct pci_device_id rz1000_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, rz1000_pci_tbl);
diff -puN -L drivers/ide/pci/rz1000.h drivers/ide/pci/rz1000.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/rz1000.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,26 +0,0 @@
-#ifndef RZ100X_H
-#define RZ100X_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-static void init_hwif_rz1000(ide_hwif_t *);
-
-static ide_pci_device_t rz1000_chipsets[] __devinitdata = {
-	{
-		.name		= "RZ1000",
-		.init_hwif	= init_hwif_rz1000,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.bootable	= ON_BOARD,
-	},{
-		.name		= "RZ1001",
-		.init_hwif	= init_hwif_rz1000,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* RZ100X_H */
diff -puN drivers/ide/pci/sc1200.c~ide_pci_headers drivers/ide/pci/sc1200.c
--- linux-2.6.7-rc3/drivers/ide/pci/sc1200.c~ide_pci_headers	2004-06-11 16:35:00.165592784 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/sc1200.c	2004-06-11 16:35:00.239581536 +0200
@@ -29,8 +29,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "sc1200.h"
-
 #define SC1200_REV_A	0x00
 #define SC1200_REV_B1	0x01
 #define SC1200_REV_B3	0x02
@@ -545,9 +543,18 @@ static void __init init_hwif_sc1200 (ide
         hwif->drives[1].autodma = hwif->autodma;
 }
 
+static ide_pci_device_t sc1200_chipset __devinitdata = {
+	.name		= "SC1200",
+	.init_chipset	= init_chipset_sc1200,
+	.init_hwif	= init_hwif_sc1200,
+	.channels	= 2,
+	.autodma	= AUTODMA,
+	.bootable	= ON_BOARD,
+};
+
 static int __devinit sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &sc1200_chipsets[id->driver_data]);
+	ide_setup_pci_device(dev, &sc1200_chipset);
 	return 0;
 }
 
diff -puN -L drivers/ide/pci/sc1200.h drivers/ide/pci/sc1200.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/sc1200.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,24 +0,0 @@
-#ifndef SC1200_H
-#define SC1200_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define DISPLAY_SC1200_TIMINGS
-
-static unsigned int init_chipset_sc1200(struct pci_dev *, const char *);
-static void init_hwif_sc1200(ide_hwif_t *);
-
-static ide_pci_device_t sc1200_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "SC1200",
-		.init_chipset	= init_chipset_sc1200,
-		.init_hwif	= init_hwif_sc1200,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* SC1200_H */
diff -puN drivers/ide/pci/siimage.c~ide_pci_headers drivers/ide/pci/siimage.c
--- linux-2.6.7-rc3/drivers/ide/pci/siimage.c~ide_pci_headers	2004-06-11 16:35:00.173591568 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/siimage.c	2004-06-11 16:35:00.242581080 +0200
@@ -31,7 +31,8 @@
 
 #include <asm/io.h>
 
-#include "siimage.h"
+#undef SIIMAGE_VIRTUAL_DMAPIO
+#undef SIIMAGE_LARGE_DMA
 
 /**
  *	pdev_is_sata		-	check if device is SATA
@@ -1092,6 +1093,23 @@ static void __devinit init_hwif_siimage(
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+#define DECLARE_SII_DEV(name_str)			\
+	{						\
+		.name		= name_str,		\
+		.init_chipset	= init_chipset_siimage,	\
+		.init_iops	= init_iops_siimage,	\
+		.init_hwif	= init_hwif_siimage,	\
+		.channels	= 2,			\
+		.autodma	= AUTODMA,		\
+		.bootable	= ON_BOARD,		\
+	}
+
+static ide_pci_device_t siimage_chipsets[] __devinitdata = {
+	/* 0 */ DECLARE_SII_DEV("SiI680"),
+	/* 1 */ DECLARE_SII_DEV("SiI3112 Serial ATA"),
+	/* 2 */ DECLARE_SII_DEV("Adaptec AAR-1210SA")
+};
+
 /**
  *	siimage_init_one	-	pci layer discovery entry
  *	@dev: PCI device
diff -puN -L drivers/ide/pci/siimage.h drivers/ide/pci/siimage.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/siimage.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,53 +0,0 @@
-#ifndef SIIMAGE_H
-#define SIIMAGE_H
-
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#include <asm/io.h>
-
-#undef SIIMAGE_VIRTUAL_DMAPIO
-#undef SIIMAGE_BUFFERED_TASKFILE
-#undef SIIMAGE_LARGE_DMA
-
-#define SII_DEBUG 0
-
-#if SII_DEBUG
-#define siiprintk(x...)	printk(x)
-#else
-#define siiprintk(x...)
-#endif
-
-static unsigned int init_chipset_siimage(struct pci_dev *, const char *);
-static void init_iops_siimage(ide_hwif_t *);
-static void init_hwif_siimage(ide_hwif_t *);
-
-static ide_pci_device_t siimage_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "SiI680",
-		.init_chipset	= init_chipset_siimage,
-		.init_iops	= init_iops_siimage,
-		.init_hwif	= init_hwif_siimage,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "SiI3112 Serial ATA",
-		.init_chipset	= init_chipset_siimage,
-		.init_iops	= init_iops_siimage,
-		.init_hwif	= init_hwif_siimage,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 2 */
-		.name		= "Adaptec AAR-1210SA",
-		.init_chipset	= init_chipset_siimage,
-		.init_iops	= init_iops_siimage,
-		.init_hwif	= init_hwif_siimage,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* SIIMAGE_H */
diff -puN drivers/ide/pci/sis5513.c~ide_pci_headers drivers/ide/pci/sis5513.c
--- linux-2.6.7-rc3/drivers/ide/pci/sis5513.c~ide_pci_headers	2004-06-11 16:35:00.181590352 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/sis5513.c	2004-06-11 16:35:00.244580776 +0200
@@ -63,7 +63,8 @@
 #include <asm/irq.h>
 
 #include "ide-timing.h"
-#include "sis5513.h"
+
+#define DISPLAY_SIS_TIMINGS
 
 /* registers layout and init values are chipset family dependant */
 
@@ -944,9 +945,19 @@ static void __init init_hwif_sis5513 (id
 	return;
 }
 
+static ide_pci_device_t sis5513_chipset __devinitdata = {
+	.name		= "SIS5513",
+	.init_chipset	= init_chipset_sis5513,
+	.init_hwif	= init_hwif_sis5513,
+	.channels	= 2,
+	.autodma	= NOAUTODMA,
+	.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
+	.bootable	= ON_BOARD,
+};
+
 static int __devinit sis5513_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &sis5513_chipsets[id->driver_data]);
+	ide_setup_pci_device(dev, &sis5513_chipset);
 	return 0;
 }
 
diff -puN -L drivers/ide/pci/sis5513.h drivers/ide/pci/sis5513.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/sis5513.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,25 +0,0 @@
-#ifndef SIS5513_H
-#define SIS5513_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define DISPLAY_SIS_TIMINGS
-
-static unsigned int init_chipset_sis5513(struct pci_dev *, const char *);
-static void init_hwif_sis5513(ide_hwif_t *);
-
-static ide_pci_device_t sis5513_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "SIS5513",
-		.init_chipset	= init_chipset_sis5513,
-		.init_hwif	= init_hwif_sis5513,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* SIS5513_H */
diff -puN drivers/ide/pci/sl82c105.c~ide_pci_headers drivers/ide/pci/sl82c105.c
--- linux-2.6.7-rc3/drivers/ide/pci/sl82c105.c~ide_pci_headers	2004-06-11 16:35:00.189589136 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/sl82c105.c	2004-06-11 16:35:00.246580472 +0200
@@ -29,8 +29,6 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 
-#include "sl82c105.h"
-
 #undef DEBUG
 
 #ifdef DEBUG
@@ -481,9 +479,20 @@ static void __init init_hwif_sl82c105(id
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
 
+static ide_pci_device_t sl82c105_chipset __devinitdata = {
+	.name		= "W82C105",
+	.init_chipset	= init_chipset_sl82c105,
+	.init_hwif	= init_hwif_sl82c105,
+	.init_dma	= init_dma_sl82c105,
+	.channels	= 2,
+	.autodma	= NOAUTODMA,
+	.enablebits	= {{0x40,0x01,0x01}, {0x40,0x10,0x10}},
+	.bootable	= ON_BOARD,
+};
+
 static int __devinit sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &sl82c105_chipsets[id->driver_data]);
+	ide_setup_pci_device(dev, &sl82c105_chipset);
 	return 0;
 }
 
diff -puN -L drivers/ide/pci/sl82c105.h drivers/ide/pci/sl82c105.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/sl82c105.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,25 +0,0 @@
-#ifndef W82C105_H
-#define W82C105_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-static unsigned int init_chipset_sl82c105(struct pci_dev *, const char *);
-static void init_hwif_sl82c105(ide_hwif_t *);
-static void init_dma_sl82c105(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t sl82c105_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "W82C105",
-		.init_chipset	= init_chipset_sl82c105,
-		.init_hwif	= init_hwif_sl82c105,
-		.init_dma	= init_dma_sl82c105,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x10,0x10}},
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* W82C105_H */
diff -puN drivers/ide/pci/slc90e66.c~ide_pci_headers drivers/ide/pci/slc90e66.c
--- linux-2.6.7-rc3/drivers/ide/pci/slc90e66.c~ide_pci_headers	2004-06-11 16:35:00.197587920 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/slc90e66.c	2004-06-11 16:35:00.248580168 +0200
@@ -21,7 +21,7 @@
 
 #include <asm/io.h>
 
-#include "slc90e66.h"
+#define DISPLAY_SLC90E66_TIMINGS
 
 #if defined(DISPLAY_SLC90E66_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
@@ -364,9 +364,19 @@ static void __init init_hwif_slc90e66 (i
 #endif /* !CONFIG_BLK_DEV_IDEDMA */
 }
 
+static ide_pci_device_t slc90e66_chipset __devinitdata = {
+	.name		= "SLC90E66",
+	.init_chipset	= init_chipset_slc90e66,
+	.init_hwif	= init_hwif_slc90e66,
+	.channels	= 2,
+	.autodma	= AUTODMA,
+	.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
+	.bootable	= ON_BOARD,
+};
+
 static int __devinit slc90e66_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &slc90e66_chipsets[id->driver_data]);
+	ide_setup_pci_device(dev, &slc90e66_chipset);
 	return 0;
 }
 
diff -puN -L drivers/ide/pci/slc90e66.h drivers/ide/pci/slc90e66.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/slc90e66.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,27 +0,0 @@
-#ifndef SLC90E66_H
-#define SLC90E66_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define DISPLAY_SLC90E66_TIMINGS
-
-#define SLC90E66_DEBUG_DRIVE_INFO	0
-
-static unsigned int init_chipset_slc90e66(struct pci_dev *, const char *);
-static void init_hwif_slc90e66(ide_hwif_t *);
-
-static ide_pci_device_t slc90e66_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "SLC90E66",
-		.init_chipset	= init_chipset_slc90e66,
-		.init_hwif	= init_hwif_slc90e66,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* SLC90E66_H */
diff -puN drivers/ide/pci/triflex.c~ide_pci_headers drivers/ide/pci/triflex.c
--- linux-2.6.7-rc3/drivers/ide/pci/triflex.c~ide_pci_headers	2004-06-11 16:35:00.205586704 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/triflex.c	2004-06-11 16:35:00.249580016 +0200
@@ -41,8 +41,6 @@
 #include <linux/ide.h>
 #include <linux/init.h>
 
-#include "triflex.h"
-
 static struct pci_dev *triflex_dev;
 
 #ifdef CONFIG_PROC_FS
@@ -217,15 +215,32 @@ static unsigned int __init init_chipset_
 	return 0;	
 }
 
+static ide_pci_device_t triflex_device __devinitdata = {
+	.name		= "TRIFLEX",
+	.init_chipset	= init_chipset_triflex,
+	.init_hwif	= init_hwif_triflex,
+	.channels	= 2,
+	.autodma	= AUTODMA,
+	.enablebits	= {{0x80, 0x01, 0x01}, {0x80, 0x02, 0x02}},
+	.bootable	= ON_BOARD,
+};
+
 static int __devinit triflex_init_one(struct pci_dev *dev, 
 		const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &triflex_devices[id->driver_data]);
+	ide_setup_pci_device(dev, &triflex_device);
 	triflex_dev = dev;
 
 	return 0;
 }
 
+static struct pci_device_id triflex_pci_tbl[] = {
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
+
 static struct pci_driver driver = {
 	.name		= "TRIFLEX IDE",
 	.id_table	= triflex_pci_tbl,
diff -puN -L drivers/ide/pci/triflex.h drivers/ide/pci/triflex.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/triflex.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,37 +0,0 @@
-/* 
- * triflex.h
- *
- * Copyright (C) 2002 Hewlett-Packard Development Group, L.P.
- * Author: Torben Mathiasen <torben.mathiasen@hp.com>
- *
- */
-#ifndef TRIFLEX_H
-#define TRIFLEX_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-static unsigned int __devinit init_chipset_triflex(struct pci_dev *, const char *);
-static void init_hwif_triflex(ide_hwif_t *);
-
-static ide_pci_device_t triflex_devices[] __devinitdata = {
-	{
-		.name		= "TRIFLEX",
-		.init_chipset	= init_chipset_triflex,
-		.init_hwif	= init_hwif_triflex,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x80, 0x01, 0x01}, {0x80, 0x02, 0x02}},
-		.bootable	= ON_BOARD,
-	}
-};
-
-static struct pci_device_id triflex_pci_tbl[] = {
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE, PCI_ANY_ID, 
-		PCI_ANY_ID, 0, 0, 0 },
-	{ 0, },
-};
-MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
-
-#endif /* TRIFLEX_H */
diff -puN drivers/ide/pci/trm290.c~ide_pci_headers drivers/ide/pci/trm290.c
--- linux-2.6.7-rc3/drivers/ide/pci/trm290.c~ide_pci_headers	2004-06-11 16:35:00.213585488 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/trm290.c	2004-06-11 16:35:00.251579712 +0200
@@ -140,8 +140,6 @@
 
 #include <asm/io.h>
 
-#include "trm290.h"
-
 static void trm290_prepare_drive (ide_drive_t *drive, unsigned int use_dma)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -395,9 +393,17 @@ void __devinit init_hwif_trm290(ide_hwif
 #endif
 }
 
+static ide_pci_device_t trm290_chipset __devinitdata = {
+	.name		= "TRM290",
+	.init_hwif	= init_hwif_trm290,
+	.channels	= 2,
+	.autodma	= NOAUTODMA,
+	.bootable	= ON_BOARD,
+};
+
 static int __devinit trm290_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &trm290_chipsets[id->driver_data]);
+	ide_setup_pci_device(dev, &trm290_chipset);
 	return 0;
 }
 
diff -puN -L drivers/ide/pci/trm290.h drivers/ide/pci/trm290.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/trm290.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,20 +0,0 @@
-#ifndef TRM290_H
-#define TRM290_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-extern void init_hwif_trm290(ide_hwif_t *);
-
-static ide_pci_device_t trm290_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "TRM290",
-		.init_hwif	= init_hwif_trm290,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* TRM290_H */
diff -puN drivers/ide/pci/via82cxxx.c~ide_pci_headers drivers/ide/pci/via82cxxx.c
--- linux-2.6.7-rc3/drivers/ide/pci/via82cxxx.c~ide_pci_headers	2004-06-11 16:35:00.222584120 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/via82cxxx.c	2004-06-11 16:35:00.252579560 +0200
@@ -37,7 +37,8 @@
 #include <asm/io.h>
 
 #include "ide-timing.h"
-#include "via82cxxx.h"
+
+#define DISPLAY_VIA_TIMINGS
 
 #define VIA_IDE_ENABLE		0x40
 #define VIA_IDE_CONFIG		0x41
@@ -607,9 +608,19 @@ static void __init init_hwif_via82cxxx(i
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+static ide_pci_device_t via82cxxx_chipset __devinitdata = {
+	.name		= "VP_IDE",
+	.init_chipset	= init_chipset_via82cxxx,
+	.init_hwif	= init_hwif_via82cxxx,
+	.channels	= 2,
+	.autodma	= NOAUTODMA,
+	.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
+	.bootable	= ON_BOARD,
+};
+
 static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &via82cxxx_chipsets[id->driver_data]);
+	ide_setup_pci_device(dev, &via82cxxx_chipset);
 	return 0;
 }
 
diff -puN -L drivers/ide/pci/via82cxxx.h drivers/ide/pci/via82cxxx.h~ide_pci_headers /dev/null
--- linux-2.6.7-rc3/drivers/ide/pci/via82cxxx.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,25 +0,0 @@
-#ifndef VIA82CXXX_H
-#define VIA82CXXX_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define DISPLAY_VIA_TIMINGS
-
-static unsigned int init_chipset_via82cxxx(struct pci_dev *, const char *);
-static void init_hwif_via82cxxx(ide_hwif_t *);
-
-static ide_pci_device_t via82cxxx_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "VP_IDE",
-		.init_chipset	= init_chipset_via82cxxx,
-		.init_hwif	= init_hwif_via82cxxx,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* VIA82CXXX_H */

_

