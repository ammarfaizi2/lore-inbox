Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265266AbUFAWsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbUFAWsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265284AbUFAWiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:38:21 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13221 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265267AbUFAWac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:30:32 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update [3/10]
Date: Wed, 2 Jun 2004 00:18:11 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406020018.11589.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: ide_pci_device_t sanitization

- convert ->isa_ports into ->flags (IDEPCI_FLAG_ISA_PORTS)
- add IDEPCI_FLAG_{OBS_FORCE_PDC,FORCE_MASTER} flags
  and use them in setup-pci.c
- use struct pci_dev ->vendor and ->device fields directly
  in generic.c and serverworks.c
- remove no longer needed debug checks (dev->device != d->device)
- remove ->vendor and ->device fields from ide_pci_device_t
- misc cleanups

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/aec62xx.c      |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/aec62xx.h      |   10 --
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/alim15x3.h     |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/amd74xx.c      |    1 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/amd74xx.h      |   26 ------
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/atiixp.c       |    8 --
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cmd64x.c       |    5 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cmd64x.h       |    8 --
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cs5520.h       |    8 --
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cs5530.c       |    5 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cs5530.h       |    3 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cy82c693.h     |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/generic.c      |   12 +--
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/generic.h      |   28 -------
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/hpt34x.h       |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/hpt366.c       |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/hpt366.h       |   10 --
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/it8172.c       |    3 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/it8172.h       |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/ns87415.c      |    5 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/ns87415.h      |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/opti621.c      |    5 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/opti621.h      |    4 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/pdc202xx_new.c |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/pdc202xx_new.h |   14 ---
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/pdc202xx_old.c |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/pdc202xx_old.h |   12 ---
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/piix.c         |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/piix.h         |   46 +++++-------
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/rz1000.c       |    5 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/rz1000.h       |    6 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sc1200.c       |    5 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sc1200.h       |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/serverworks.c  |    6 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/serverworks.h  |    8 --
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sgiioc4.c      |   13 ---
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/siimage.c      |    5 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/siimage.h      |    6 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sis5513.c      |    5 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sis5513.h      |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sl82c105.c     |    5 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sl82c105.h     |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/slc90e66.c     |    5 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/slc90e66.h     |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/triflex.c      |    8 --
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/triflex.h      |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/trm290.c       |    5 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/trm290.h       |    2 
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/via82cxxx.c    |    7 -
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/via82cxxx.h    |   12 ---
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/setup-pci.c        |   21 +----
 linux-2.6.7-rc2-bk2-bzolnier/include/linux/ide.h            |   12 ++-
 52 files changed, 65 insertions(+), 314 deletions(-)

