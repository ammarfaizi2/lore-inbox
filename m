Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUFKQQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUFKQQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUFKQQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:16:36 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8089 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264101AbUFKQPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:15:49 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Fri, 11 Jun 2004 17:50:30 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111750.30312.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Probably some drivers are still missed because I changed only
these drivers that I knew that there are PCI cards using them.

If you know about PCI cards using other drivers please speak up.

[PATCH] ide: PCI hotplugging fixes

Extracted from the Debian kernel package.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/aec62xx.c      |   10 ++++----
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/cmd64x.c       |    6 ++---
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/hpt34x.c       |    4 +--
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/hpt366.c       |   16 +++++++-------
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/pdc202xx_new.c |   10 ++++----
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/pdc202xx_old.c |   12 +++++-----
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/siimage.c      |   18 ++++++++--------
 linux-2.6.7-rc3-bzolnier/drivers/ide/pci/trm290.c       |    2 -
 8 files changed, 39 insertions(+), 39 deletions(-)

diff -puN drivers/ide/pci/aec62xx.c~ide_pci_fixes drivers/ide/pci/aec62xx.c
--- linux-2.6.7-rc3/drivers/ide/pci/aec62xx.c~ide_pci_fixes	2004-06-11 15:54:58.655677784 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/aec62xx.c	2004-06-11 15:56:03.099880776 +0200
@@ -409,7 +409,7 @@ static int aec62xx_irq_timeout (ide_driv
 	return 0;
 }
 
