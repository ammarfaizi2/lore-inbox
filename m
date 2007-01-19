Return-Path: <linux-kernel-owner+w=401wt.eu-S932786AbXASA1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932786AbXASA1f (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbXASA1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:27:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932786AbXASA10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:27:26 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=PyrEJQBkhB1+NcM1K3Gmd00HuN0Efie/YXF4vyAMjqVLZNCovgegHnc3lAVasrvG7AwtgVPLwvsSLhfD92q3iKvHMnFMgcn9/9e2s5zmNgmPQVCz+8+OdtdX3gbXCrW6twYyehUqtS2xaSyhFWmK/JCImzL9CHjXv/7C6dutQDk=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:31:24 +0100
Message-Id: <20070119003124.14846.24392.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 4/15] ide: convert ide_hwif_t.mmio into flag
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: convert ide_hwif_t.mmio into flag

All users of ->mmio == 1 are gone so convert ->mmio into flag.

Noticed by Alan Cox.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/arm/icside.c      |    2 +-
 drivers/ide/arm/rapide.c      |    2 +-
 drivers/ide/cris/ide-cris.c   |    2 +-
 drivers/ide/h8300/ide-h8300.c |    2 +-
 drivers/ide/ide-dma.c         |    8 ++++----
 drivers/ide/ide.c             |    5 ++---
 drivers/ide/legacy/buddha.c   |    2 +-
 drivers/ide/legacy/gayle.c    |    2 +-
 drivers/ide/legacy/macide.c   |    2 +-
 drivers/ide/legacy/q40ide.c   |    2 +-
 drivers/ide/mips/au1xxx-ide.c |    3 ++-
 drivers/ide/mips/swarm.c      |    2 +-
 drivers/ide/pci/sgiioc4.c     |    2 +-
 drivers/ide/pci/siimage.c     |    3 ++-
 drivers/ide/ppc/pmac.c        |    2 +-
 include/linux/ide.h           |    2 +-
 16 files changed, 22 insertions(+), 21 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -556,7 +556,7 @@ icside_setup(void __iomem *base, struct 
 		 * Ensure we're using MMIO
 		 */
 		default_hwif_mmiops(hwif);
-		hwif->mmio = 2;
+		hwif->mmio = 1;
 
 		for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
 			hwif->hw.io_ports[i] = port;
Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -46,7 +46,7 @@ rapide_locate_hwif(void __iomem *base, v
 	hwif->hw.io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl;
 	hwif->io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl;
 	hwif->hw.irq = hwif->irq = irq;
-	hwif->mmio = 2;
+	hwif->mmio = 1;
 	default_hwif_mmiops(hwif);
 
 	return hwif;
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -795,7 +795,7 @@ init_e100_ide (void)
 		                0, 0, cris_ide_ack_intr,
 		                ide_default_irq(0));
 		ide_register_hw(&hw, &hwif);
-		hwif->mmio = 2;
+		hwif->mmio = 1;
 		hwif->chipset = ide_etrax100;
 		hwif->tuneproc = &tune_cris_ide;
 		hwif->speedproc = &speed_cris_ide;
Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -76,7 +76,7 @@ static inline void hwif_setup(ide_hwif_t
 {
 	default_hwif_iops(hwif);
 
-	hwif->mmio  = 2;
+	hwif->mmio  = 1;
 	hwif->OUTW  = mm_outw;
 	hwif->OUTSW = mm_outsw;
 	hwif->INW   = mm_inw;
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -565,7 +565,7 @@ int ide_dma_setup(ide_drive_t *drive)
 	}
 
 	/* PRD table */
-	if (hwif->mmio == 2)
+	if (hwif->mmio)
 		writel(hwif->dmatable_dma, (void __iomem *)hwif->dma_prdtable);
 	else
 		outl(hwif->dmatable_dma, hwif->dma_prdtable);
@@ -815,7 +815,7 @@ int ide_release_dma(ide_hwif_t *hwif)
 {
 	ide_release_dma_engine(hwif);
 
-	if (hwif->mmio == 2)
+	if (hwif->mmio)
 		return 1;
 	else
 		return ide_release_iomio_dma(hwif);
@@ -884,9 +884,9 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 
 static int ide_dma_iobase(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
-	if (hwif->mmio == 2)
+	if (hwif->mmio)
 		return ide_mapped_mmio_dma(hwif, base,ports);
-	BUG_ON(hwif->mmio == 1);
+
 	return ide_iomio_dma(hwif, base, ports);
 }
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -389,9 +389,8 @@ int ide_hwif_request_regions(ide_hwif_t 
 	unsigned long addr;
 	unsigned int i;
 
-	if (hwif->mmio == 2)
+	if (hwif->mmio)
 		return 0;
-	BUG_ON(hwif->mmio == 1);
 	addr = hwif->io_ports[IDE_CONTROL_OFFSET];
 	if (addr && !hwif_request_region(hwif, addr, 1))
 		goto control_region_busy;
@@ -438,7 +437,7 @@ void ide_hwif_release_regions(ide_hwif_t
 {
 	u32 i = 0;
 
-	if (hwif->mmio == 2)
+	if (hwif->mmio)
 		return;
 	if (hwif->io_ports[IDE_CONTROL_OFFSET])
 		release_region(hwif->io_ports[IDE_CONTROL_OFFSET], 1);
Index: b/drivers/ide/legacy/buddha.c
===================================================================
--- a/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -215,7 +215,7 @@ fail_base2:
 			
 			index = ide_register_hw(&hw, &hwif);
 			if (index != -1) {
-				hwif->mmio = 2;
+				hwif->mmio = 1;
 				printk("ide%d: ", index);
 				switch(type) {
 				case BOARD_BUDDHA:
Index: b/drivers/ide/legacy/gayle.c
===================================================================
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -167,7 +167,7 @@ found:
 
 	index = ide_register_hw(&hw, &hwif);
 	if (index != -1) {
-	    hwif->mmio = 2;
+	    hwif->mmio = 1;
 	    switch (i) {
 		case 0:
 		    printk("ide%d: Gayle IDE interface (A%d style)\n", index,
Index: b/drivers/ide/legacy/macide.c
===================================================================
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -141,7 +141,7 @@ void macide_init(void)
 	}
 
         if (index != -1) {
-		hwif->mmio = 2;
+		hwif->mmio = 1;
 		if (macintosh_config->ide_type == MAC_IDE_QUADRA)
 			printk(KERN_INFO "ide%d: Macintosh Quadra IDE interface\n", index);
 		else if (macintosh_config->ide_type == MAC_IDE_PB)
Index: b/drivers/ide/legacy/q40ide.c
===================================================================
--- a/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -145,7 +145,7 @@ void q40ide_init(void)
 	index = ide_register_hw(&hw, &hwif);
 	// **FIXME**
 	if (index != -1)
-		hwif->mmio = 2;
+		hwif->mmio = 1;
     }
 }
 
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -708,7 +708,8 @@ static int au_ide_probe(struct device *d
 
 	/* hold should be on in all cases */
 	hwif->hold                      = 1;
-	hwif->mmio                      = 2;
+
+	hwif->mmio  = 1;
 
 	/* If the user has selected DDMA assisted copies,
 	   then set up a few local I/O function entry points 
Index: b/drivers/ide/mips/swarm.c
===================================================================
--- a/drivers/ide/mips/swarm.c
+++ b/drivers/ide/mips/swarm.c
@@ -115,7 +115,7 @@ static int __devinit swarm_ide_probe(str
 	/* Setup MMIO ops.  */
 	default_hwif_mmiops(hwif);
 	/* Prevent resource map manipulation.  */
-	hwif->mmio = 2;
+	hwif->mmio = 1;
 	hwif->noprobe = 0;
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -593,7 +593,7 @@ static int sgiioc4_ide_dma_setup(ide_dri
 static void __devinit
 ide_init_sgiioc4(ide_hwif_t * hwif)
 {
-	hwif->mmio = 2;
+	hwif->mmio = 1;
 	hwif->autodma = 1;
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x0;	/* Disable Ultra DMA */
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -889,7 +889,8 @@ static void __devinit init_mmio_iops_sii
        	base = (unsigned long) addr;
 
 	hwif->dma_base			= base + (ch ? 0x08 : 0x00);
-	hwif->mmio			= 2;
+
+	hwif->mmio = 1;
 }
 
 static int is_dev_seagate_sata(ide_drive_t *drive)
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1238,7 +1238,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
        	hwif->OUTBSYNC = pmac_outbsync;
 
 	/* Tell common code _not_ to mess with resources */
-	hwif->mmio = 2;
+	hwif->mmio = 1;
 	hwif->hwif_data = pmif;
 	pmac_ide_init_hwif_ports(&hwif->hw, pmif->regbase, 0, &hwif->irq);
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -771,7 +771,6 @@ typedef struct hwif_s {
 	unsigned int cursg;
 	unsigned int cursg_ofs;
 
-	int		mmio;		/* hosts iomio (0) or custom (2) select */
 	int		rqsize;		/* max sectors per request */
 	int		irq;		/* our irq number */
 
@@ -804,6 +803,7 @@ typedef struct hwif_s {
 	unsigned	no_io_32bit : 1; /* 1 = can not do 32-bit IO ops */
 	unsigned	err_stops_fifo : 1; /* 1=data FIFO is cleared by an error */
 	unsigned	atapi_irq_bogon : 1; /* Generates spurious DMA interrupts in PIO mode */
+	unsigned	mmio       : 1; /* host uses MMIO */
 
 	struct device	gendev;
 	struct completion gendev_rel_comp; /* To deal with device release() */