diff -puN drivers/ide/pci/aec62xx.c~ide_pci_ids drivers/ide/pci/aec62xx.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/aec62xx.c~ide_pci_ids	2004-06-01 21:04:37.395408344 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/aec62xx.c	2004-06-01 21:04:37.634372016 +0200
@@ -525,8 +525,6 @@ static int __devinit aec62xx_init_one(st
 {
 	ide_pci_device_t *d = &aec62xx_chipsets[id->driver_data];
 
-	if (dev->device != d->device)
-		BUG();
 	d->init_setup(dev, d);
 	return 0;
 }
diff -puN drivers/ide/pci/aec62xx.h~ide_pci_ids drivers/ide/pci/aec62xx.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/aec62xx.h~ide_pci_ids	2004-06-01 21:04:37.407406520 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/aec62xx.h	2004-06-01 21:04:37.635371864 +0200
@@ -78,8 +78,6 @@ static void init_dma_aec62xx(ide_hwif_t 
 
 static ide_pci_device_t aec62xx_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_ARTOP,
-		.device		= PCI_DEVICE_ID_ARTOP_ATP850UF,
 		.name		= "AEC6210",
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
@@ -90,8 +88,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= OFF_BOARD,
 	},{	/* 1 */
-		.vendor		= PCI_VENDOR_ID_ARTOP,
-		.device		= PCI_DEVICE_ID_ARTOP_ATP860,
 		.name		= "AEC6260",
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
@@ -101,8 +97,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.autodma	= NOAUTODMA,
 		.bootable	= OFF_BOARD,
 	},{	/* 2 */
-		.vendor		= PCI_VENDOR_ID_ARTOP,
-		.device		= PCI_DEVICE_ID_ARTOP_ATP860R,
 		.name		= "AEC6260R",
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
@@ -113,8 +107,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= NEVER_BOARD,
 	},{	/* 3 */
-		.vendor		= PCI_VENDOR_ID_ARTOP,
-		.device		= PCI_DEVICE_ID_ARTOP_ATP865,
 		.name		= "AEC6X80",
 		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
@@ -124,8 +116,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 	},{	/* 4 */
-		.vendor		= PCI_VENDOR_ID_ARTOP,
-		.device		= PCI_DEVICE_ID_ARTOP_ATP865R,
 		.name		= "AEC6X80R",
 		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
diff -puN drivers/ide/pci/alim15x3.h~ide_pci_ids drivers/ide/pci/alim15x3.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/alim15x3.h~ide_pci_ids	2004-06-01 21:04:37.411405912 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/alim15x3.h	2004-06-01 21:04:43.216523400 +0200
@@ -14,8 +14,6 @@ static void init_dma_ali15x3(ide_hwif_t 
 
 static ide_pci_device_t ali15x3_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_AL,
-		.device		= PCI_DEVICE_ID_AL_M5229,
 		.name		= "ALI15X3",
 		.init_chipset	= init_chipset_ali15x3,
 		.init_hwif	= init_hwif_ali15x3,
diff -puN drivers/ide/pci/amd74xx.c~ide_pci_ids drivers/ide/pci/amd74xx.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/amd74xx.c~ide_pci_ids	2004-06-01 21:04:37.414405456 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/amd74xx.c	2004-06-01 21:04:37.636371712 +0200
@@ -445,7 +445,6 @@ static int __devinit amd74xx_probe(struc
 {
 	amd_chipset = amd74xx_chipsets + id->driver_data;
 	amd_config = amd_ide_chips + id->driver_data;
-	if (dev->device != amd_chipset->device) BUG();
 	if (dev->device != amd_config->id) BUG();
 	ide_setup_pci_device(dev, amd_chipset);
 	return 0;
diff -puN drivers/ide/pci/amd74xx.h~ide_pci_ids drivers/ide/pci/amd74xx.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/amd74xx.h~ide_pci_ids	2004-06-01 21:04:37.424403936 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/amd74xx.h	2004-06-01 21:04:37.638371408 +0200
@@ -12,8 +12,6 @@ static void init_hwif_amd74xx(ide_hwif_t
 
 static ide_pci_device_t amd74xx_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_AMD,
-		.device		= PCI_DEVICE_ID_AMD_COBRA_7401,
 		.name		= "AMD7401",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -22,8 +20,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
-		.vendor		= PCI_VENDOR_ID_AMD,
-		.device		= PCI_DEVICE_ID_AMD_VIPER_7409,
 		.name		= "AMD7409",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -32,8 +28,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 	},{	/* 2 */
-		.vendor		= PCI_VENDOR_ID_AMD,
-		.device		= PCI_DEVICE_ID_AMD_VIPER_7411,
 		.name		= "AMD7411",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -42,8 +36,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 	},{	/* 3 */
-		.vendor		= PCI_VENDOR_ID_AMD,
-		.device		= PCI_DEVICE_ID_AMD_OPUS_7441,
 		.name		= "AMD7441",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -52,8 +44,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 	},{	/* 4 */
-		.vendor		= PCI_VENDOR_ID_AMD,
-		.device		= PCI_DEVICE_ID_AMD_8111_IDE,
 		.name		= "AMD8111",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -63,8 +53,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.bootable	= ON_BOARD,
 	},
 	{	/* 5 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_IDE,
 		.name		= "NFORCE",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -74,8 +62,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.bootable	= ON_BOARD,
 	},
 	{	/* 6 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,
 		.name		= "NFORCE2",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -85,8 +71,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.bootable	= ON_BOARD,
 	},
 	{	/* 7 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,
 		.name		= "NFORCE2S",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -96,8 +80,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.bootable	= ON_BOARD,
 	},
 	{	/* 8 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
 		.name		= "NFORCE2S-SATA",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -107,8 +89,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.bootable	= ON_BOARD,
 	},
 	{	/* 9 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,
 		.name		= "NFORCE3",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -118,8 +98,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.bootable	= ON_BOARD,
 	},
 	{	/* 10 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,
 		.name		= "NFORCE3S",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -129,8 +107,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.bootable	= ON_BOARD,
 	},
 	{	/* 11 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
 		.name		= "NFORCE3S-SATA",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
@@ -140,8 +116,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.bootable	= ON_BOARD,
 	},
 	{	/* 12 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
 		.name		= "NFORCE3S-SATA2",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
diff -puN drivers/ide/pci/atiixp.c~ide_pci_ids drivers/ide/pci/atiixp.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/atiixp.c~ide_pci_ids	2004-06-01 21:04:37.428403328 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/atiixp.c	2004-06-01 21:04:37.639371256 +0200
@@ -458,8 +458,6 @@ static void __devinit init_hwif_atiixp(i
 
 static ide_pci_device_t atiixp_pci_info[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_ATI,
-		.device		= PCI_DEVICE_ID_ATI_IXP_IDE,
 		.name		= "ATIIXP",
 		.init_chipset	= init_chipset_atiixp,
 		.init_hwif	= init_hwif_atiixp,
@@ -481,11 +479,7 @@ static ide_pci_device_t atiixp_pci_info[
 
 static int __devinit atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &atiixp_pci_info[id->driver_data];
-
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &atiixp_pci_info[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/cmd64x.c~ide_pci_ids drivers/ide/pci/cmd64x.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/cmd64x.c~ide_pci_ids	2004-06-01 21:04:37.432402720 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cmd64x.c	2004-06-01 21:04:37.640371104 +0200
@@ -746,10 +746,7 @@ static void __init init_hwif_cmd64x (ide
 
 static int __devinit cmd64x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &cmd64x_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &cmd64x_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/cmd64x.h~ide_pci_ids drivers/ide/pci/cmd64x.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/cmd64x.h~ide_pci_ids	2004-06-01 21:04:37.436402112 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cmd64x.h	2004-06-01 21:04:37.641370952 +0200
@@ -65,8 +65,6 @@ static void init_hwif_cmd64x(ide_hwif_t 
 
 static ide_pci_device_t cmd64x_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_CMD,
-		.device		= PCI_DEVICE_ID_CMD_643,
 		.name		= "CMD643",
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
@@ -74,8 +72,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
-		.vendor		= PCI_VENDOR_ID_CMD,
-		.device		= PCI_DEVICE_ID_CMD_646,
 		.name		= "CMD646",
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
@@ -84,8 +80,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x80,0x80}},
 		.bootable	= ON_BOARD,
 	},{	/* 2 */
-		.vendor		= PCI_VENDOR_ID_CMD,
-		.device	= PCI_DEVICE_ID_CMD_648,
 		.name		= "CMD648",
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
@@ -93,8 +87,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{
-		.vendor		= PCI_VENDOR_ID_CMD,
-		.device		= PCI_DEVICE_ID_CMD_649,
 		.name		= "CMD649",
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
diff -puN drivers/ide/pci/cs5520.h~ide_pci_ids drivers/ide/pci/cs5520.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/cs5520.h~ide_pci_ids	2004-06-01 21:04:37.439401656 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cs5520.h	2004-06-01 21:04:37.642370800 +0200
@@ -13,28 +13,24 @@ static void cs5520_init_setup_dma(struct
 
 static ide_pci_device_t cyrix_chipsets[] __devinitdata = {
 	{
-		.vendor		= PCI_VENDOR_ID_CYRIX,
-		.device		= PCI_DEVICE_ID_CYRIX_5510,
 		.name		= "Cyrix 5510",
 		.init_chipset	= init_chipset_cs5520,
 		.init_setup_dma = cs5520_init_setup_dma,
 		.init_hwif	= init_hwif_cs5520,
-		.isa_ports	= 1,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.flags		= IDEPCI_FLAG_ISA_PORTS,
 	},
 	{
-		.vendor		= PCI_VENDOR_ID_CYRIX,
-		.device		= PCI_DEVICE_ID_CYRIX_5520,
 		.name		= "Cyrix 5520",
 		.init_chipset	= init_chipset_cs5520,
 		.init_setup_dma = cs5520_init_setup_dma,
 		.init_hwif	= init_hwif_cs5520,
-		.isa_ports	= 1,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.flags		= IDEPCI_FLAG_ISA_PORTS,
 	}
 };
 
diff -puN drivers/ide/pci/cs5530.c~ide_pci_ids drivers/ide/pci/cs5530.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/cs5530.c~ide_pci_ids	2004-06-01 21:04:37.443401048 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cs5530.c	2004-06-01 21:04:37.642370800 +0200
@@ -406,10 +406,7 @@ static void __init init_hwif_cs5530 (ide
 
 static int __devinit cs5530_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &cs5530_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &cs5530_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/cs5530.h~ide_pci_ids drivers/ide/pci/cs5530.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/cs5530.h~ide_pci_ids	2004-06-01 21:04:37.449400136 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cs5530.h	2004-06-01 21:04:37.643370648 +0200
@@ -12,14 +12,13 @@ static void init_hwif_cs5530(ide_hwif_t 
 
 static ide_pci_device_t cs5530_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_CYRIX,
-		.device		= PCI_DEVICE_ID_CYRIX_5530_IDE,
 		.name		= "CS5530",
 		.init_chipset	= init_chipset_cs5530,
 		.init_hwif	= init_hwif_cs5530,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.flags		= IDEPCI_FLAG_FORCE_MASTER,
 	}
 };
 
diff -puN drivers/ide/pci/cy82c693.h~ide_pci_ids drivers/ide/pci/cy82c693.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/cy82c693.h~ide_pci_ids	2004-06-01 21:04:37.453399528 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/cy82c693.h	2004-06-01 21:04:37.644370496 +0200
@@ -70,8 +70,6 @@ static void init_iops_cy82c693(ide_hwif_
 
 static ide_pci_device_t cy82c693_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_CONTAQ,
-		.device		= PCI_DEVICE_ID_CONTAQ_82C693,
 		.name		= "CY82C693",
 		.init_chipset	= init_chipset_cy82c693,
 		.init_iops	= init_iops_cy82c693,
diff -puN drivers/ide/pci/generic.c~ide_pci_ids drivers/ide/pci/generic.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/generic.c~ide_pci_ids	2004-06-01 21:04:37.456399072 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/generic.c	2004-06-01 21:04:37.646370192 +0200
@@ -77,8 +77,6 @@ static void __init init_hwif_generic (id
 
 	if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		ide_pci_device_t *unknown = unknown_chipset;
-//		unknown->vendor = dev->vendor;
-//		unknown->device = dev->device;
 		init_setup_unknown(dev, unknown);
 		return 1;
 	}
@@ -99,15 +97,13 @@ static int __devinit generic_init_one(st
 	ide_pci_device_t *d = &generic_chipsets[id->driver_data];
 	u16 command;
 
-	if (dev->device != d->device)
-		BUG();
-	if ((d->vendor == PCI_VENDOR_ID_UMC) &&
-	    (d->device == PCI_DEVICE_ID_UMC_UM8886A) &&
+	if (dev->vendor == PCI_VENDOR_ID_UMC &&
+	    dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
 	    (!(PCI_FUNC(dev->devfn) & 1)))
 		return 1; /* UM8886A/BF pair */
 
-	if ((d->vendor == PCI_VENDOR_ID_OPTI) &&
-	    (d->device == PCI_DEVICE_ID_OPTI_82C558) &&
+	if (dev->vendor == PCI_VENDOR_ID_OPTI &&
+	    dev->device == PCI_DEVICE_ID_OPTI_82C558 &&
 	    (!(PCI_FUNC(dev->devfn) & 1)))
 		return 1;
 
diff -puN drivers/ide/pci/generic.h~ide_pci_ids drivers/ide/pci/generic.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/generic.h~ide_pci_ids	2004-06-01 21:04:37.471396792 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/generic.h	2004-06-01 21:04:37.647370040 +0200
@@ -10,8 +10,6 @@ static void init_hwif_generic(ide_hwif_t
 
 static ide_pci_device_t generic_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_NS,
-		.device		= PCI_DEVICE_ID_NS_87410,
 		.name		= "NS87410",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -20,8 +18,6 @@ static ide_pci_device_t generic_chipsets
 		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
 		.bootable	= ON_BOARD,
         },{	/* 1 */
-		.vendor		= PCI_VENDOR_ID_PCTECH,
-		.device		= PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,
 		.name		= "SAMURAI",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -29,8 +25,6 @@ static ide_pci_device_t generic_chipsets
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 2 */
-		.vendor		= PCI_VENDOR_ID_HOLTEK,
-		.device		= PCI_DEVICE_ID_HOLTEK_6565,
 		.name		= "HT6565",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -38,8 +32,6 @@ static ide_pci_device_t generic_chipsets
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 3 */
-		.vendor		= PCI_VENDOR_ID_UMC,
-		.device		= PCI_DEVICE_ID_UMC_UM8673F,
 		.name		= "UM8673F",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -47,8 +39,6 @@ static ide_pci_device_t generic_chipsets
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 4 */
-		.vendor		= PCI_VENDOR_ID_UMC,
-		.device		= PCI_DEVICE_ID_UMC_UM8886A,
 		.name		= "UM8886A",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -56,8 +46,6 @@ static ide_pci_device_t generic_chipsets
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 5 */
-		.vendor		= PCI_VENDOR_ID_UMC,
-		.device		= PCI_DEVICE_ID_UMC_UM8886BF,
 		.name		= "UM8886BF",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -65,8 +53,6 @@ static ide_pci_device_t generic_chipsets
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 6 */
-		.vendor		= PCI_VENDOR_ID_HINT,
-		.device		= PCI_DEVICE_ID_HINT_VXPROII_IDE,
 		.name		= "HINT_IDE",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -74,8 +60,6 @@ static ide_pci_device_t generic_chipsets
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 7 */
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device		= PCI_DEVICE_ID_VIA_82C561,
 		.name		= "VIA_IDE",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -83,8 +67,6 @@ static ide_pci_device_t generic_chipsets
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 8 */
-		.vendor		= PCI_VENDOR_ID_OPTI,
-		.device		= PCI_DEVICE_ID_OPTI_82C558,
 		.name		= "OPTI621V",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -92,8 +74,6 @@ static ide_pci_device_t generic_chipsets
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 9 */
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device		= PCI_DEVICE_ID_VIA_8237_SATA,
 		.name		= "VIA8237SATA",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -101,8 +81,6 @@ static ide_pci_device_t generic_chipsets
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 	},{ /* 10 */
-		.vendor		= PCI_VENDOR_ID_TOSHIBA,
-		.device		= PCI_DEVICE_ID_TOSHIBA_PICCOLO,
 		.name 		= "Piccolo0102",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -110,8 +88,6 @@ static ide_pci_device_t generic_chipsets
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
 	},{ /* 11 */
-		.vendor		= PCI_VENDOR_ID_TOSHIBA,
-		.device		= PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,
 		.name 		= "Piccolo0103",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -119,8 +95,6 @@ static ide_pci_device_t generic_chipsets
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
 	},{ /* 12 */
-		.vendor		= PCI_VENDOR_ID_TOSHIBA,
-		.device		= PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,
 		.name 		= "Piccolo0105",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
@@ -133,8 +107,6 @@ static ide_pci_device_t generic_chipsets
 #if 0
 static ide_pci_device_t unknown_chipset[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= 0,
-		.device		= 0,
 		.name		= "PCI_IDE",
 		.init_chipset	= init_chipset_generic,
 		.init_hwif	= init_hwif_generic,
diff -puN drivers/ide/pci/hpt34x.h~ide_pci_ids drivers/ide/pci/hpt34x.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/hpt34x.h~ide_pci_ids	2004-06-01 21:04:37.475396184 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/hpt34x.h	2004-06-01 21:04:37.648369888 +0200
@@ -18,8 +18,6 @@ static void init_hwif_hpt34x(ide_hwif_t 
 
 static ide_pci_device_t hpt34x_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_TTI,
-		.device		= PCI_DEVICE_ID_TTI_HPT343,
 		.name		= "HPT34X",
 		.init_chipset	= init_chipset_hpt34x,
 		.init_hwif	= init_hwif_hpt34x,
diff -puN drivers/ide/pci/hpt366.c~ide_pci_ids drivers/ide/pci/hpt366.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/hpt366.c~ide_pci_ids	2004-06-01 21:04:37.480395424 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/hpt366.c	2004-06-01 21:04:37.649369736 +0200
@@ -1241,8 +1241,6 @@ static int __devinit hpt366_init_one(str
 {
 	ide_pci_device_t *d = &hpt366_chipsets[id->driver_data];
 
-	if (dev->device != d->device)
-		BUG();
 	d->init_setup(dev, d);
 	return 0;
 }
diff -puN drivers/ide/pci/hpt366.h~ide_pci_ids drivers/ide/pci/hpt366.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/hpt366.h~ide_pci_ids	2004-06-01 21:04:37.485394664 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/hpt366.h	2004-06-01 21:04:37.651369432 +0200
@@ -425,8 +425,6 @@ static void init_dma_hpt366(ide_hwif_t *
 
 static ide_pci_device_t hpt366_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_TTI,
-		.device		= PCI_DEVICE_ID_TTI_HPT366,
 		.name		= "HPT366",
 		.init_setup	= init_setup_hpt366,
 		.init_chipset	= init_chipset_hpt366,
@@ -437,8 +435,6 @@ static ide_pci_device_t hpt366_chipsets[
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	},{	/* 1 */
-		.vendor		= PCI_VENDOR_ID_TTI,
-		.device		= PCI_DEVICE_ID_TTI_HPT372,
 		.name		= "HPT372A",
 		.init_setup	= init_setup_hpt37x,
 		.init_chipset	= init_chipset_hpt366,
@@ -448,8 +444,6 @@ static ide_pci_device_t hpt366_chipsets[
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 	},{	/* 2 */
-		.vendor		= PCI_VENDOR_ID_TTI,
-		.device		= PCI_DEVICE_ID_TTI_HPT302,
 		.name		= "HPT302",
 		.init_setup	= init_setup_hpt37x,
 		.init_chipset	= init_chipset_hpt366,
@@ -459,8 +453,6 @@ static ide_pci_device_t hpt366_chipsets[
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 	},{	/* 3 */
-		.vendor		= PCI_VENDOR_ID_TTI,
-		.device		= PCI_DEVICE_ID_TTI_HPT371,
 		.name		= "HPT371",
 		.init_setup	= init_setup_hpt37x,
 		.init_chipset	= init_chipset_hpt366,
@@ -470,8 +462,6 @@ static ide_pci_device_t hpt366_chipsets[
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 	},{	/* 4 */
-		.vendor		= PCI_VENDOR_ID_TTI,
-		.device		= PCI_DEVICE_ID_TTI_HPT374,
 		.name		= "HPT374",
 		.init_setup	= init_setup_hpt374,
 		.init_chipset	= init_chipset_hpt366,
diff -puN drivers/ide/pci/it8172.c~ide_pci_ids drivers/ide/pci/it8172.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/it8172.c~ide_pci_ids	2004-06-01 21:04:37.489394056 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/it8172.c	2004-06-01 21:04:37.651369432 +0200
@@ -288,11 +288,10 @@ static void __init init_hwif_it8172 (ide
 
 static int __devinit it8172_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &it8172_chipsets[id->driver_data];
         if ((!(PCI_FUNC(dev->devfn) & 1) ||
             (!((dev->class >> 8) == PCI_CLASS_STORAGE_IDE))))
                 return 1; /* IT8172 is more than only a IDE controller */
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &it8172_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/it8172.h~ide_pci_ids drivers/ide/pci/it8172.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/it8172.h~ide_pci_ids	2004-06-01 21:04:37.493393448 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/it8172.h	2004-06-01 21:04:37.652369280 +0200
@@ -20,8 +20,6 @@ static void init_hwif_it8172(ide_hwif_t 
 
 static ide_pci_device_t it8172_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_ITE,
-		.device		= PCI_DEVICE_ID_ITE_IT8172G,
 		.name		= "IT8172G",
 		.init_setup	= init_setup_it8172,
 		.init_chipset	= init_chipset_it8172,
diff -puN drivers/ide/pci/ns87415.c~ide_pci_ids drivers/ide/pci/ns87415.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/ns87415.c~ide_pci_ids	2004-06-01 21:04:37.497392840 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/ns87415.c	2004-06-01 21:04:37.653369128 +0200
@@ -219,10 +219,7 @@ static void __init init_hwif_ns87415 (id
 
 static int __devinit ns87415_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &ns87415_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &ns87415_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/ns87415.h~ide_pci_ids drivers/ide/pci/ns87415.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/ns87415.h~ide_pci_ids	2004-06-01 21:04:37.501392232 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/ns87415.h	2004-06-01 21:04:37.654368976 +0200
@@ -9,8 +9,6 @@ static void init_hwif_ns87415(ide_hwif_t
 
 static ide_pci_device_t ns87415_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_NS,
-		.device		= PCI_DEVICE_ID_NS_87415,
 		.name		= "NS87415",
 		.init_hwif	= init_hwif_ns87415,
 		.channels	= 2,
diff -puN drivers/ide/pci/opti621.c~ide_pci_ids drivers/ide/pci/opti621.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/opti621.c~ide_pci_ids	2004-06-01 21:04:37.504391776 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/opti621.c	2004-06-01 21:04:37.655368824 +0200
@@ -355,10 +355,7 @@ static void __init init_setup_opti621 (s
 
 static int __devinit opti621_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &opti621_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &opti621_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/opti621.h~ide_pci_ids drivers/ide/pci/opti621.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/opti621.h~ide_pci_ids	2004-06-01 21:04:37.508391168 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/opti621.h	2004-06-01 21:04:37.656368672 +0200
@@ -10,8 +10,6 @@ static void init_hwif_opti621(ide_hwif_t
 
 static ide_pci_device_t opti621_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_OPTI,
-		.device		= PCI_DEVICE_ID_OPTI_82C621,
 		.name		= "OPTI621",
 		.init_setup	= init_setup_opti621,
 		.init_hwif	= init_hwif_opti621,
@@ -20,8 +18,6 @@ static ide_pci_device_t opti621_chipsets
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
-		.vendor		= PCI_VENDOR_ID_OPTI,
-		.device		= PCI_DEVICE_ID_OPTI_82C825,
 		.name		= "OPTI621X",
 		.init_setup	= init_setup_opti621,
 		.init_hwif	= init_hwif_opti621,
diff -puN drivers/ide/pci/pdc202xx_new.c~ide_pci_ids drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/pdc202xx_new.c~ide_pci_ids	2004-06-01 21:04:37.512390560 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/pdc202xx_new.c	2004-06-01 21:04:37.657368520 +0200
@@ -514,8 +514,6 @@ static int __devinit pdc202new_init_one(
 {
 	ide_pci_device_t *d = &pdcnew_chipsets[id->driver_data];
 
-	if (dev->device != d->device)
-		BUG();
 	d->init_setup(dev, d);
 	return 0;
 }
diff -puN drivers/ide/pci/pdc202xx_new.h~ide_pci_ids drivers/ide/pci/pdc202xx_new.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/pdc202xx_new.h~ide_pci_ids	2004-06-01 21:04:37.516389952 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/pdc202xx_new.h	2004-06-01 21:04:37.658368368 +0200
@@ -53,8 +53,6 @@ static void init_hwif_pdc202new(ide_hwif
 
 static ide_pci_device_t pdcnew_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20268,
 		.name		= "PDC20268",
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
@@ -63,8 +61,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 	},{	/* 1 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20269,
 		.name		= "PDC20269",
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
@@ -73,8 +69,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 	},{	/* 2 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20270,
 		.name		= "PDC20270",
 		.init_setup	= init_setup_pdc20270,
 		.init_chipset	= init_chipset_pdcnew,
@@ -86,8 +80,6 @@ static ide_pci_device_t pdcnew_chipsets[
 #endif
 		.bootable	= OFF_BOARD,
 	},{	/* 3 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20271,
 		.name		= "PDC20271",
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
@@ -96,8 +88,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 	},{	/* 4 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20275,
 		.name		= "PDC20275",
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
@@ -106,8 +96,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 	},{	/* 5 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20276,
 		.name		= "PDC20276",
 		.init_setup	= init_setup_pdc20276,
 		.init_chipset	= init_chipset_pdcnew,
@@ -119,8 +107,6 @@ static ide_pci_device_t pdcnew_chipsets[
 #endif
 		.bootable	= OFF_BOARD,
 	},{	/* 6 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20277,
 		.name		= "PDC20277",
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
diff -puN drivers/ide/pci/pdc202xx_old.c~ide_pci_ids drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/pdc202xx_old.c~ide_pci_ids	2004-06-01 21:04:37.521389192 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/pdc202xx_old.c	2004-06-01 21:04:37.659368216 +0200
@@ -884,8 +884,6 @@ static int __devinit pdc202xx_init_one(s
 {
 	ide_pci_device_t *d = &pdc202xx_chipsets[id->driver_data];
 
-	if (dev->device != d->device)
-		BUG();
 	d->init_setup(dev, d);
 	return 0;
 }
diff -puN drivers/ide/pci/pdc202xx_old.h~ide_pci_ids drivers/ide/pci/pdc202xx_old.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/pdc202xx_old.h~ide_pci_ids	2004-06-01 21:04:37.525388584 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/pdc202xx_old.h	2004-06-01 21:04:37.660368064 +0200
@@ -180,8 +180,6 @@ static void init_dma_pdc202xx(ide_hwif_t
 
 static ide_pci_device_t pdc202xx_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20246,
 		.name		= "PDC20246",
 		.init_setup	= init_setup_pdc202ata4,
 		.init_chipset	= init_chipset_pdc202xx,
@@ -195,8 +193,6 @@ static ide_pci_device_t pdc202xx_chipset
 		.bootable	= OFF_BOARD,
 		.extra		= 16,
 	},{	/* 1 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20262,
 		.name		= "PDC20262",
 		.init_setup	= init_setup_pdc202ata4,
 		.init_chipset	= init_chipset_pdc202xx,
@@ -209,9 +205,8 @@ static ide_pci_device_t pdc202xx_chipset
 #endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
+		.flags		= IDEPCI_FLAG_FORCE_PDC,
 	},{	/* 2 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20263,
 		.name		= "PDC20263",
 		.init_setup	= init_setup_pdc202ata4,
 		.init_chipset	= init_chipset_pdc202xx,
@@ -225,8 +220,6 @@ static ide_pci_device_t pdc202xx_chipset
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 	},{	/* 3 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20265,
 		.name		= "PDC20265",
 		.init_setup	= init_setup_pdc20265,
 		.init_chipset	= init_chipset_pdc202xx,
@@ -239,9 +232,8 @@ static ide_pci_device_t pdc202xx_chipset
 #endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
+		.flags		= IDEPCI_FLAG_FORCE_PDC,
 	},{	/* 4 */
-		.vendor		= PCI_VENDOR_ID_PROMISE,
-		.device		= PCI_DEVICE_ID_PROMISE_20267,
 		.name		= "PDC20267",
 		.init_setup	= init_setup_pdc202xx,
 		.init_chipset	= init_chipset_pdc202xx,
diff -puN drivers/ide/pci/piix.c~ide_pci_ids drivers/ide/pci/piix.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/piix.c~ide_pci_ids	2004-06-01 21:04:37.529387976 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/piix.c	2004-06-01 21:04:37.661367912 +0200
@@ -744,8 +744,6 @@ static int __devinit piix_init_one(struc
 {
 	ide_pci_device_t *d = &piix_pci_info[id->driver_data];
 
-	if (dev->device != d->device)
-		BUG();
 	d->init_setup(dev, d);
 	return 0;
 }
diff -puN drivers/ide/pci/piix.h~ide_pci_ids drivers/ide/pci/piix.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/piix.h~ide_pci_ids	2004-06-01 21:04:37.533387368 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/piix.h	2004-06-01 21:04:37.662367760 +0200
@@ -13,10 +13,8 @@ static void init_setup_piix(struct pci_d
 static unsigned int __devinit init_chipset_piix(struct pci_dev *, const char *);
 static void init_hwif_piix(ide_hwif_t *);
 
-#define DECLARE_PIIX_DEV(pci_id, name_str) \
+#define DECLARE_PIIX_DEV(name_str) \
 	{						\
-		.vendor		= PCI_VENDOR_ID_INTEL,	\
-		.device		= pci_id,		\
 		.name		= name_str,		\
 		.init_setup	= init_setup_piix,	\
 		.init_chipset	= init_chipset_piix,	\
@@ -33,12 +31,10 @@ static void init_hwif_piix(ide_hwif_t *)
  */
  
 static ide_pci_device_t piix_pci_info[] __devinitdata = {
-	/* 0  */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82371FB_0,  "PIIXa"),
-	/* 1  */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82371FB_1,  "PIIXb"),
+	/*  0 */ DECLARE_PIIX_DEV("PIIXa"),
+	/*  1 */ DECLARE_PIIX_DEV("PIIXb"),
 
 	{	/* 2 */
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_82371MX,
 		.name		= "MPIIX",
 		.init_setup	= init_setup_piix,
 		.init_hwif	= init_hwif_piix,
@@ -48,24 +44,24 @@ static ide_pci_device_t piix_pci_info[] 
 		.bootable	= ON_BOARD,
 	},
 
-	/* 3  */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82371SB_1,  "PIIX3"),
-	/* 4  */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82371AB,    "PIIX4"),
-	/* 5  */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801AB_1,  "ICH0"),
-	/* 6  */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82443MX_1,  "PIIX4"),
-	/* 7  */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801AA_1,  "ICH"),
-	/* 8  */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82372FB_1,  "PIIX4"),
-	/* 9  */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82451NX,    "PIIX4"),
-	/* 10 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801BA_9,  "ICH2"),
-	/* 11 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801BA_8,  "ICH2M"),
-	/* 12 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801CA_10, "ICH3M"),
-	/* 13 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801CA_11, "ICH3"),
-	/* 14 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801DB_11, "ICH4"),
-	/* 15 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801EB_11, "ICH5"),
-	/* 16 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801E_11,  "C-ICH"),
-	/* 17 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801DB_10, "ICH4"),
-	/* 18 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_82801EB_1,  "ICH5-SATA"),
-	/* 19 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_ESB_2,      "ICH5"),
-	/* 20 */ DECLARE_PIIX_DEV(PCI_DEVICE_ID_INTEL_ICH6_19,    "ICH6")
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
+	/* 20 */ DECLARE_PIIX_DEV("ICH6")
 };
 
 #endif /* PIIX_H */
diff -puN drivers/ide/pci/rz1000.c~ide_pci_ids drivers/ide/pci/rz1000.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/rz1000.c~ide_pci_ids	2004-06-01 21:04:37.537386760 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/rz1000.c	2004-06-01 21:04:37.663367608 +0200
@@ -56,10 +56,7 @@ static void __init init_hwif_rz1000 (ide
 
 static int __devinit rz1000_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &rz1000_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &rz1000_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/rz1000.h~ide_pci_ids drivers/ide/pci/rz1000.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/rz1000.h~ide_pci_ids	2004-06-01 21:04:37.541386152 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/rz1000.h	2004-06-01 21:04:37.664367456 +0200
@@ -8,17 +8,13 @@
 static void init_hwif_rz1000(ide_hwif_t *);
 
 static ide_pci_device_t rz1000_chipsets[] __devinitdata = {
-{
-		.vendor		= PCI_VENDOR_ID_PCTECH,
-		.device		= PCI_DEVICE_ID_PCTECH_RZ1000,
+	{
 		.name		= "RZ1000",
 		.init_hwif	= init_hwif_rz1000,
 		.channels	= 2,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
 	},{
-		.vendor		= PCI_VENDOR_ID_PCTECH,
-		.device		= PCI_DEVICE_ID_PCTECH_RZ1001,
 		.name		= "RZ1001",
 		.init_hwif	= init_hwif_rz1000,
 		.channels	= 2,
diff -puN drivers/ide/pci/sc1200.c~ide_pci_ids drivers/ide/pci/sc1200.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/sc1200.c~ide_pci_ids	2004-06-01 21:04:37.546385392 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sc1200.c	2004-06-01 21:04:37.665367304 +0200
@@ -547,10 +547,7 @@ static void __init init_hwif_sc1200 (ide
 
 static int __devinit sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &sc1200_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &sc1200_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/sc1200.h~ide_pci_ids drivers/ide/pci/sc1200.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/sc1200.h~ide_pci_ids	2004-06-01 21:04:37.550384784 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sc1200.h	2004-06-01 21:04:37.665367304 +0200
@@ -12,8 +12,6 @@ static void init_hwif_sc1200(ide_hwif_t 
 
 static ide_pci_device_t sc1200_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_NS,
-		.device		= PCI_DEVICE_ID_NS_SCx200_IDE,
 		.name		= "SC1200",
 		.init_chipset	= init_chipset_sc1200,
 		.init_hwif	= init_hwif_sc1200,
diff -puN drivers/ide/pci/serverworks.c~ide_pci_ids drivers/ide/pci/serverworks.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/serverworks.c~ide_pci_ids	2004-06-01 21:04:37.554384176 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/serverworks.c	2004-06-01 21:04:37.666367152 +0200
@@ -777,8 +777,8 @@ static void __init init_setup_csb6 (stru
 		d->autodma = AUTODMA;
 #endif
 
-	d->channels = (((d->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
-			(d->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) &&
+	d->channels = ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE ||
+			dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&
 		       (!(PCI_FUNC(dev->devfn) & 1))) ? 1 : 2;
 
 	ide_setup_pci_device(dev, d);
@@ -798,8 +798,6 @@ static int __devinit svwks_init_one(stru
 {
 	ide_pci_device_t *d = &serverworks_chipsets[id->driver_data];
 
-	if (dev->device != d->device)
-		BUG();
 	d->init_setup(dev, d);
 	return 0;
 }
diff -puN drivers/ide/pci/serverworks.h~ide_pci_ids drivers/ide/pci/serverworks.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/serverworks.h~ide_pci_ids	2004-06-01 21:04:37.559383416 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/serverworks.h	2004-06-01 21:04:37.668366848 +0200
@@ -31,8 +31,6 @@ static void init_dma_svwks(ide_hwif_t *,
 
 static ide_pci_device_t serverworks_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_SERVERWORKS,
-		.device		= PCI_DEVICE_ID_SERVERWORKS_OSB4IDE,
 		.name		= "SvrWks OSB4",
 		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
@@ -41,8 +39,6 @@ static ide_pci_device_t serverworks_chip
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
-		.vendor		= PCI_VENDOR_ID_SERVERWORKS,
-		.device		= PCI_DEVICE_ID_SERVERWORKS_CSB5IDE,
 		.name		= "SvrWks CSB5",
 		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
@@ -52,8 +48,6 @@ static ide_pci_device_t serverworks_chip
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 2 */
-		.vendor		= PCI_VENDOR_ID_SERVERWORKS,
-		.device		= PCI_DEVICE_ID_SERVERWORKS_CSB6IDE,
 		.name		= "SvrWks CSB6",
 		.init_setup	= init_setup_csb6,
 		.init_chipset	= init_chipset_svwks,
@@ -63,8 +57,6 @@ static ide_pci_device_t serverworks_chip
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 3 */
-		.vendor		= PCI_VENDOR_ID_SERVERWORKS,
-		.device		= PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2,
 		.name		= "SvrWks CSB6",
 		.init_setup	= init_setup_csb6,
 		.init_chipset	= init_chipset_svwks,
diff -puN drivers/ide/pci/sgiioc4.c~ide_pci_ids drivers/ide/pci/sgiioc4.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/sgiioc4.c~ide_pci_ids	2004-06-01 21:04:37.563382808 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sgiioc4.c	2004-06-01 21:04:37.669366696 +0200
@@ -757,8 +757,6 @@ pci_init_sgiioc4(struct pci_dev *dev, id
 static ide_pci_device_t sgiioc4_chipsets[] __devinitdata = {
 	{
 	 /* Channel 0 */
-	 .vendor = PCI_VENDOR_ID_SGI,
-	 .device = PCI_DEVICE_ID_SGI_IOC4,
 	 .name = "SGIIOC4",
 	 .init_hwif = ide_init_sgiioc4,
 	 .init_dma = ide_dma_sgiioc4,
@@ -772,16 +770,7 @@ static ide_pci_device_t sgiioc4_chipsets
 static int __devinit
 sgiioc4_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &sgiioc4_chipsets[id->driver_data];
-	if (dev->device != d->device) {
-		printk(KERN_ERR "Error in %s(dev 0x%p | id 0x%p )\n",
-		       __FUNCTION__, (void *) dev, (void *) id);
-		BUG();
-	}
-
-	if (pci_init_sgiioc4(dev, d))
-		return 0;
-
+	pci_init_sgiioc4(dev, &sgiioc4_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/siimage.c~ide_pci_ids drivers/ide/pci/siimage.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/siimage.c~ide_pci_ids	2004-06-01 21:04:37.567382200 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/siimage.c	2004-06-01 21:04:45.077240528 +0200
@@ -1183,10 +1183,7 @@ static void __init init_hwif_siimage (id
  
 static int __devinit siimage_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &siimage_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &siimage_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/siimage.h~ide_pci_ids drivers/ide/pci/siimage.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/siimage.h~ide_pci_ids	2004-06-01 21:04:37.571381592 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/siimage.h	2004-06-01 21:04:37.671366392 +0200
@@ -27,8 +27,6 @@ static void init_hwif_siimage(ide_hwif_t
 
 static ide_pci_device_t siimage_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_CMD,
-		.device		= PCI_DEVICE_ID_SII_680,
 		.name		= "SiI680",
 		.init_chipset	= init_chipset_siimage,
 		.init_iops	= init_iops_siimage,
@@ -37,8 +35,6 @@ static ide_pci_device_t siimage_chipsets
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
-		.vendor		= PCI_VENDOR_ID_CMD,
-		.device		= PCI_DEVICE_ID_SII_3112,
 		.name		= "SiI3112 Serial ATA",
 		.init_chipset	= init_chipset_siimage,
 		.init_iops	= init_iops_siimage,
@@ -47,8 +43,6 @@ static ide_pci_device_t siimage_chipsets
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 2 */
-		.vendor		= PCI_VENDOR_ID_CMD,
-		.device		= PCI_DEVICE_ID_SII_1210SA,
 		.name		= "Adaptec AAR-1210SA",
 		.init_chipset	= init_chipset_siimage,
 		.init_iops	= init_iops_siimage,
diff -puN drivers/ide/pci/sis5513.c~ide_pci_ids drivers/ide/pci/sis5513.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/sis5513.c~ide_pci_ids	2004-06-01 21:04:37.575380984 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sis5513.c	2004-06-01 21:04:37.672366240 +0200
@@ -946,10 +946,7 @@ static void __init init_hwif_sis5513 (id
 
 static int __devinit sis5513_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &sis5513_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &sis5513_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/sis5513.h~ide_pci_ids drivers/ide/pci/sis5513.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/sis5513.h~ide_pci_ids	2004-06-01 21:04:37.579380376 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sis5513.h	2004-06-01 21:04:37.673366088 +0200
@@ -12,8 +12,6 @@ static void init_hwif_sis5513(ide_hwif_t
 
 static ide_pci_device_t sis5513_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_SI,
-		.device		= PCI_DEVICE_ID_SI_5513,
 		.name		= "SIS5513",
 		.init_chipset	= init_chipset_sis5513,
 		.init_hwif	= init_hwif_sis5513,
diff -puN drivers/ide/pci/sl82c105.c~ide_pci_ids drivers/ide/pci/sl82c105.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/sl82c105.c~ide_pci_ids	2004-06-01 21:04:37.584379616 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sl82c105.c	2004-06-01 21:04:37.674365936 +0200
@@ -483,10 +483,7 @@ static void __init init_hwif_sl82c105(id
 
 static int __devinit sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &sl82c105_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &sl82c105_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/sl82c105.h~ide_pci_ids drivers/ide/pci/sl82c105.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/sl82c105.h~ide_pci_ids	2004-06-01 21:04:37.588379008 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/sl82c105.h	2004-06-01 21:04:37.675365784 +0200
@@ -11,8 +11,6 @@ static void init_dma_sl82c105(ide_hwif_t
 
 static ide_pci_device_t sl82c105_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_WINBOND,
-		.device		= PCI_DEVICE_ID_WINBOND_82C105,
 		.name		= "W82C105",
 		.init_chipset	= init_chipset_sl82c105,
 		.init_hwif	= init_hwif_sl82c105,
diff -puN drivers/ide/pci/slc90e66.c~ide_pci_ids drivers/ide/pci/slc90e66.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/slc90e66.c~ide_pci_ids	2004-06-01 21:04:37.592378400 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/slc90e66.c	2004-06-01 21:04:37.675365784 +0200
@@ -366,10 +366,7 @@ static void __init init_hwif_slc90e66 (i
 
 static int __devinit slc90e66_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &slc90e66_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &slc90e66_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/slc90e66.h~ide_pci_ids drivers/ide/pci/slc90e66.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/slc90e66.h~ide_pci_ids	2004-06-01 21:04:37.596377792 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/slc90e66.h	2004-06-01 21:04:37.676365632 +0200
@@ -14,8 +14,6 @@ static void init_hwif_slc90e66(ide_hwif_
 
 static ide_pci_device_t slc90e66_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_EFAR,
-		.device		= PCI_DEVICE_ID_EFAR_SLC90E66_1,
 		.name		= "SLC90E66",
 		.init_chipset	= init_chipset_slc90e66,
 		.init_hwif	= init_hwif_slc90e66,
diff -puN drivers/ide/pci/triflex.c~ide_pci_ids drivers/ide/pci/triflex.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/triflex.c~ide_pci_ids	2004-06-01 21:04:37.601377032 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/triflex.c	2004-06-01 21:04:37.678365328 +0200
@@ -220,13 +220,9 @@ static unsigned int __init init_chipset_
 static int __devinit triflex_init_one(struct pci_dev *dev, 
 		const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &triflex_devices[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &triflex_devices[id->driver_data]);
 	triflex_dev = dev;
-	
+
 	return 0;
 }
 
diff -puN drivers/ide/pci/triflex.h~ide_pci_ids drivers/ide/pci/triflex.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/triflex.h~ide_pci_ids	2004-06-01 21:04:37.604376576 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/triflex.h	2004-06-01 21:04:37.678365328 +0200
@@ -17,8 +17,6 @@ static void init_hwif_triflex(ide_hwif_t
 
 static ide_pci_device_t triflex_devices[] __devinitdata = {
 	{
-		.vendor 	= PCI_VENDOR_ID_COMPAQ,
-		.device		= PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE,
 		.name		= "TRIFLEX",
 		.init_chipset	= init_chipset_triflex,
 		.init_hwif	= init_hwif_triflex,
diff -puN drivers/ide/pci/trm290.c~ide_pci_ids drivers/ide/pci/trm290.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/trm290.c~ide_pci_ids	2004-06-01 21:04:37.609375816 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/trm290.c	2004-06-01 21:04:37.679365176 +0200
@@ -397,10 +397,7 @@ void __init init_hwif_trm290 (ide_hwif_t
 
 static int __devinit trm290_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &trm290_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &trm290_chipsets[id->driver_data]);
 	return 0;
 }
 
diff -puN drivers/ide/pci/trm290.h~ide_pci_ids drivers/ide/pci/trm290.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/trm290.h~ide_pci_ids	2004-06-01 21:04:37.613375208 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/trm290.h	2004-06-01 21:04:37.680365024 +0200
@@ -9,8 +9,6 @@ extern void init_hwif_trm290(ide_hwif_t 
 
 static ide_pci_device_t trm290_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_TEKRAM,
-		.device		= PCI_DEVICE_ID_TEKRAM_DC290,
 		.name		= "TRM290",
 		.init_hwif	= init_hwif_trm290,
 		.channels	= 2,
diff -puN drivers/ide/pci/via82cxxx.c~ide_pci_ids drivers/ide/pci/via82cxxx.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/via82cxxx.c~ide_pci_ids	2004-06-01 21:04:37.616374752 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/via82cxxx.c	2004-06-01 21:04:43.820431592 +0200
@@ -609,16 +609,13 @@ static void __init init_hwif_via82cxxx(i
 
 static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &via82cxxx_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
+	ide_setup_pci_device(dev, &via82cxxx_chipsets[id->driver_data]);
 	return 0;
 }
 
 static struct pci_device_id via_pci_tbl[] = {
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, via_pci_tbl);
diff -puN drivers/ide/pci/via82cxxx.h~ide_pci_ids drivers/ide/pci/via82cxxx.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/via82cxxx.h~ide_pci_ids	2004-06-01 21:04:37.621373992 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/via82cxxx.h	2004-06-01 21:04:43.821431440 +0200
@@ -12,18 +12,6 @@ static void init_hwif_via82cxxx(ide_hwif
 
 static ide_pci_device_t via82cxxx_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device		= PCI_DEVICE_ID_VIA_82C576_1,
-		.name		= "VP_IDE",
-		.init_chipset	= init_chipset_via82cxxx,
-		.init_hwif	= init_hwif_via82cxxx,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device		= PCI_DEVICE_ID_VIA_82C586_1,
 		.name		= "VP_IDE",
 		.init_chipset	= init_chipset_via82cxxx,
 		.init_hwif	= init_hwif_via82cxxx,
diff -puN drivers/ide/setup-pci.c~ide_pci_ids drivers/ide/setup-pci.c
--- linux-2.6.7-rc2-bk2/drivers/ide/setup-pci.c~ide_pci_ids	2004-06-01 21:04:37.624373536 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/setup-pci.c	2004-06-01 21:04:37.683364568 +0200
@@ -285,14 +285,8 @@ second_chance_to_dma:
 
 void ide_setup_pci_noise (struct pci_dev *dev, ide_pci_device_t *d)
 {
-	if ((d->vendor != dev->vendor) && (d->device != dev->device)) {
-		printk(KERN_INFO "%s: unknown IDE controller at PCI slot "
-			"%s, VID=%04x, DID=%04x\n",
-			d->name, pci_name(dev), dev->vendor, dev->device);
-        } else {
-		printk(KERN_INFO "%s: IDE controller at PCI slot %s\n",
-			d->name, pci_name(dev));
-	}
+	printk(KERN_INFO "%s: IDE controller at PCI slot %s\n",
+			 d->name, pci_name(dev));
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_pci_noise);
@@ -422,8 +416,7 @@ static ide_hwif_t *ide_hwif_configure(st
 	unsigned long ctl = 0, base = 0;
 	ide_hwif_t *hwif;
 
-	if(!d->isa_ports)
-	{
+	if ((d->flags & IDEPCI_FLAG_ISA_PORTS) == 0) {
 		/*  Possibly we should fail if these checks report true */
 		ide_pci_check_iomem(dev, d, 2*port);
 		ide_pci_check_iomem(dev, d, 2*port+1);
@@ -495,9 +488,7 @@ static void ide_hwif_setup_dma(struct pc
  			 * Set up BM-DMA capability
 			 * (PnP BIOS should have done this)
  			 */
-			if (!((d->device == PCI_DEVICE_ID_CYRIX_5530_IDE && d->vendor == PCI_VENDOR_ID_CYRIX)
-			    ||(d->device == PCI_DEVICE_ID_NS_SCx200_IDE && d->vendor == PCI_VENDOR_ID_NS)))
-			{
+			if ((d->flags & IDEPCI_FLAG_FORCE_MASTER) == 0) {
 				/*
 				 * default DMA off if we had to
 				 * configure it here
@@ -613,9 +604,7 @@ void ide_pci_setup_ports(struct pci_dev 
 		 * by the bios for raid purposes. 
 		 * Skip the normal "is it enabled" test for those.
 		 */
-		if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
-		     ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
-		      (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
+		if ((d->flags & IDEPCI_FLAG_FORCE_PDC) &&
 		    (secondpdc++==1) && (port==1))
 			goto controller_ok;
 			
diff -puN include/linux/ide.h~ide_pci_ids include/linux/ide.h
--- linux-2.6.7-rc2-bk2/include/linux/ide.h~ide_pci_ids	2004-06-01 21:04:37.628372928 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/linux/ide.h	2004-06-01 21:04:37.685364264 +0200
@@ -1552,9 +1552,15 @@ typedef struct ide_pci_enablebit_s {
 	u8	val;	/* value of masked reg when "enabled" */
 } ide_pci_enablebit_t;
 
+enum {
+	/* Uses ISA control ports not PCI ones. */
+	IDEPCI_FLAG_ISA_PORTS		= (1 << 0),
+
+	IDEPCI_FLAG_FORCE_MASTER	= (1 << 1),
+	IDEPCI_FLAG_FORCE_PDC		= (1 << 2),
+};
+
 typedef struct ide_pci_device_s {
-	u16			vendor;
-	u16			device;
 	char			*name;
 	void			(*init_setup)(struct pci_dev *, struct ide_pci_device_s *);
 	void			(*init_setup_dma)(struct pci_dev *, struct ide_pci_device_s *, ide_hwif_t *);
@@ -1568,7 +1574,7 @@ typedef struct ide_pci_device_s {
 	u8			bootable;
 	unsigned int		extra;
 	struct ide_pci_device_s	*next;
-	u8			isa_ports; 	/* Uses ISA control ports not PCI ones */
+	u8			flags;
 } ide_pci_device_t;
 
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);

_