-static unsigned int __init init_chipset_aec62xx (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_aec62xx(struct pci_dev *dev, const char *name)
 {
 	int bus_speed = system_bus_clock();
 
@@ -435,7 +435,7 @@ static unsigned int __init init_chipset_
 	return dev->irq;
 }
 
-static void __init init_hwif_aec62xx (ide_hwif_t *hwif)
+static void __devinit init_hwif_aec62xx(ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 	hwif->tuneproc = &aec62xx_tune_drive;
@@ -468,7 +468,7 @@ static void __init init_hwif_aec62xx (id
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static void __init init_dma_aec62xx (ide_hwif_t *hwif, unsigned long dmabase)
+static void __devinit init_dma_aec62xx(ide_hwif_t *hwif, unsigned long dmabase)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
 
@@ -490,12 +490,12 @@ static void __init init_dma_aec62xx (ide
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static void __init init_setup_aec62xx (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_aec62xx(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	ide_setup_pci_device(dev, d);
 }
 
-static void __init init_setup_aec6x80 (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_aec6x80(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	unsigned long bar4reg = pci_resource_start(dev, 4);
 
diff -puN drivers/ide/pci/cmd64x.c~ide_pci_fixes drivers/ide/pci/cmd64x.c
--- linux-2.6.7-rc3/drivers/ide/pci/cmd64x.c~ide_pci_fixes	2004-06-11 15:54:58.659677176 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/cmd64x.c	2004-06-11 15:57:19.695236512 +0200
@@ -586,7 +586,7 @@ static int cmd646_1_ide_dma_end (ide_dri
 	return (dma_stat & 7) != 4;
 }
 
-static unsigned int __init init_chipset_cmd64x (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_cmd64x(struct pci_dev *dev, const char *name)
 {
 	u32 class_rev = 0;
 	u8 mrdmode = 0;
@@ -674,7 +674,7 @@ static unsigned int __init init_chipset_
 	return 0;
 }
 
-static unsigned int __init ata66_cmd64x (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_cmd64x(ide_hwif_t *hwif)
 {
 	u8 ata66 = 0, mask = (hwif->channel) ? 0x02 : 0x01;
 
@@ -689,7 +689,7 @@ static unsigned int __init ata66_cmd64x 
 	return (ata66 & mask) ? 1 : 0;
 }
 
-static void __init init_hwif_cmd64x (ide_hwif_t *hwif)
+static void __devinit init_hwif_cmd64x(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
 	unsigned int class_rev;
diff -puN drivers/ide/pci/hpt34x.c~ide_pci_fixes drivers/ide/pci/hpt34x.c
--- linux-2.6.7-rc3/drivers/ide/pci/hpt34x.c~ide_pci_fixes	2004-06-11 15:54:58.671675352 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/hpt34x.c	2004-06-11 15:58:40.615934696 +0200
@@ -235,7 +235,7 @@ no_dma_set:
  */
 #define	HPT34X_PCI_INIT_REG		0x80
 
-static unsigned int __init init_chipset_hpt34x (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_hpt34x(struct pci_dev *dev, const char *name)
 {
 	int i = 0;
 	unsigned long hpt34xIoBase = pci_resource_start(dev, 4);
@@ -289,7 +289,7 @@ static unsigned int __init init_chipset_
 	return dev->irq;
 }
 
-static void __init init_hwif_hpt34x (ide_hwif_t *hwif)
+static void __devinit init_hwif_hpt34x(ide_hwif_t *hwif)
 {
 	u16 pcicmd = 0;
 
diff -puN drivers/ide/pci/hpt366.c~ide_pci_fixes drivers/ide/pci/hpt366.c
--- linux-2.6.7-rc3/drivers/ide/pci/hpt366.c~ide_pci_fixes	2004-06-11 15:54:58.675674744 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/hpt366.c	2004-06-11 16:00:16.230399088 +0200
@@ -795,7 +795,7 @@ static int hpt370_busproc(ide_drive_t * 
 	return 0;
 }
 
-static int __init init_hpt37x(struct pci_dev *dev)
+static int __devinit init_hpt37x(struct pci_dev *dev)
 {
 	int adjust, i;
 	u16 freq;
@@ -923,7 +923,7 @@ init_hpt37X_done:
 	return 0;
 }
 
-static int __init init_hpt366 (struct pci_dev *dev)
+static int __devinit init_hpt366(struct pci_dev *dev)
 {
 	u32 reg1	= 0;
 	u8 drive_fast	= 0;
@@ -958,7 +958,7 @@ static int __init init_hpt366 (struct pc
 	return 0;
 }
 
-static unsigned int __init init_chipset_hpt366 (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_hpt366(struct pci_dev *dev, const char *name)
 {
 	int ret = 0;
 	u8 test = 0;
@@ -1004,7 +1004,7 @@ static unsigned int __init init_chipset_
 	return dev->irq;
 }
 
-static void __init init_hwif_hpt366 (ide_hwif_t *hwif)
+static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev		= hwif->pci_dev;
 	u8 ata66 = 0, regmask		= (hwif->channel) ? 0x01 : 0x02;
@@ -1116,7 +1116,7 @@ static void __init init_hwif_hpt366 (ide
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static void __init init_dma_hpt366 (ide_hwif_t *hwif, unsigned long dmabase)
+static void __devinit init_dma_hpt366(ide_hwif_t *hwif, unsigned long dmabase)
 {
 	u8 masterdma	= 0, slavedma = 0;
 	u8 dma_new	= 0, dma_old = 0;
@@ -1151,7 +1151,7 @@ static void __init init_dma_hpt366 (ide_
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static void __init init_setup_hpt374 (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_hpt374(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *findev = NULL;
 
@@ -1176,12 +1176,12 @@ static void __init init_setup_hpt374 (st
 	ide_setup_pci_device(dev, d);
 }
 
-static void __init init_setup_hpt37x (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_hpt37x(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	ide_setup_pci_device(dev, d);
 }
 
-static void __init init_setup_hpt366 (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_hpt366(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *findev = NULL;
 	u8 pin1 = 0, pin2 = 0;
diff -puN drivers/ide/pci/pdc202xx_new.c~ide_pci_fixes drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.7-rc3/drivers/ide/pci/pdc202xx_new.c~ide_pci_fixes	2004-06-11 15:54:58.679674136 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/pdc202xx_new.c	2004-06-11 16:02:00.526543664 +0200
@@ -404,7 +404,7 @@ static void __devinit apple_kiwi_init(st
 }
 #endif /* CONFIG_PPC_PMAC */
 
-static unsigned int __init init_chipset_pdcnew (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_pdcnew(struct pci_dev *dev, const char *name)
 {
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
@@ -429,7 +429,7 @@ static unsigned int __init init_chipset_
 	return dev->irq;
 }
 
-static void __init init_hwif_pdc202new (ide_hwif_t *hwif)
+static void __devinit init_hwif_pdc202new(ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 
@@ -457,12 +457,12 @@ static void __init init_hwif_pdc202new (
 #endif /* PDC202_DEBUG_CABLE */
 }
 
-static void __init init_setup_pdcnew (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_pdcnew(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	ide_setup_pci_device(dev, d);
 }
 
-static void __init init_setup_pdc20270 (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_pdc20270(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *findev = NULL;
 
@@ -488,7 +488,7 @@ static void __init init_setup_pdc20270 (
 	ide_setup_pci_device(dev, d);
 }
 
-static void __init init_setup_pdc20276 (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_pdc20276(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	if ((dev->bus->self) &&
 	    (dev->bus->self->vendor == PCI_VENDOR_ID_INTEL) &&
diff -puN drivers/ide/pci/pdc202xx_old.c~ide_pci_fixes drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.7-rc3/drivers/ide/pci/pdc202xx_old.c~ide_pci_fixes	2004-06-11 15:54:58.682673680 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/pdc202xx_old.c	2004-06-11 16:03:21.125290792 +0200
@@ -670,7 +670,7 @@ static int pdc202xx_tristate (ide_drive_
 	return 0;
 }
 
-static unsigned int __init init_chipset_pdc202xx (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_pdc202xx(struct pci_dev *dev, const char *name)
 {
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
@@ -715,7 +715,7 @@ static unsigned int __init init_chipset_
 	return dev->irq;
 }
 
-static void __init init_hwif_pdc202xx (ide_hwif_t *hwif)
+static void __devinit init_hwif_pdc202xx(ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 	hwif->tuneproc  = &config_chipset_for_pio;
@@ -755,7 +755,7 @@ static void __init init_hwif_pdc202xx (i
 #endif /* PDC202_DEBUG_CABLE */	
 }
 
-static void __init init_dma_pdc202xx (ide_hwif_t *hwif, unsigned long dmabase)
+static void __devinit init_dma_pdc202xx(ide_hwif_t *hwif, unsigned long dmabase)
 {
 	u8 udma_speed_flag = 0, primary_mode = 0, secondary_mode = 0;
 
@@ -807,7 +807,7 @@ static void __init init_dma_pdc202xx (id
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static void __init init_setup_pdc202ata4 (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_pdc202ata4(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE) {
 		u8 irq = 0, irq2 = 0;
@@ -837,7 +837,7 @@ static void __init init_setup_pdc202ata4
 	ide_setup_pci_device(dev, d);
 }
 
-static void __init init_setup_pdc20265 (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_pdc20265(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	if ((dev->bus->self) &&
 	    (dev->bus->self->vendor == PCI_VENDOR_ID_INTEL) &&
@@ -866,7 +866,7 @@ static void __init init_setup_pdc20265 (
 	ide_setup_pci_device(dev, d);
 }
 
-static void __init init_setup_pdc202xx (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_pdc202xx(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	ide_setup_pci_device(dev, d);
 }
diff -puN drivers/ide/pci/siimage.c~ide_pci_fixes drivers/ide/pci/siimage.c
--- linux-2.6.7-rc3/drivers/ide/pci/siimage.c~ide_pci_fixes	2004-06-11 15:54:58.686673072 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/siimage.c	2004-06-11 16:05:25.028454648 +0200
@@ -812,7 +812,7 @@ static unsigned int setup_mmio_siimage (
  *	to 133MHz clocking if the system isn't already set up to do it.
  */
 
-static unsigned int __init init_chipset_siimage (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_siimage(struct pci_dev *dev, const char *name)
 {
 	u32 class_rev	= 0;
 	u8 tmpbyte	= 0;
@@ -877,8 +877,8 @@ static unsigned int __init init_chipset_
  *	The hardware supports buffered taskfiles and also some rather nice
  *	extended PRD tables. Unfortunately right now we don't.
  */
- 
-static void __init init_mmio_iops_siimage (ide_hwif_t *hwif)
+
+static void __devinit init_mmio_iops_siimage(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
 	void *addr		= pci_get_drvdata(dev);
@@ -996,8 +996,8 @@ static int is_dev_seagate_sata(ide_drive
  *	look in we get for setting up the hwif so that we
  *	can get the iops right before using them.
  */
- 
-static void __init init_iops_siimage (ide_hwif_t *hwif)
+
+static void __devinit init_iops_siimage(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
 	u32 class_rev		= 0;
@@ -1023,8 +1023,8 @@ static void __init init_iops_siimage (id
  *	Check for the presence of an ATA66 capable cable on the
  *	interface.
  */
- 
-static unsigned int __init ata66_siimage (ide_hwif_t *hwif)
+
+static unsigned int __devinit ata66_siimage(ide_hwif_t *hwif)
 {
 	unsigned long addr = siimage_selreg(hwif, 0);
 	if (pci_get_drvdata(hwif->pci_dev) == NULL) {
@@ -1044,8 +1044,8 @@ static unsigned int __init ata66_siimage
  *	requires several custom handlers so we override the default
  *	ide DMA handlers appropriately
  */
- 
-static void __init init_hwif_siimage (ide_hwif_t *hwif)
+
+static void __devinit init_hwif_siimage(ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 	
diff -puN drivers/ide/pci/trm290.c~ide_pci_fixes drivers/ide/pci/trm290.c
--- linux-2.6.7-rc3/drivers/ide/pci/trm290.c~ide_pci_fixes	2004-06-11 15:54:58.691672312 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/pci/trm290.c	2004-06-11 16:06:21.250907536 +0200
@@ -302,7 +302,7 @@ static int trm290_ide_dma_test_irq (ide_
 /*
  * Invoked from ide-dma.c at boot time.
  */
-void __init init_hwif_trm290 (ide_hwif_t *hwif)
+void __devinit init_hwif_trm290(ide_hwif_t *hwif)
 {
 	unsigned int cfgbase = 0;
 	unsigned long flags;

_

