Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVBBDCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVBBDCf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVBBDCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:02:35 -0500
Received: from [211.58.254.17] ([211.58.254.17]:39817 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262223AbVBBCrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:47:15 -0500
Date: Wed, 2 Feb 2005 11:47:12 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 05/29] ide: merge pci driver .h's into .c's
Message-ID: <20050202024712.GF621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 05_ide_merge_pci_driver_hc.patch
> 
> 	Merges drivers/ide/pci/*.h files into their corresponding *.c
> 	files.  Rationales are
> 	1. There's no reason to separate pci drivers into header and
> 	   body.  No header file is shared and they're simple enough.
> 	2. struct pde_pci_device_t *_chipsets[] are _defined_ in the
> 	   header files.  That isn't the custom and there's no good
> 	   reason to do differently in these drivers.
> 	3. Tracking changelogs shows that the bugs fixed by 00 and 01
> 	   are introduced during mass-updating ide pci drivers by
> 	   forgetting to update *.h files.


Signed-off-by: Tejun Heo <tj@home-tj.org>                                       

Index: linux-ide-export/drivers/ide/pci/aec62xx.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/aec62xx.c	2005-02-02 10:27:16.177155461 +0900
+++ linux-ide-export/drivers/ide/pci/aec62xx.c	2005-02-02 10:28:02.661613731 +0900
@@ -16,7 +16,61 @@
 
 #include <asm/io.h>
 
-#include "aec62xx.h"
+struct chipset_bus_clock_list_entry {
+	byte		xfer_speed;
+	byte		chipset_settings;
+	byte		ultra_settings;
+};
+
+static struct chipset_bus_clock_list_entry aec6xxx_33_base [] = {
+	{	XFER_UDMA_6,	0x31,	0x07	},
+	{	XFER_UDMA_5,	0x31,	0x06	},
+	{	XFER_UDMA_4,	0x31,	0x05	},
+	{	XFER_UDMA_3,	0x31,	0x04	},
+	{	XFER_UDMA_2,	0x31,	0x03	},
+	{	XFER_UDMA_1,	0x31,	0x02	},
+	{	XFER_UDMA_0,	0x31,	0x01	},
+
+	{	XFER_MW_DMA_2,	0x31,	0x00	},
+	{	XFER_MW_DMA_1,	0x31,	0x00	},
+	{	XFER_MW_DMA_0,	0x0a,	0x00	},
+	{	XFER_PIO_4,	0x31,	0x00	},
+	{	XFER_PIO_3,	0x33,	0x00	},
+	{	XFER_PIO_2,	0x08,	0x00	},
+	{	XFER_PIO_1,	0x0a,	0x00	},
+	{	XFER_PIO_0,	0x00,	0x00	},
+	{	0,		0x00,	0x00	}
+};
+
+static struct chipset_bus_clock_list_entry aec6xxx_34_base [] = {
+	{	XFER_UDMA_6,	0x41,	0x06	},
+	{	XFER_UDMA_5,	0x41,	0x05	},
+	{	XFER_UDMA_4,	0x41,	0x04	},
+	{	XFER_UDMA_3,	0x41,	0x03	},
+	{	XFER_UDMA_2,	0x41,	0x02	},
+	{	XFER_UDMA_1,	0x41,	0x01	},
+	{	XFER_UDMA_0,	0x41,	0x01	},
+
+	{	XFER_MW_DMA_2,	0x41,	0x00	},
+	{	XFER_MW_DMA_1,	0x42,	0x00	},
+	{	XFER_MW_DMA_0,	0x7a,	0x00	},
+	{	XFER_PIO_4,	0x41,	0x00	},
+	{	XFER_PIO_3,	0x43,	0x00	},
+	{	XFER_PIO_2,	0x78,	0x00	},
+	{	XFER_PIO_1,	0x7a,	0x00	},
+	{	XFER_PIO_0,	0x70,	0x00	},
+	{	0,		0x00,	0x00	}
+};
+
+#ifndef SPLIT_BYTE
+#define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
+#endif
+#ifndef MAKE_WORD
+#define MAKE_WORD(W,HB,LB)	((W)=((HB<<8)+LB))
+#endif
+
+#define BUSCLOCK(D)	\
+	((struct chipset_bus_clock_list_entry *) pci_get_drvdata((D)))
 
 #if 0
 		if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
@@ -343,6 +397,58 @@ static int __devinit init_setup_aec6x80(
 	return ide_setup_pci_device(dev, d);
 }
 
+static ide_pci_device_t aec62xx_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "AEC6210",
+		.init_setup	= init_setup_aec62xx,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
+		.bootable	= OFF_BOARD,
+	},{	/* 1 */
+		.name		= "AEC6260",
+		.init_setup	= init_setup_aec62xx,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 2 */
+		.name		= "AEC6260R",
+		.init_setup	= init_setup_aec62xx,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
+		.bootable	= NEVER_BOARD,
+	},{	/* 3 */
+		.name		= "AEC6X80",
+		.init_setup	= init_setup_aec6x80,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 4 */
+		.name		= "AEC6X80R",
+		.init_setup	= init_setup_aec6x80,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
+		.bootable	= OFF_BOARD,
+	}
+};
+
 /**
  *	aec62xx_init_one	-	called when a AEC is found
  *	@dev: the aec62xx device
Index: linux-ide-export/drivers/ide/pci/aec62xx.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/aec62xx.h	2005-02-02 10:27:16.177155461 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,122 +0,0 @@
-#ifndef AEC62XX_H
-#define AEC62XX_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-struct chipset_bus_clock_list_entry {
-	byte		xfer_speed;
-	byte		chipset_settings;
-	byte		ultra_settings;
-};
-
-static struct chipset_bus_clock_list_entry aec6xxx_33_base [] = {
-	{	XFER_UDMA_6,	0x31,	0x07	},
-	{	XFER_UDMA_5,	0x31,	0x06	},
-	{	XFER_UDMA_4,	0x31,	0x05	},
-	{	XFER_UDMA_3,	0x31,	0x04	},
-	{	XFER_UDMA_2,	0x31,	0x03	},
-	{	XFER_UDMA_1,	0x31,	0x02	},
-	{	XFER_UDMA_0,	0x31,	0x01	},
-
-	{	XFER_MW_DMA_2,	0x31,	0x00	},
-	{	XFER_MW_DMA_1,	0x31,	0x00	},
-	{	XFER_MW_DMA_0,	0x0a,	0x00	},
-	{	XFER_PIO_4,	0x31,	0x00	},
-	{	XFER_PIO_3,	0x33,	0x00	},
-	{	XFER_PIO_2,	0x08,	0x00	},
-	{	XFER_PIO_1,	0x0a,	0x00	},
-	{	XFER_PIO_0,	0x00,	0x00	},
-	{	0,		0x00,	0x00	}
-};
-
-static struct chipset_bus_clock_list_entry aec6xxx_34_base [] = {
-	{	XFER_UDMA_6,	0x41,	0x06	},
-	{	XFER_UDMA_5,	0x41,	0x05	},
-	{	XFER_UDMA_4,	0x41,	0x04	},
-	{	XFER_UDMA_3,	0x41,	0x03	},
-	{	XFER_UDMA_2,	0x41,	0x02	},
-	{	XFER_UDMA_1,	0x41,	0x01	},
-	{	XFER_UDMA_0,	0x41,	0x01	},
-
-	{	XFER_MW_DMA_2,	0x41,	0x00	},
-	{	XFER_MW_DMA_1,	0x42,	0x00	},
-	{	XFER_MW_DMA_0,	0x7a,	0x00	},
-	{	XFER_PIO_4,	0x41,	0x00	},
-	{	XFER_PIO_3,	0x43,	0x00	},
-	{	XFER_PIO_2,	0x78,	0x00	},
-	{	XFER_PIO_1,	0x7a,	0x00	},
-	{	XFER_PIO_0,	0x70,	0x00	},
-	{	0,		0x00,	0x00	}
-};
-
-#ifndef SPLIT_BYTE
-#define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
-#endif
-#ifndef MAKE_WORD
-#define MAKE_WORD(W,HB,LB)	((W)=((HB<<8)+LB))
-#endif
-
-#define BUSCLOCK(D)	\
-	((struct chipset_bus_clock_list_entry *) pci_get_drvdata((D)))
-
-static int init_setup_aec6x80(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_aec62xx(struct pci_dev *, ide_pci_device_t *);
-static unsigned int init_chipset_aec62xx(struct pci_dev *, const char *);
-static void init_hwif_aec62xx(ide_hwif_t *);
-static void init_dma_aec62xx(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t aec62xx_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "AEC6210",
-		.init_setup	= init_setup_aec62xx,
-		.init_chipset	= init_chipset_aec62xx,
-		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.bootable	= OFF_BOARD,
-	},{	/* 1 */
-		.name		= "AEC6260",
-		.init_setup	= init_setup_aec62xx,
-		.init_chipset	= init_chipset_aec62xx,
-		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 2 */
-		.name		= "AEC6260R",
-		.init_setup	= init_setup_aec62xx,
-		.init_chipset	= init_chipset_aec62xx,
-		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.bootable	= NEVER_BOARD,
-	},{	/* 3 */
-		.name		= "AEC6X80",
-		.init_setup	= init_setup_aec6x80,
-		.init_chipset	= init_chipset_aec62xx,
-		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 4 */
-		.name		= "AEC6X80R",
-		.init_setup	= init_setup_aec6x80,
-		.init_chipset	= init_chipset_aec62xx,
-		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.bootable	= OFF_BOARD,
-	}
-};
-
-#endif /* AEC62XX_H */
Index: linux-ide-export/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/cmd64x.c	2005-02-02 10:27:16.178155299 +0900
+++ linux-ide-export/drivers/ide/pci/cmd64x.c	2005-02-02 10:28:02.663613406 +0900
@@ -25,7 +25,56 @@
 
 #include <asm/io.h>
 
-#include "cmd64x.h"
+#define DISPLAY_CMD64X_TIMINGS
+
+#define CMD_DEBUG 0
+
+#if CMD_DEBUG
+#define cmdprintk(x...)	printk(x)
+#else
+#define cmdprintk(x...)
+#endif
+
+/*
+ * CMD64x specific registers definition.
+ */
+#define CFR		0x50
+#define   CFR_INTR_CH0		0x02
+#define CNTRL		0x51
+#define	  CNTRL_DIS_RA0		0x40
+#define   CNTRL_DIS_RA1		0x80
+#define	  CNTRL_ENA_2ND		0x08
+
+#define	CMDTIM		0x52
+#define	ARTTIM0		0x53
+#define	DRWTIM0		0x54
+#define ARTTIM1 	0x55
+#define DRWTIM1		0x56
+#define ARTTIM23	0x57
+#define   ARTTIM23_DIS_RA2	0x04
+#define   ARTTIM23_DIS_RA3	0x08
+#define   ARTTIM23_INTR_CH1	0x10
+#define ARTTIM2		0x57
+#define ARTTIM3		0x57
+#define DRWTIM23	0x58
+#define DRWTIM2		0x58
+#define BRST		0x59
+#define DRWTIM3		0x5b
+
+#define BMIDECR0	0x70
+#define MRDMODE		0x71
+#define   MRDMODE_INTR_CH0	0x04
+#define   MRDMODE_INTR_CH1	0x08
+#define   MRDMODE_BLK_CH0	0x10
+#define   MRDMODE_BLK_CH1	0x20
+#define BMIDESR0	0x72
+#define UDIDETCR0	0x73
+#define DTPR0		0x74
+#define BMIDECR1	0x78
+#define BMIDECSR	0x79
+#define BMIDESR1	0x7A
+#define UDIDETCR1	0x7B
+#define DTPR1		0x7C
 
 #if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
@@ -707,6 +756,39 @@ static void __devinit init_hwif_cmd64x(i
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+static ide_pci_device_t cmd64x_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "CMD643",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_hwif	= init_hwif_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 1 */
+		.name		= "CMD646",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_hwif	= init_hwif_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x80,0x80}},
+		.bootable	= ON_BOARD,
+	},{	/* 2 */
+		.name		= "CMD648",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_hwif	= init_hwif_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{
+		.name		= "CMD649",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_hwif	= init_hwif_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	}
+};
+
 static int __devinit cmd64x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_setup_pci_device(dev, &cmd64x_chipsets[id->driver_data]);
Index: linux-ide-export/drivers/ide/pci/cmd64x.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/cmd64x.h	2005-02-02 10:27:16.178155299 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,95 +0,0 @@
-#ifndef CMD64X_H
-#define CMD64X_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define DISPLAY_CMD64X_TIMINGS
-
-#define CMD_DEBUG 0
-
-#if CMD_DEBUG
-#define cmdprintk(x...)	printk(x)
-#else
-#define cmdprintk(x...)
-#endif
-
-/*
- * CMD64x specific registers definition.
- */
-#define CFR		0x50
-#define   CFR_INTR_CH0		0x02
-#define CNTRL		0x51
-#define	  CNTRL_DIS_RA0		0x40
-#define   CNTRL_DIS_RA1		0x80
-#define	  CNTRL_ENA_2ND		0x08
-
-#define	CMDTIM		0x52
-#define	ARTTIM0		0x53
-#define	DRWTIM0		0x54
-#define ARTTIM1 	0x55
-#define DRWTIM1		0x56
-#define ARTTIM23	0x57
-#define   ARTTIM23_DIS_RA2	0x04
-#define   ARTTIM23_DIS_RA3	0x08
-#define   ARTTIM23_INTR_CH1	0x10
-#define ARTTIM2		0x57
-#define ARTTIM3		0x57
-#define DRWTIM23	0x58
-#define DRWTIM2		0x58
-#define BRST		0x59
-#define DRWTIM3		0x5b
-
-#define BMIDECR0	0x70
-#define MRDMODE		0x71
-#define   MRDMODE_INTR_CH0	0x04
-#define   MRDMODE_INTR_CH1	0x08
-#define   MRDMODE_BLK_CH0	0x10
-#define   MRDMODE_BLK_CH1	0x20
-#define BMIDESR0	0x72
-#define UDIDETCR0	0x73
-#define DTPR0		0x74
-#define BMIDECR1	0x78
-#define BMIDECSR	0x79
-#define BMIDESR1	0x7A
-#define UDIDETCR1	0x7B
-#define DTPR1		0x7C
-
-static unsigned int init_chipset_cmd64x(struct pci_dev *, const char *);
-static void init_hwif_cmd64x(ide_hwif_t *);
-
-static ide_pci_device_t cmd64x_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "CMD643",
-		.init_chipset	= init_chipset_cmd64x,
-		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "CMD646",
-		.init_chipset	= init_chipset_cmd64x,
-		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x80,0x80}},
-		.bootable	= ON_BOARD,
-	},{	/* 2 */
-		.name		= "CMD648",
-		.init_chipset	= init_chipset_cmd64x,
-		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{
-		.name		= "CMD649",
-		.init_chipset	= init_chipset_cmd64x,
-		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* CMD64X_H */
Index: linux-ide-export/drivers/ide/pci/cy82c693.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/cy82c693.c	2005-02-02 10:27:16.178155299 +0900
+++ linux-ide-export/drivers/ide/pci/cy82c693.c	2005-02-02 10:28:02.664613244 +0900
@@ -54,7 +54,64 @@
 
 #include <asm/io.h>
 
-#include "cy82c693.h"
+/* the current version */
+#define CY82_VERSION	"CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)"
+
+/*
+ *	The following are used to debug the driver.
+ */
+#define	CY82C693_DEBUG_LOGS	0
+#define	CY82C693_DEBUG_INFO	0
+
+/* define CY82C693_SETDMA_CLOCK to set DMA Controller Clock Speed to ATCLK */
+#undef CY82C693_SETDMA_CLOCK
+
+/*
+ *	NOTE: the value for busmaster timeout is tricky and I got it by
+ *	 trial and error!  By using a to low value will cause DMA timeouts
+ *	 and drop IDE performance, and by using a to high value will cause
+ *	 audio playback to scatter.
+ *	 If you know a better value or how to calc it, please let me know.
+ */
+
+/* twice the value written in cy82c693ub datasheet */
+#define BUSMASTER_TIMEOUT	0x50
+/*
+ * the value above was tested on my machine and it seems to work okay
+ */
+
+/* here are the offset definitions for the registers */
+#define CY82_IDE_CMDREG		0x04
+#define CY82_IDE_ADDRSETUP	0x48
+#define CY82_IDE_MASTER_IOR	0x4C	
+#define CY82_IDE_MASTER_IOW	0x4D	
+#define CY82_IDE_SLAVE_IOR	0x4E	
+#define CY82_IDE_SLAVE_IOW	0x4F
+#define CY82_IDE_MASTER_8BIT	0x50	
+#define CY82_IDE_SLAVE_8BIT	0x51	
+
+#define CY82_INDEX_PORT		0x22
+#define CY82_DATA_PORT		0x23
+
+#define CY82_INDEX_CTRLREG1	0x01
+#define CY82_INDEX_CHANNEL0	0x30
+#define CY82_INDEX_CHANNEL1	0x31
+#define CY82_INDEX_TIMEOUT	0x32
+
+/* the max PIO mode - from datasheet */
+#define CY82C693_MAX_PIO	4
+
+/* the min and max PCI bus speed in MHz - from datasheet */
+#define CY82C963_MIN_BUS_SPEED	25
+#define CY82C963_MAX_BUS_SPEED	33
+
+/* the struct for the PIO mode timings */
+typedef struct pio_clocks_s {
+        u8	address_time;	/* Address setup (clocks) */
+	u8	time_16r;	/* clocks for 16bit IOR (0xF0=Active/data, 0x0F=Recovery) */
+	u8	time_16w;	/* clocks for 16bit IOW (0xF0=Active/data, 0x0F=Recovery) */
+	u8	time_8;		/* clocks for 8bit (0xF0=Active/data, 0x0F=Recovery) */
+} pio_clocks_t;
 
 /*
  * calc clocks using bus_speed
@@ -422,6 +479,18 @@ void __init init_iops_cy82c693(ide_hwif_
 	}
 }
 
+static ide_pci_device_t cy82c693_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "CY82C693",
+		.init_chipset	= init_chipset_cy82c693,
+		.init_iops	= init_iops_cy82c693,
+		.init_hwif	= init_hwif_cy82c693,
+		.channels	= 1,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	}
+};
+
 static int __devinit cy82c693_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	ide_pci_device_t *d = &cy82c693_chipsets[id->driver_data];
Index: linux-ide-export/drivers/ide/pci/cy82c693.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/cy82c693.h	2005-02-02 10:27:16.178155299 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,83 +0,0 @@
-#ifndef CY82C693_H
-#define CY82C693_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-/* the current version */
-#define CY82_VERSION	"CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)"
-
-/*
- *	The following are used to debug the driver.
- */
-#define	CY82C693_DEBUG_LOGS	0
-#define	CY82C693_DEBUG_INFO	0
-
-/* define CY82C693_SETDMA_CLOCK to set DMA Controller Clock Speed to ATCLK */
-#undef CY82C693_SETDMA_CLOCK
-
-/*
- *	NOTE: the value for busmaster timeout is tricky and I got it by
- *	 trial and error!  By using a to low value will cause DMA timeouts
- *	 and drop IDE performance, and by using a to high value will cause
- *	 audio playback to scatter.
- *	 If you know a better value or how to calc it, please let me know.
- */
-
-/* twice the value written in cy82c693ub datasheet */
-#define BUSMASTER_TIMEOUT	0x50
-/*
- * the value above was tested on my machine and it seems to work okay
- */
-
-/* here are the offset definitions for the registers */
-#define CY82_IDE_CMDREG		0x04
-#define CY82_IDE_ADDRSETUP	0x48
-#define CY82_IDE_MASTER_IOR	0x4C	
-#define CY82_IDE_MASTER_IOW	0x4D	
-#define CY82_IDE_SLAVE_IOR	0x4E	
-#define CY82_IDE_SLAVE_IOW	0x4F
-#define CY82_IDE_MASTER_8BIT	0x50	
-#define CY82_IDE_SLAVE_8BIT	0x51	
-
-#define CY82_INDEX_PORT		0x22
-#define CY82_DATA_PORT		0x23
-
-#define CY82_INDEX_CTRLREG1	0x01
-#define CY82_INDEX_CHANNEL0	0x30
-#define CY82_INDEX_CHANNEL1	0x31
-#define CY82_INDEX_TIMEOUT	0x32
-
-/* the max PIO mode - from datasheet */
-#define CY82C693_MAX_PIO	4
-
-/* the min and max PCI bus speed in MHz - from datasheet */
-#define CY82C963_MIN_BUS_SPEED	25
-#define CY82C963_MAX_BUS_SPEED	33
-
-/* the struct for the PIO mode timings */
-typedef struct pio_clocks_s {
-        u8	address_time;	/* Address setup (clocks) */
-	u8	time_16r;	/* clocks for 16bit IOR (0xF0=Active/data, 0x0F=Recovery) */
-	u8	time_16w;	/* clocks for 16bit IOW (0xF0=Active/data, 0x0F=Recovery) */
-	u8	time_8;		/* clocks for 8bit (0xF0=Active/data, 0x0F=Recovery) */
-} pio_clocks_t;
-
-static unsigned int init_chipset_cy82c693(struct pci_dev *, const char *);
-static void init_hwif_cy82c693(ide_hwif_t *);
-static void init_iops_cy82c693(ide_hwif_t *);
-
-static ide_pci_device_t cy82c693_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "CY82C693",
-		.init_chipset	= init_chipset_cy82c693,
-		.init_iops	= init_iops_cy82c693,
-		.init_hwif	= init_hwif_cy82c693,
-		.channels	= 1,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* CY82C693_H */
Index: linux-ide-export/drivers/ide/pci/generic.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/generic.c	2005-02-02 10:27:16.179155136 +0900
+++ linux-ide-export/drivers/ide/pci/generic.c	2005-02-02 10:28:02.665613082 +0900
@@ -39,8 +39,6 @@
 
 #include <asm/io.h>
 
-#include "generic.h"
-
 static unsigned int __devinit init_chipset_generic (struct pci_dev *dev, const char *name)
 {
 	return 0;
@@ -83,6 +81,115 @@ static void __devinit init_hwif_generic 
 	return 0;
 #endif	
 
+static ide_pci_device_t generic_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "NS87410",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
+		.bootable	= ON_BOARD,
+        },{	/* 1 */
+		.name		= "SAMURAI",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 2 */
+		.name		= "HT6565",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 3 */
+		.name		= "UM8673F",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 4 */
+		.name		= "UM8886A",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 5 */
+		.name		= "UM8886BF",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 6 */
+		.name		= "HINT_IDE",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 7 */
+		.name		= "VIA_IDE",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 8 */
+		.name		= "OPTI621V",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 9 */
+		.name		= "VIA8237SATA",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{ /* 10 */
+		.name 		= "Piccolo0102",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= ON_BOARD,
+	},{ /* 11 */
+		.name 		= "Piccolo0103",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= ON_BOARD,
+	},{ /* 12 */
+		.name 		= "Piccolo0105",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= ON_BOARD,
+	}
+};
+
+#if 0
+static ide_pci_device_t unknown_chipset[] __devinitdata = {
+	{	/* 0 */
+		.name		= "PCI_IDE",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	}
+};
+#endif
+
 /**
  *	generic_init_one	-	called when a PIIX is found
  *	@dev: the generic device
Index: linux-ide-export/drivers/ide/pci/generic.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/generic.h	2005-02-02 10:27:16.179155136 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,120 +0,0 @@
-#ifndef IDE_GENERIC_H
-#define IDE_GENERIC_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-static unsigned int init_chipset_generic(struct pci_dev *, const char *);
-static void init_hwif_generic(ide_hwif_t *);
-
-static ide_pci_device_t generic_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "NS87410",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
-		.bootable	= ON_BOARD,
-        },{	/* 1 */
-		.name		= "SAMURAI",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 2 */
-		.name		= "HT6565",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 3 */
-		.name		= "UM8673F",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 4 */
-		.name		= "UM8886A",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 5 */
-		.name		= "UM8886BF",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 6 */
-		.name		= "HINT_IDE",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 7 */
-		.name		= "VIA_IDE",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 8 */
-		.name		= "OPTI621V",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 9 */
-		.name		= "VIA8237SATA",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{ /* 10 */
-		.name 		= "Piccolo0102",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-	},{ /* 11 */
-		.name 		= "Piccolo0103",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-	},{ /* 12 */
-		.name 		= "Piccolo0105",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#if 0
-static ide_pci_device_t unknown_chipset[] __devinitdata = {
-	{	/* 0 */
-		.name		= "PCI_IDE",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-#endif
-
-#endif /* IDE_GENERIC_H */
Index: linux-ide-export/drivers/ide/pci/hpt366.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/hpt366.c	2005-02-02 10:27:16.179155136 +0900
+++ linux-ide-export/drivers/ide/pci/hpt366.c	2005-02-02 10:28:02.667612757 +0900
@@ -70,7 +70,414 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "hpt366.h"
+/* various tuning parameters */
+#define HPT_RESET_STATE_ENGINE
+#undef HPT_DELAY_INTERRUPT
+#undef HPT_SERIALIZE_IO
+
+static const char *quirk_drives[] = {
+	"QUANTUM FIREBALLlct08 08",
+	"QUANTUM FIREBALLP KA6.4",
+	"QUANTUM FIREBALLP LM20.4",
+	"QUANTUM FIREBALLP LM20.5",
+        NULL
+};
+
+static const char *bad_ata100_5[] = {
+	"IBM-DTLA-307075",
+	"IBM-DTLA-307060",
+	"IBM-DTLA-307045",
+	"IBM-DTLA-307030",
+	"IBM-DTLA-307020",
+	"IBM-DTLA-307015",
+	"IBM-DTLA-305040",
+	"IBM-DTLA-305030",
+	"IBM-DTLA-305020",
+	"IC35L010AVER07-0",
+	"IC35L020AVER07-0",
+	"IC35L030AVER07-0",
+	"IC35L040AVER07-0",
+	"IC35L060AVER07-0",
+	"WDC AC310200R",
+	NULL
+};
+
+static const char *bad_ata66_4[] = {
+	"IBM-DTLA-307075",
+	"IBM-DTLA-307060",
+	"IBM-DTLA-307045",
+	"IBM-DTLA-307030",
+	"IBM-DTLA-307020",
+	"IBM-DTLA-307015",
+	"IBM-DTLA-305040",
+	"IBM-DTLA-305030",
+	"IBM-DTLA-305020",
+	"IC35L010AVER07-0",
+	"IC35L020AVER07-0",
+	"IC35L030AVER07-0",
+	"IC35L040AVER07-0",
+	"IC35L060AVER07-0",
+	"WDC AC310200R",
+	NULL
+};
+
+static const char *bad_ata66_3[] = {
+	"WDC AC310200R",
+	NULL
+};
+
+static const char *bad_ata33[] = {
+	"Maxtor 92720U8", "Maxtor 92040U6", "Maxtor 91360U4", "Maxtor 91020U3", "Maxtor 90845U3", "Maxtor 90650U2",
+	"Maxtor 91360D8", "Maxtor 91190D7", "Maxtor 91020D6", "Maxtor 90845D5", "Maxtor 90680D4", "Maxtor 90510D3", "Maxtor 90340D2",
+	"Maxtor 91152D8", "Maxtor 91008D7", "Maxtor 90845D6", "Maxtor 90840D6", "Maxtor 90720D5", "Maxtor 90648D5", "Maxtor 90576D4",
+	"Maxtor 90510D4",
+	"Maxtor 90432D3", "Maxtor 90288D2", "Maxtor 90256D2",
+	"Maxtor 91000D8", "Maxtor 90910D8", "Maxtor 90875D7", "Maxtor 90840D7", "Maxtor 90750D6", "Maxtor 90625D5", "Maxtor 90500D4",
+	"Maxtor 91728D8", "Maxtor 91512D7", "Maxtor 91303D6", "Maxtor 91080D5", "Maxtor 90845D4", "Maxtor 90680D4", "Maxtor 90648D3", "Maxtor 90432D2",
+	NULL
+};
+
+struct chipset_bus_clock_list_entry {
+	byte		xfer_speed;
+	unsigned int	chipset_settings;
+};
+
+/* key for bus clock timings
+ * bit
+ * 0:3    data_high_time. inactive time of DIOW_/DIOR_ for PIO and MW
+ *        DMA. cycles = value + 1
+ * 4:8    data_low_time. active time of DIOW_/DIOR_ for PIO and MW
+ *        DMA. cycles = value + 1
+ * 9:12   cmd_high_time. inactive time of DIOW_/DIOR_ during task file
+ *        register access.
+ * 13:17  cmd_low_time. active time of DIOW_/DIOR_ during task file
+ *        register access.
+ * 18:21  udma_cycle_time. clock freq and clock cycles for UDMA xfer.
+ *        during task file register access.
+ * 22:24  pre_high_time. time to initialize 1st cycle for PIO and MW DMA
+ *        xfer.
+ * 25:27  cmd_pre_high_time. time to initialize 1st PIO cycle for task
+ *        register access.
+ * 28     UDMA enable
+ * 29     DMA enable
+ * 30     PIO_MST enable. if set, the chip is in bus master mode during
+ *        PIO.
+ * 31     FIFO enable.
+ */
+static struct chipset_bus_clock_list_entry forty_base_hpt366[] = {
+	{	XFER_UDMA_4,	0x900fd943	},
+	{	XFER_UDMA_3,	0x900ad943	},
+	{	XFER_UDMA_2,	0x900bd943	},
+	{	XFER_UDMA_1,	0x9008d943	},
+	{	XFER_UDMA_0,	0x9008d943	},
+
+	{	XFER_MW_DMA_2,	0xa008d943	},
+	{	XFER_MW_DMA_1,	0xa010d955	},
+	{	XFER_MW_DMA_0,	0xa010d9fc	},
+
+	{	XFER_PIO_4,	0xc008d963	},
+	{	XFER_PIO_3,	0xc010d974	},
+	{	XFER_PIO_2,	0xc010d997	},
+	{	XFER_PIO_1,	0xc010d9c7	},
+	{	XFER_PIO_0,	0xc018d9d9	},
+	{	0,		0x0120d9d9	}
+};
+
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt366[] = {
+	{	XFER_UDMA_4,	0x90c9a731	},
+	{	XFER_UDMA_3,	0x90cfa731	},
+	{	XFER_UDMA_2,	0x90caa731	},
+	{	XFER_UDMA_1,	0x90cba731	},
+	{	XFER_UDMA_0,	0x90c8a731	},
+
+	{	XFER_MW_DMA_2,	0xa0c8a731	},
+	{	XFER_MW_DMA_1,	0xa0c8a732	},	/* 0xa0c8a733 */
+	{	XFER_MW_DMA_0,	0xa0c8a797	},
+
+	{	XFER_PIO_4,	0xc0c8a731	},
+	{	XFER_PIO_3,	0xc0c8a742	},
+	{	XFER_PIO_2,	0xc0d0a753	},
+	{	XFER_PIO_1,	0xc0d0a7a3	},	/* 0xc0d0a793 */
+	{	XFER_PIO_0,	0xc0d0a7aa	},	/* 0xc0d0a7a7 */
+	{	0,		0x0120a7a7	}
+};
+
+static struct chipset_bus_clock_list_entry twenty_five_base_hpt366[] = {
+
+	{	XFER_UDMA_4,	0x90c98521	},
+	{	XFER_UDMA_3,	0x90cf8521	},
+	{	XFER_UDMA_2,	0x90cf8521	},
+	{	XFER_UDMA_1,	0x90cb8521	},
+	{	XFER_UDMA_0,	0x90cb8521	},
+
+	{	XFER_MW_DMA_2,	0xa0ca8521	},
+	{	XFER_MW_DMA_1,	0xa0ca8532	},
+	{	XFER_MW_DMA_0,	0xa0ca8575	},
+
+	{	XFER_PIO_4,	0xc0ca8521	},
+	{	XFER_PIO_3,	0xc0ca8532	},
+	{	XFER_PIO_2,	0xc0ca8542	},
+	{	XFER_PIO_1,	0xc0d08572	},
+	{	XFER_PIO_0,	0xc0d08585	},
+	{	0,		0x01208585	}
+};
+
+/* from highpoint documentation. these are old values */
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt370[] = {
+/*	{	XFER_UDMA_5,	0x1A85F442,	0x16454e31	}, */
+	{	XFER_UDMA_5,	0x16454e31	},
+	{	XFER_UDMA_4,	0x16454e31	},
+	{	XFER_UDMA_3,	0x166d4e31	},
+	{	XFER_UDMA_2,	0x16494e31	},
+	{	XFER_UDMA_1,	0x164d4e31	},
+	{	XFER_UDMA_0,	0x16514e31	},
+
+	{	XFER_MW_DMA_2,	0x26514e21	},
+	{	XFER_MW_DMA_1,	0x26514e33	},
+	{	XFER_MW_DMA_0,	0x26514e97	},
+
+	{	XFER_PIO_4,	0x06514e21	},
+	{	XFER_PIO_3,	0x06514e22	},
+	{	XFER_PIO_2,	0x06514e33	},
+	{	XFER_PIO_1,	0x06914e43	},
+	{	XFER_PIO_0,	0x06914e57	},
+	{	0,		0x06514e57	}
+};
+
+static struct chipset_bus_clock_list_entry sixty_six_base_hpt370[] = {
+	{       XFER_UDMA_5,    0x14846231      },
+	{       XFER_UDMA_4,    0x14886231      },
+	{       XFER_UDMA_3,    0x148c6231      },
+	{       XFER_UDMA_2,    0x148c6231      },
+	{       XFER_UDMA_1,    0x14906231      },
+	{       XFER_UDMA_0,    0x14986231      },
+	
+	{       XFER_MW_DMA_2,  0x26514e21      },
+	{       XFER_MW_DMA_1,  0x26514e33      },
+	{       XFER_MW_DMA_0,  0x26514e97      },
+	
+	{       XFER_PIO_4,     0x06514e21      },
+	{       XFER_PIO_3,     0x06514e22      },
+	{       XFER_PIO_2,     0x06514e33      },
+	{       XFER_PIO_1,     0x06914e43      },
+	{       XFER_PIO_0,     0x06914e57      },
+	{       0,              0x06514e57      }
+};
+
+/* these are the current (4 sep 2001) timings from highpoint */
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt370a[] = {
+        {       XFER_UDMA_5,    0x12446231      },
+        {       XFER_UDMA_4,    0x12446231      },
+        {       XFER_UDMA_3,    0x126c6231      },
+        {       XFER_UDMA_2,    0x12486231      },
+        {       XFER_UDMA_1,    0x124c6233      },
+        {       XFER_UDMA_0,    0x12506297      },
+
+        {       XFER_MW_DMA_2,  0x22406c31      },
+        {       XFER_MW_DMA_1,  0x22406c33      },
+        {       XFER_MW_DMA_0,  0x22406c97      },
+
+        {       XFER_PIO_4,     0x06414e31      },
+        {       XFER_PIO_3,     0x06414e42      },
+        {       XFER_PIO_2,     0x06414e53      },
+        {       XFER_PIO_1,     0x06814e93      },
+        {       XFER_PIO_0,     0x06814ea7      },
+        {       0,              0x06814ea7      }
+};
+
+/* 2x 33MHz timings */
+static struct chipset_bus_clock_list_entry sixty_six_base_hpt370a[] = {
+	{       XFER_UDMA_5,    0x1488e673       },
+	{       XFER_UDMA_4,    0x1488e673       },
+	{       XFER_UDMA_3,    0x1498e673       },
+	{       XFER_UDMA_2,    0x1490e673       },
+	{       XFER_UDMA_1,    0x1498e677       },
+	{       XFER_UDMA_0,    0x14a0e73f       },
+
+	{       XFER_MW_DMA_2,  0x2480fa73       },
+	{       XFER_MW_DMA_1,  0x2480fa77       }, 
+	{       XFER_MW_DMA_0,  0x2480fb3f       },
+
+	{       XFER_PIO_4,     0x0c82be73       },
+	{       XFER_PIO_3,     0x0c82be95       },
+	{       XFER_PIO_2,     0x0c82beb7       },
+	{       XFER_PIO_1,     0x0d02bf37       },
+	{       XFER_PIO_0,     0x0d02bf5f       },
+	{       0,              0x0d02bf5f       }
+};
+
+static struct chipset_bus_clock_list_entry fifty_base_hpt370a[] = {
+	{       XFER_UDMA_5,    0x12848242      },
+	{       XFER_UDMA_4,    0x12ac8242      },
+	{       XFER_UDMA_3,    0x128c8242      },
+	{       XFER_UDMA_2,    0x120c8242      },
+	{       XFER_UDMA_1,    0x12148254      },
+	{       XFER_UDMA_0,    0x121882ea      },
+
+	{       XFER_MW_DMA_2,  0x22808242      },
+	{       XFER_MW_DMA_1,  0x22808254      },
+	{       XFER_MW_DMA_0,  0x228082ea      },
+
+	{       XFER_PIO_4,     0x0a81f442      },
+	{       XFER_PIO_3,     0x0a81f443      },
+	{       XFER_PIO_2,     0x0a81f454      },
+	{       XFER_PIO_1,     0x0ac1f465      },
+	{       XFER_PIO_0,     0x0ac1f48a      },
+	{       0,              0x0ac1f48a      }
+};
+
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt372[] = {
+	{	XFER_UDMA_6,	0x1c81dc62	},
+	{	XFER_UDMA_5,	0x1c6ddc62	},
+	{	XFER_UDMA_4,	0x1c8ddc62	},
+	{	XFER_UDMA_3,	0x1c8edc62	},	/* checkme */
+	{	XFER_UDMA_2,	0x1c91dc62	},
+	{	XFER_UDMA_1,	0x1c9adc62	},	/* checkme */
+	{	XFER_UDMA_0,	0x1c82dc62	},	/* checkme */
+
+	{	XFER_MW_DMA_2,	0x2c829262	},
+	{	XFER_MW_DMA_1,	0x2c829266	},	/* checkme */
+	{	XFER_MW_DMA_0,	0x2c82922e	},	/* checkme */
+
+	{	XFER_PIO_4,	0x0c829c62	},
+	{	XFER_PIO_3,	0x0c829c84	},
+	{	XFER_PIO_2,	0x0c829ca6	},
+	{	XFER_PIO_1,	0x0d029d26	},
+	{	XFER_PIO_0,	0x0d029d5e	},
+	{	0,		0x0d029d5e	}
+};
+
+static struct chipset_bus_clock_list_entry fifty_base_hpt372[] = {
+	{	XFER_UDMA_5,	0x12848242	},
+	{	XFER_UDMA_4,	0x12ac8242	},
+	{	XFER_UDMA_3,	0x128c8242	},
+	{	XFER_UDMA_2,	0x120c8242	},
+	{	XFER_UDMA_1,	0x12148254	},
+	{	XFER_UDMA_0,	0x121882ea	},
+
+	{	XFER_MW_DMA_2,	0x22808242	},
+	{	XFER_MW_DMA_1,	0x22808254	},
+	{	XFER_MW_DMA_0,	0x228082ea	},
+
+	{	XFER_PIO_4,	0x0a81f442	},
+	{	XFER_PIO_3,	0x0a81f443	},
+	{	XFER_PIO_2,	0x0a81f454	},
+	{	XFER_PIO_1,	0x0ac1f465	},
+	{	XFER_PIO_0,	0x0ac1f48a	},
+	{	0,		0x0a81f443	}
+};
+
+static struct chipset_bus_clock_list_entry sixty_six_base_hpt372[] = {
+	{	XFER_UDMA_6,	0x1c869c62	},
+	{	XFER_UDMA_5,	0x1cae9c62	},
+	{	XFER_UDMA_4,	0x1c8a9c62	},
+	{	XFER_UDMA_3,	0x1c8e9c62	},
+	{	XFER_UDMA_2,	0x1c929c62	},
+	{	XFER_UDMA_1,	0x1c9a9c62	},
+	{	XFER_UDMA_0,	0x1c829c62	},
+
+	{	XFER_MW_DMA_2,	0x2c829c62	},
+	{	XFER_MW_DMA_1,	0x2c829c66	},
+	{	XFER_MW_DMA_0,	0x2c829d2e	},
+
+	{	XFER_PIO_4,	0x0c829c62	},
+	{	XFER_PIO_3,	0x0c829c84	},
+	{	XFER_PIO_2,	0x0c829ca6	},
+	{	XFER_PIO_1,	0x0d029d26	},
+	{	XFER_PIO_0,	0x0d029d5e	},
+	{	0,		0x0d029d26	}
+};
+
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt374[] = {
+	{	XFER_UDMA_6,	0x12808242	},
+	{	XFER_UDMA_5,	0x12848242	},
+	{	XFER_UDMA_4,	0x12ac8242	},
+	{	XFER_UDMA_3,	0x128c8242	},
+	{	XFER_UDMA_2,	0x120c8242	},
+	{	XFER_UDMA_1,	0x12148254	},
+	{	XFER_UDMA_0,	0x121882ea	},
+
+	{	XFER_MW_DMA_2,	0x22808242	},
+	{	XFER_MW_DMA_1,	0x22808254	},
+	{	XFER_MW_DMA_0,	0x228082ea	},
+
+	{	XFER_PIO_4,	0x0a81f442	},
+	{	XFER_PIO_3,	0x0a81f443	},
+	{	XFER_PIO_2,	0x0a81f454	},
+	{	XFER_PIO_1,	0x0ac1f465	},
+	{	XFER_PIO_0,	0x0ac1f48a	},
+	{	0,		0x06814e93	}
+};
+
+#if 0
+static struct chipset_bus_clock_list_entry fifty_base_hpt374[] = {
+	{	XFER_UDMA_6,	},
+	{	XFER_UDMA_5,	},
+	{	XFER_UDMA_4,	},
+	{	XFER_UDMA_3,	},
+	{	XFER_UDMA_2,	},
+	{	XFER_UDMA_1,	},
+	{	XFER_UDMA_0,	},
+	{	XFER_MW_DMA_2,	},
+	{	XFER_MW_DMA_1,	},
+	{	XFER_MW_DMA_0,	},
+	{	XFER_PIO_4,	},
+	{	XFER_PIO_3,	},
+	{	XFER_PIO_2,	},
+	{	XFER_PIO_1,	},
+	{	XFER_PIO_0,	},
+	{	0,	}
+};
+#endif
+#if 0
+static struct chipset_bus_clock_list_entry sixty_six_base_hpt374[] = {
+	{	XFER_UDMA_6,	0x12406231	},	/* checkme */
+	{	XFER_UDMA_5,	0x12446231	},
+				0x14846231
+	{	XFER_UDMA_4,		0x16814ea7	},
+				0x14886231
+	{	XFER_UDMA_3,		0x16814ea7	},
+				0x148c6231
+	{	XFER_UDMA_2,		0x16814ea7	},
+				0x148c6231
+	{	XFER_UDMA_1,		0x16814ea7	},
+				0x14906231
+	{	XFER_UDMA_0,		0x16814ea7	},
+				0x14986231
+	{	XFER_MW_DMA_2,		0x16814ea7	},
+				0x26514e21
+	{	XFER_MW_DMA_1,		0x16814ea7	},
+				0x26514e97
+	{	XFER_MW_DMA_0,		0x16814ea7	},
+				0x26514e97
+	{	XFER_PIO_4,		0x06814ea7	},
+				0x06514e21
+	{	XFER_PIO_3,		0x06814ea7	},
+				0x06514e22
+	{	XFER_PIO_2,		0x06814ea7	},
+				0x06514e33
+	{	XFER_PIO_1,		0x06814ea7	},
+				0x06914e43
+	{	XFER_PIO_0,		0x06814ea7	},
+				0x06914e57
+	{	0,		0x06814ea7	}
+};
+#endif
+
+#define HPT366_DEBUG_DRIVE_INFO		0
+#define HPT374_ALLOW_ATA133_6		0
+#define HPT371_ALLOW_ATA133_6		0
+#define HPT302_ALLOW_ATA133_6		0
+#define HPT372_ALLOW_ATA133_6		1
+#define HPT370_ALLOW_ATA100_5		1
+#define HPT366_ALLOW_ATA66_4		1
+#define HPT366_ALLOW_ATA66_3		1
+#define HPT366_MAX_DEVS			8
+
+#define F_LOW_PCI_33      0x23
+#define F_LOW_PCI_40      0x29
+#define F_LOW_PCI_50      0x2d
+#define F_LOW_PCI_66      0x42
 
 #if 0
 		if (hpt_minimum_revision(dev, 3)) {
@@ -1273,6 +1680,64 @@ init_single:
 	return ide_setup_pci_device(dev, d);
 }
 
+static ide_pci_device_t hpt366_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "HPT366",
+		.init_setup	= init_setup_hpt366,
+		.init_chipset	= init_chipset_hpt366,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+		.extra		= 240
+	},{	/* 1 */
+		.name		= "HPT372A",
+		.init_setup	= init_setup_hpt37x,
+		.init_chipset	= init_chipset_hpt366,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 2 */
+		.name		= "HPT302",
+		.init_setup	= init_setup_hpt37x,
+		.init_chipset	= init_chipset_hpt366,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 3 */
+		.name		= "HPT371",
+		.init_setup	= init_setup_hpt37x,
+		.init_chipset	= init_chipset_hpt366,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 4 */
+		.name		= "HPT374",
+		.init_setup	= init_setup_hpt374,
+		.init_chipset	= init_chipset_hpt366,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,	/* 4 */
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 5 */
+		.name		= "HPT372N",
+		.init_setup	= init_setup_hpt37x,
+		.init_chipset	= init_chipset_hpt366,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,	/* 4 */
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	}
+};
 
 /**
  *	hpt366_init_one	-	called when an HPT366 is found
Index: linux-ide-export/drivers/ide/pci/hpt366.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/hpt366.h	2005-02-02 10:27:16.179155136 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,483 +0,0 @@
-#ifndef HPT366_H
-#define HPT366_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-/* various tuning parameters */
-#define HPT_RESET_STATE_ENGINE
-#undef HPT_DELAY_INTERRUPT
-#undef HPT_SERIALIZE_IO
-
-static const char *quirk_drives[] = {
-	"QUANTUM FIREBALLlct08 08",
-	"QUANTUM FIREBALLP KA6.4",
-	"QUANTUM FIREBALLP LM20.4",
-	"QUANTUM FIREBALLP LM20.5",
-        NULL
-};
-
-static const char *bad_ata100_5[] = {
-	"IBM-DTLA-307075",
-	"IBM-DTLA-307060",
-	"IBM-DTLA-307045",
-	"IBM-DTLA-307030",
-	"IBM-DTLA-307020",
-	"IBM-DTLA-307015",
-	"IBM-DTLA-305040",
-	"IBM-DTLA-305030",
-	"IBM-DTLA-305020",
-	"IC35L010AVER07-0",
-	"IC35L020AVER07-0",
-	"IC35L030AVER07-0",
-	"IC35L040AVER07-0",
-	"IC35L060AVER07-0",
-	"WDC AC310200R",
-	NULL
-};
-
-static const char *bad_ata66_4[] = {
-	"IBM-DTLA-307075",
-	"IBM-DTLA-307060",
-	"IBM-DTLA-307045",
-	"IBM-DTLA-307030",
-	"IBM-DTLA-307020",
-	"IBM-DTLA-307015",
-	"IBM-DTLA-305040",
-	"IBM-DTLA-305030",
-	"IBM-DTLA-305020",
-	"IC35L010AVER07-0",
-	"IC35L020AVER07-0",
-	"IC35L030AVER07-0",
-	"IC35L040AVER07-0",
-	"IC35L060AVER07-0",
-	"WDC AC310200R",
-	NULL
-};
-
-static const char *bad_ata66_3[] = {
-	"WDC AC310200R",
-	NULL
-};
-
-static const char *bad_ata33[] = {
-	"Maxtor 92720U8", "Maxtor 92040U6", "Maxtor 91360U4", "Maxtor 91020U3", "Maxtor 90845U3", "Maxtor 90650U2",
-	"Maxtor 91360D8", "Maxtor 91190D7", "Maxtor 91020D6", "Maxtor 90845D5", "Maxtor 90680D4", "Maxtor 90510D3", "Maxtor 90340D2",
-	"Maxtor 91152D8", "Maxtor 91008D7", "Maxtor 90845D6", "Maxtor 90840D6", "Maxtor 90720D5", "Maxtor 90648D5", "Maxtor 90576D4",
-	"Maxtor 90510D4",
-	"Maxtor 90432D3", "Maxtor 90288D2", "Maxtor 90256D2",
-	"Maxtor 91000D8", "Maxtor 90910D8", "Maxtor 90875D7", "Maxtor 90840D7", "Maxtor 90750D6", "Maxtor 90625D5", "Maxtor 90500D4",
-	"Maxtor 91728D8", "Maxtor 91512D7", "Maxtor 91303D6", "Maxtor 91080D5", "Maxtor 90845D4", "Maxtor 90680D4", "Maxtor 90648D3", "Maxtor 90432D2",
-	NULL
-};
-
-struct chipset_bus_clock_list_entry {
-	byte		xfer_speed;
-	unsigned int	chipset_settings;
-};
-
-/* key for bus clock timings
- * bit
- * 0:3    data_high_time. inactive time of DIOW_/DIOR_ for PIO and MW
- *        DMA. cycles = value + 1
- * 4:8    data_low_time. active time of DIOW_/DIOR_ for PIO and MW
- *        DMA. cycles = value + 1
- * 9:12   cmd_high_time. inactive time of DIOW_/DIOR_ during task file
- *        register access.
- * 13:17  cmd_low_time. active time of DIOW_/DIOR_ during task file
- *        register access.
- * 18:21  udma_cycle_time. clock freq and clock cycles for UDMA xfer.
- *        during task file register access.
- * 22:24  pre_high_time. time to initialize 1st cycle for PIO and MW DMA
- *        xfer.
- * 25:27  cmd_pre_high_time. time to initialize 1st PIO cycle for task
- *        register access.
- * 28     UDMA enable
- * 29     DMA enable
- * 30     PIO_MST enable. if set, the chip is in bus master mode during
- *        PIO.
- * 31     FIFO enable.
- */
-static struct chipset_bus_clock_list_entry forty_base_hpt366[] = {
-	{	XFER_UDMA_4,	0x900fd943	},
-	{	XFER_UDMA_3,	0x900ad943	},
-	{	XFER_UDMA_2,	0x900bd943	},
-	{	XFER_UDMA_1,	0x9008d943	},
-	{	XFER_UDMA_0,	0x9008d943	},
-
-	{	XFER_MW_DMA_2,	0xa008d943	},
-	{	XFER_MW_DMA_1,	0xa010d955	},
-	{	XFER_MW_DMA_0,	0xa010d9fc	},
-
-	{	XFER_PIO_4,	0xc008d963	},
-	{	XFER_PIO_3,	0xc010d974	},
-	{	XFER_PIO_2,	0xc010d997	},
-	{	XFER_PIO_1,	0xc010d9c7	},
-	{	XFER_PIO_0,	0xc018d9d9	},
-	{	0,		0x0120d9d9	}
-};
-
-static struct chipset_bus_clock_list_entry thirty_three_base_hpt366[] = {
-	{	XFER_UDMA_4,	0x90c9a731	},
-	{	XFER_UDMA_3,	0x90cfa731	},
-	{	XFER_UDMA_2,	0x90caa731	},
-	{	XFER_UDMA_1,	0x90cba731	},
-	{	XFER_UDMA_0,	0x90c8a731	},
-
-	{	XFER_MW_DMA_2,	0xa0c8a731	},
-	{	XFER_MW_DMA_1,	0xa0c8a732	},	/* 0xa0c8a733 */
-	{	XFER_MW_DMA_0,	0xa0c8a797	},
-
-	{	XFER_PIO_4,	0xc0c8a731	},
-	{	XFER_PIO_3,	0xc0c8a742	},
-	{	XFER_PIO_2,	0xc0d0a753	},
-	{	XFER_PIO_1,	0xc0d0a7a3	},	/* 0xc0d0a793 */
-	{	XFER_PIO_0,	0xc0d0a7aa	},	/* 0xc0d0a7a7 */
-	{	0,		0x0120a7a7	}
-};
-
-static struct chipset_bus_clock_list_entry twenty_five_base_hpt366[] = {
-
-	{	XFER_UDMA_4,	0x90c98521	},
-	{	XFER_UDMA_3,	0x90cf8521	},
-	{	XFER_UDMA_2,	0x90cf8521	},
-	{	XFER_UDMA_1,	0x90cb8521	},
-	{	XFER_UDMA_0,	0x90cb8521	},
-
-	{	XFER_MW_DMA_2,	0xa0ca8521	},
-	{	XFER_MW_DMA_1,	0xa0ca8532	},
-	{	XFER_MW_DMA_0,	0xa0ca8575	},
-
-	{	XFER_PIO_4,	0xc0ca8521	},
-	{	XFER_PIO_3,	0xc0ca8532	},
-	{	XFER_PIO_2,	0xc0ca8542	},
-	{	XFER_PIO_1,	0xc0d08572	},
-	{	XFER_PIO_0,	0xc0d08585	},
-	{	0,		0x01208585	}
-};
-
-/* from highpoint documentation. these are old values */
-static struct chipset_bus_clock_list_entry thirty_three_base_hpt370[] = {
-/*	{	XFER_UDMA_5,	0x1A85F442,	0x16454e31	}, */
-	{	XFER_UDMA_5,	0x16454e31	},
-	{	XFER_UDMA_4,	0x16454e31	},
-	{	XFER_UDMA_3,	0x166d4e31	},
-	{	XFER_UDMA_2,	0x16494e31	},
-	{	XFER_UDMA_1,	0x164d4e31	},
-	{	XFER_UDMA_0,	0x16514e31	},
-
-	{	XFER_MW_DMA_2,	0x26514e21	},
-	{	XFER_MW_DMA_1,	0x26514e33	},
-	{	XFER_MW_DMA_0,	0x26514e97	},
-
-	{	XFER_PIO_4,	0x06514e21	},
-	{	XFER_PIO_3,	0x06514e22	},
-	{	XFER_PIO_2,	0x06514e33	},
-	{	XFER_PIO_1,	0x06914e43	},
-	{	XFER_PIO_0,	0x06914e57	},
-	{	0,		0x06514e57	}
-};
-
-static struct chipset_bus_clock_list_entry sixty_six_base_hpt370[] = {
-	{       XFER_UDMA_5,    0x14846231      },
-	{       XFER_UDMA_4,    0x14886231      },
-	{       XFER_UDMA_3,    0x148c6231      },
-	{       XFER_UDMA_2,    0x148c6231      },
-	{       XFER_UDMA_1,    0x14906231      },
-	{       XFER_UDMA_0,    0x14986231      },
-	
-	{       XFER_MW_DMA_2,  0x26514e21      },
-	{       XFER_MW_DMA_1,  0x26514e33      },
-	{       XFER_MW_DMA_0,  0x26514e97      },
-	
-	{       XFER_PIO_4,     0x06514e21      },
-	{       XFER_PIO_3,     0x06514e22      },
-	{       XFER_PIO_2,     0x06514e33      },
-	{       XFER_PIO_1,     0x06914e43      },
-	{       XFER_PIO_0,     0x06914e57      },
-	{       0,              0x06514e57      }
-};
-
-/* these are the current (4 sep 2001) timings from highpoint */
-static struct chipset_bus_clock_list_entry thirty_three_base_hpt370a[] = {
-        {       XFER_UDMA_5,    0x12446231      },
-        {       XFER_UDMA_4,    0x12446231      },
-        {       XFER_UDMA_3,    0x126c6231      },
-        {       XFER_UDMA_2,    0x12486231      },
-        {       XFER_UDMA_1,    0x124c6233      },
-        {       XFER_UDMA_0,    0x12506297      },
-
-        {       XFER_MW_DMA_2,  0x22406c31      },
-        {       XFER_MW_DMA_1,  0x22406c33      },
-        {       XFER_MW_DMA_0,  0x22406c97      },
-
-        {       XFER_PIO_4,     0x06414e31      },
-        {       XFER_PIO_3,     0x06414e42      },
-        {       XFER_PIO_2,     0x06414e53      },
-        {       XFER_PIO_1,     0x06814e93      },
-        {       XFER_PIO_0,     0x06814ea7      },
-        {       0,              0x06814ea7      }
-};
-
-/* 2x 33MHz timings */
-static struct chipset_bus_clock_list_entry sixty_six_base_hpt370a[] = {
-	{       XFER_UDMA_5,    0x1488e673       },
-	{       XFER_UDMA_4,    0x1488e673       },
-	{       XFER_UDMA_3,    0x1498e673       },
-	{       XFER_UDMA_2,    0x1490e673       },
-	{       XFER_UDMA_1,    0x1498e677       },
-	{       XFER_UDMA_0,    0x14a0e73f       },
-
-	{       XFER_MW_DMA_2,  0x2480fa73       },
-	{       XFER_MW_DMA_1,  0x2480fa77       }, 
-	{       XFER_MW_DMA_0,  0x2480fb3f       },
-
-	{       XFER_PIO_4,     0x0c82be73       },
-	{       XFER_PIO_3,     0x0c82be95       },
-	{       XFER_PIO_2,     0x0c82beb7       },
-	{       XFER_PIO_1,     0x0d02bf37       },
-	{       XFER_PIO_0,     0x0d02bf5f       },
-	{       0,              0x0d02bf5f       }
-};
-
-static struct chipset_bus_clock_list_entry fifty_base_hpt370a[] = {
-	{       XFER_UDMA_5,    0x12848242      },
-	{       XFER_UDMA_4,    0x12ac8242      },
-	{       XFER_UDMA_3,    0x128c8242      },
-	{       XFER_UDMA_2,    0x120c8242      },
-	{       XFER_UDMA_1,    0x12148254      },
-	{       XFER_UDMA_0,    0x121882ea      },
-
-	{       XFER_MW_DMA_2,  0x22808242      },
-	{       XFER_MW_DMA_1,  0x22808254      },
-	{       XFER_MW_DMA_0,  0x228082ea      },
-
-	{       XFER_PIO_4,     0x0a81f442      },
-	{       XFER_PIO_3,     0x0a81f443      },
-	{       XFER_PIO_2,     0x0a81f454      },
-	{       XFER_PIO_1,     0x0ac1f465      },
-	{       XFER_PIO_0,     0x0ac1f48a      },
-	{       0,              0x0ac1f48a      }
-};
-
-static struct chipset_bus_clock_list_entry thirty_three_base_hpt372[] = {
-	{	XFER_UDMA_6,	0x1c81dc62	},
-	{	XFER_UDMA_5,	0x1c6ddc62	},
-	{	XFER_UDMA_4,	0x1c8ddc62	},
-	{	XFER_UDMA_3,	0x1c8edc62	},	/* checkme */
-	{	XFER_UDMA_2,	0x1c91dc62	},
-	{	XFER_UDMA_1,	0x1c9adc62	},	/* checkme */
-	{	XFER_UDMA_0,	0x1c82dc62	},	/* checkme */
-
-	{	XFER_MW_DMA_2,	0x2c829262	},
-	{	XFER_MW_DMA_1,	0x2c829266	},	/* checkme */
-	{	XFER_MW_DMA_0,	0x2c82922e	},	/* checkme */
-
-	{	XFER_PIO_4,	0x0c829c62	},
-	{	XFER_PIO_3,	0x0c829c84	},
-	{	XFER_PIO_2,	0x0c829ca6	},
-	{	XFER_PIO_1,	0x0d029d26	},
-	{	XFER_PIO_0,	0x0d029d5e	},
-	{	0,		0x0d029d5e	}
-};
-
-static struct chipset_bus_clock_list_entry fifty_base_hpt372[] = {
-	{	XFER_UDMA_5,	0x12848242	},
-	{	XFER_UDMA_4,	0x12ac8242	},
-	{	XFER_UDMA_3,	0x128c8242	},
-	{	XFER_UDMA_2,	0x120c8242	},
-	{	XFER_UDMA_1,	0x12148254	},
-	{	XFER_UDMA_0,	0x121882ea	},
-
-	{	XFER_MW_DMA_2,	0x22808242	},
-	{	XFER_MW_DMA_1,	0x22808254	},
-	{	XFER_MW_DMA_0,	0x228082ea	},
-
-	{	XFER_PIO_4,	0x0a81f442	},
-	{	XFER_PIO_3,	0x0a81f443	},
-	{	XFER_PIO_2,	0x0a81f454	},
-	{	XFER_PIO_1,	0x0ac1f465	},
-	{	XFER_PIO_0,	0x0ac1f48a	},
-	{	0,		0x0a81f443	}
-};
-
-static struct chipset_bus_clock_list_entry sixty_six_base_hpt372[] = {
-	{	XFER_UDMA_6,	0x1c869c62	},
-	{	XFER_UDMA_5,	0x1cae9c62	},
-	{	XFER_UDMA_4,	0x1c8a9c62	},
-	{	XFER_UDMA_3,	0x1c8e9c62	},
-	{	XFER_UDMA_2,	0x1c929c62	},
-	{	XFER_UDMA_1,	0x1c9a9c62	},
-	{	XFER_UDMA_0,	0x1c829c62	},
-
-	{	XFER_MW_DMA_2,	0x2c829c62	},
-	{	XFER_MW_DMA_1,	0x2c829c66	},
-	{	XFER_MW_DMA_0,	0x2c829d2e	},
-
-	{	XFER_PIO_4,	0x0c829c62	},
-	{	XFER_PIO_3,	0x0c829c84	},
-	{	XFER_PIO_2,	0x0c829ca6	},
-	{	XFER_PIO_1,	0x0d029d26	},
-	{	XFER_PIO_0,	0x0d029d5e	},
-	{	0,		0x0d029d26	}
-};
-
-static struct chipset_bus_clock_list_entry thirty_three_base_hpt374[] = {
-	{	XFER_UDMA_6,	0x12808242	},
-	{	XFER_UDMA_5,	0x12848242	},
-	{	XFER_UDMA_4,	0x12ac8242	},
-	{	XFER_UDMA_3,	0x128c8242	},
-	{	XFER_UDMA_2,	0x120c8242	},
-	{	XFER_UDMA_1,	0x12148254	},
-	{	XFER_UDMA_0,	0x121882ea	},
-
-	{	XFER_MW_DMA_2,	0x22808242	},
-	{	XFER_MW_DMA_1,	0x22808254	},
-	{	XFER_MW_DMA_0,	0x228082ea	},
-
-	{	XFER_PIO_4,	0x0a81f442	},
-	{	XFER_PIO_3,	0x0a81f443	},
-	{	XFER_PIO_2,	0x0a81f454	},
-	{	XFER_PIO_1,	0x0ac1f465	},
-	{	XFER_PIO_0,	0x0ac1f48a	},
-	{	0,		0x06814e93	}
-};
-
-#if 0
-static struct chipset_bus_clock_list_entry fifty_base_hpt374[] = {
-	{	XFER_UDMA_6,	},
-	{	XFER_UDMA_5,	},
-	{	XFER_UDMA_4,	},
-	{	XFER_UDMA_3,	},
-	{	XFER_UDMA_2,	},
-	{	XFER_UDMA_1,	},
-	{	XFER_UDMA_0,	},
-	{	XFER_MW_DMA_2,	},
-	{	XFER_MW_DMA_1,	},
-	{	XFER_MW_DMA_0,	},
-	{	XFER_PIO_4,	},
-	{	XFER_PIO_3,	},
-	{	XFER_PIO_2,	},
-	{	XFER_PIO_1,	},
-	{	XFER_PIO_0,	},
-	{	0,	}
-};
-#endif
-#if 0
-static struct chipset_bus_clock_list_entry sixty_six_base_hpt374[] = {
-	{	XFER_UDMA_6,	0x12406231	},	/* checkme */
-	{	XFER_UDMA_5,	0x12446231	},
-				0x14846231
-	{	XFER_UDMA_4,		0x16814ea7	},
-				0x14886231
-	{	XFER_UDMA_3,		0x16814ea7	},
-				0x148c6231
-	{	XFER_UDMA_2,		0x16814ea7	},
-				0x148c6231
-	{	XFER_UDMA_1,		0x16814ea7	},
-				0x14906231
-	{	XFER_UDMA_0,		0x16814ea7	},
-				0x14986231
-	{	XFER_MW_DMA_2,		0x16814ea7	},
-				0x26514e21
-	{	XFER_MW_DMA_1,		0x16814ea7	},
-				0x26514e97
-	{	XFER_MW_DMA_0,		0x16814ea7	},
-				0x26514e97
-	{	XFER_PIO_4,		0x06814ea7	},
-				0x06514e21
-	{	XFER_PIO_3,		0x06814ea7	},
-				0x06514e22
-	{	XFER_PIO_2,		0x06814ea7	},
-				0x06514e33
-	{	XFER_PIO_1,		0x06814ea7	},
-				0x06914e43
-	{	XFER_PIO_0,		0x06814ea7	},
-				0x06914e57
-	{	0,		0x06814ea7	}
-};
-#endif
-
-#define HPT366_DEBUG_DRIVE_INFO		0
-#define HPT374_ALLOW_ATA133_6		0
-#define HPT371_ALLOW_ATA133_6		0
-#define HPT302_ALLOW_ATA133_6		0
-#define HPT372_ALLOW_ATA133_6		1
-#define HPT370_ALLOW_ATA100_5		1
-#define HPT366_ALLOW_ATA66_4		1
-#define HPT366_ALLOW_ATA66_3		1
-#define HPT366_MAX_DEVS			8
-
-#define F_LOW_PCI_33      0x23
-#define F_LOW_PCI_40      0x29
-#define F_LOW_PCI_50      0x2d
-#define F_LOW_PCI_66      0x42
-
-static int init_setup_hpt366(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_hpt37x(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_hpt374(struct pci_dev *, ide_pci_device_t *);
-static unsigned int init_chipset_hpt366(struct pci_dev *, const char *);
-static void init_hwif_hpt366(ide_hwif_t *);
-static void init_dma_hpt366(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t hpt366_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "HPT366",
-		.init_setup	= init_setup_hpt366,
-		.init_chipset	= init_chipset_hpt366,
-		.init_hwif	= init_hwif_hpt366,
-		.init_dma	= init_dma_hpt366,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-		.extra		= 240
-	},{	/* 1 */
-		.name		= "HPT372A",
-		.init_setup	= init_setup_hpt37x,
-		.init_chipset	= init_chipset_hpt366,
-		.init_hwif	= init_hwif_hpt366,
-		.init_dma	= init_dma_hpt366,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 2 */
-		.name		= "HPT302",
-		.init_setup	= init_setup_hpt37x,
-		.init_chipset	= init_chipset_hpt366,
-		.init_hwif	= init_hwif_hpt366,
-		.init_dma	= init_dma_hpt366,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 3 */
-		.name		= "HPT371",
-		.init_setup	= init_setup_hpt37x,
-		.init_chipset	= init_chipset_hpt366,
-		.init_hwif	= init_hwif_hpt366,
-		.init_dma	= init_dma_hpt366,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 4 */
-		.name		= "HPT374",
-		.init_setup	= init_setup_hpt374,
-		.init_chipset	= init_chipset_hpt366,
-		.init_hwif	= init_hwif_hpt366,
-		.init_dma	= init_dma_hpt366,
-		.channels	= 2,	/* 4 */
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 5 */
-		.name		= "HPT372N",
-		.init_setup	= init_setup_hpt37x,
-		.init_chipset	= init_chipset_hpt366,
-		.init_hwif	= init_hwif_hpt366,
-		.init_dma	= init_dma_hpt366,
-		.channels	= 2,	/* 4 */
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	}
-};
-
-#endif /* HPT366_H */
Index: linux-ide-export/drivers/ide/pci/it8172.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/it8172.c	2005-02-02 10:27:16.180154974 +0900
+++ linux-ide-export/drivers/ide/pci/it8172.c	2005-02-02 10:28:02.669612433 +0900
@@ -42,8 +42,6 @@
 #include <asm/io.h>
 #include <asm/it8172/it8172_int.h>
 
-#include "it8172.h"
-
 /*
  * Prototypes
  */
@@ -266,6 +264,18 @@ static void __init init_hwif_it8172 (ide
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+static ide_pci_device_t it8172_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "IT8172G",
+		.init_chipset	= init_chipset_it8172,
+		.init_hwif	= init_hwif_it8172,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x40,0x00,0x01}},
+		.bootable	= ON_BOARD,
+	}
+};
+
 static int __devinit it8172_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
         if ((!(PCI_FUNC(dev->devfn) & 1) ||
Index: linux-ide-export/drivers/ide/pci/it8172.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/it8172.h	2005-02-02 10:28:01.638779685 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,31 +0,0 @@
-#ifndef ITE8172G_H
-#define ITE8172G_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-static u8 it8172_ratemask(ide_drive_t *drive);
-static void it8172_tune_drive(ide_drive_t *drive, u8 pio);
-static u8 it8172_dma_2_pio(u8 xfer_rate);
-static int it8172_tune_chipset(ide_drive_t *drive, u8 xferspeed);
-#ifdef CONFIG_BLK_DEV_IDEDMA
-static int it8172_config_chipset_for_dma(ide_drive_t *drive);
-#endif
-
-static unsigned int init_chipset_it8172(struct pci_dev *, const char *);
-static void init_hwif_it8172(ide_hwif_t *);
-
-static ide_pci_device_t it8172_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "IT8172G",
-		.init_chipset	= init_chipset_it8172,
-		.init_hwif	= init_hwif_it8172,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x40,0x00,0x01}},
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* ITE8172G_H */
Index: linux-ide-export/drivers/ide/pci/opti621.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/opti621.c	2005-02-02 10:28:01.947729558 +0900
+++ linux-ide-export/drivers/ide/pci/opti621.c	2005-02-02 10:28:02.671612108 +0900
@@ -104,8 +104,6 @@
 
 #include <asm/io.h>
 
-#include "opti621.h"
-
 #define OPTI621_MAX_PIO 3
 /* In fact, I do not have any PIO 4 drive
  * (address: 25 ns, data: 70 ns, recovery: 35 ns),
@@ -348,6 +346,24 @@ static void __init init_hwif_opti621 (id
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+static ide_pci_device_t opti621_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "OPTI621",
+		.init_hwif	= init_hwif_opti621,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
+		.bootable	= ON_BOARD,
+	},{	/* 1 */
+		.name		= "OPTI621X",
+		.init_hwif	= init_hwif_opti621,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
+		.bootable	= ON_BOARD,
+	}
+};
+
 static int __devinit opti621_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_setup_pci_device(dev, &opti621_chipsets[id->driver_data]);
Index: linux-ide-export/drivers/ide/pci/opti621.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/opti621.h	2005-02-02 10:28:01.948729395 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,28 +0,0 @@
-#ifndef OPTI621_H
-#define OPTI621_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-static void init_hwif_opti621(ide_hwif_t *);
-
-static ide_pci_device_t opti621_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "OPTI621",
-		.init_hwif	= init_hwif_opti621,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
-		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "OPTI621X",
-		.init_hwif	= init_hwif_opti621,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* OPTI621_H */
Index: linux-ide-export/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/pdc202xx_new.c	2005-02-02 10:27:16.181154812 +0900
+++ linux-ide-export/drivers/ide/pci/pdc202xx_new.c	2005-02-02 10:28:02.672611946 +0900
@@ -37,10 +37,46 @@
 #include <asm/pci-bridge.h>
 #endif
 
-#include "pdc202xx_new.h"
-
 #define PDC202_DEBUG_CABLE	0
 
+const static char *pdc_quirk_drives[] = {
+	"QUANTUM FIREBALLlct08 08",
+	"QUANTUM FIREBALLP KA6.4",
+	"QUANTUM FIREBALLP KA9.1",
+	"QUANTUM FIREBALLP LM20.4",
+	"QUANTUM FIREBALLP KX13.6",
+	"QUANTUM FIREBALLP KX20.5",
+	"QUANTUM FIREBALLP KX27.3",
+	"QUANTUM FIREBALLP LM20.5",
+	NULL
+};
+
+#define set_2regs(a, b)					\
+	do {						\
+		hwif->OUTB((a + adj), indexreg);	\
+		hwif->OUTB(b, datareg);			\
+	} while(0)
+
+#define set_ultra(a, b, c)				\
+	do {						\
+		set_2regs(0x10,(a));			\
+		set_2regs(0x11,(b));			\
+		set_2regs(0x12,(c));			\
+	} while(0)
+
+#define set_ata2(a, b)					\
+	do {						\
+		set_2regs(0x0e,(a));			\
+		set_2regs(0x0f,(b));			\
+	} while(0)
+
+#define set_pio(a, b, c)				\
+	do { 						\
+		set_2regs(0x0c,(a));			\
+		set_2regs(0x0d,(b));			\
+		set_2regs(0x13,(c));			\
+	} while(0)
+
 static u8 pdcnew_ratemask (ide_drive_t *drive)
 {
 	u8 mode;
@@ -360,6 +396,72 @@ static int __devinit init_setup_pdc20276
 	return ide_setup_pci_device(dev, d);
 }
 
+static ide_pci_device_t pdcnew_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "PDC20268",
+		.init_setup	= init_setup_pdcnew,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 1 */
+		.name		= "PDC20269",
+		.init_setup	= init_setup_pdcnew,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 2 */
+		.name		= "PDC20270",
+		.init_setup	= init_setup_pdc20270,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+	},{	/* 3 */
+		.name		= "PDC20271",
+		.init_setup	= init_setup_pdcnew,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 4 */
+		.name		= "PDC20275",
+		.init_setup	= init_setup_pdcnew,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 5 */
+		.name		= "PDC20276",
+		.init_setup	= init_setup_pdc20276,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+	},{	/* 6 */
+		.name		= "PDC20277",
+		.init_setup	= init_setup_pdcnew,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	}
+};
+
 /**
  *	pdc202new_init_one	-	called when a pdc202xx is found
  *	@dev: the pdc202new device
Index: linux-ide-export/drivers/ide/pci/pdc202xx_new.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/pdc202xx_new.h	2005-02-02 10:27:16.181154812 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,118 +0,0 @@
-#ifndef PDC202XX_H
-#define PDC202XX_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-const static char *pdc_quirk_drives[] = {
-	"QUANTUM FIREBALLlct08 08",
-	"QUANTUM FIREBALLP KA6.4",
-	"QUANTUM FIREBALLP KA9.1",
-	"QUANTUM FIREBALLP LM20.4",
-	"QUANTUM FIREBALLP KX13.6",
-	"QUANTUM FIREBALLP KX20.5",
-	"QUANTUM FIREBALLP KX27.3",
-	"QUANTUM FIREBALLP LM20.5",
-	NULL
-};
-
-#define set_2regs(a, b)					\
-	do {						\
-		hwif->OUTB((a + adj), indexreg);	\
-		hwif->OUTB(b, datareg);			\
-	} while(0)
-
-#define set_ultra(a, b, c)				\
-	do {						\
-		set_2regs(0x10,(a));			\
-		set_2regs(0x11,(b));			\
-		set_2regs(0x12,(c));			\
-	} while(0)
-
-#define set_ata2(a, b)					\
-	do {						\
-		set_2regs(0x0e,(a));			\
-		set_2regs(0x0f,(b));			\
-	} while(0)
-
-#define set_pio(a, b, c)				\
-	do { 						\
-		set_2regs(0x0c,(a));			\
-		set_2regs(0x0d,(b));			\
-		set_2regs(0x13,(c));			\
-	} while(0)
-
-static int init_setup_pdcnew(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_pdc20270(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_pdc20276(struct pci_dev *dev, ide_pci_device_t *d);
-static unsigned int init_chipset_pdcnew(struct pci_dev *, const char *);
-static void init_hwif_pdc202new(ide_hwif_t *);
-
-static ide_pci_device_t pdcnew_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "PDC20268",
-		.init_setup	= init_setup_pdcnew,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 1 */
-		.name		= "PDC20269",
-		.init_setup	= init_setup_pdcnew,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 2 */
-		.name		= "PDC20270",
-		.init_setup	= init_setup_pdc20270,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-	},{	/* 3 */
-		.name		= "PDC20271",
-		.init_setup	= init_setup_pdcnew,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 4 */
-		.name		= "PDC20275",
-		.init_setup	= init_setup_pdcnew,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 5 */
-		.name		= "PDC20276",
-		.init_setup	= init_setup_pdc20276,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-	},{	/* 6 */
-		.name		= "PDC20277",
-		.init_setup	= init_setup_pdcnew,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	}
-};
-
-#endif /* PDC202XX_H */
Index: linux-ide-export/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/pdc202xx_old.c	2005-02-02 10:27:16.181154812 +0900
+++ linux-ide-export/drivers/ide/pci/pdc202xx_old.c	2005-02-02 10:28:02.674611622 +0900
@@ -46,9 +46,64 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "pdc202xx_old.h"
+#define PDC202_DEBUG_CABLE		0
+#define PDC202XX_DEBUG_DRIVE_INFO	0
 
-#define PDC202_DEBUG_CABLE	0
+static const char *pdc_quirk_drives[] = {
+	"QUANTUM FIREBALLlct08 08",
+	"QUANTUM FIREBALLP KA6.4",
+	"QUANTUM FIREBALLP KA9.1",
+	"QUANTUM FIREBALLP LM20.4",
+	"QUANTUM FIREBALLP KX13.6",
+	"QUANTUM FIREBALLP KX20.5",
+	"QUANTUM FIREBALLP KX27.3",
+	"QUANTUM FIREBALLP LM20.5",
+	NULL
+};
+
+#ifndef SPLIT_BYTE
+#define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
+#endif
+
+/* A Register */
+#define	SYNC_ERRDY_EN	0xC0
+
+#define	SYNC_IN		0x80	/* control bit, different for master vs. slave drives */
+#define	ERRDY_EN	0x40	/* control bit, different for master vs. slave drives */
+#define	IORDY_EN	0x20	/* PIO: IOREADY */
+#define	PREFETCH_EN	0x10	/* PIO: PREFETCH */
+
+#define	PA3		0x08	/* PIO"A" timing */
+#define	PA2		0x04	/* PIO"A" timing */
+#define	PA1		0x02	/* PIO"A" timing */
+#define	PA0		0x01	/* PIO"A" timing */
+
+/* B Register */
+
+#define	MB2		0x80	/* DMA"B" timing */
+#define	MB1		0x40	/* DMA"B" timing */
+#define	MB0		0x20	/* DMA"B" timing */
+
+#define	PB4		0x10	/* PIO_FORCE 1:0 */
+
+#define	PB3		0x08	/* PIO"B" timing */	/* PIO flow Control mode */
+#define	PB2		0x04	/* PIO"B" timing */	/* PIO 4 */
+#define	PB1		0x02	/* PIO"B" timing */	/* PIO 3 half */
+#define	PB0		0x01	/* PIO"B" timing */	/* PIO 3 other half */
+
+/* C Register */
+#define	IORDYp_NO_SPEED	0x4F
+#define	SPEED_DIS	0x0F
+
+#define	DMARQp		0x80
+#define	IORDYp		0x40
+#define	DMAR_EN		0x20
+#define	DMAW_EN		0x10
+
+#define	MC3		0x08	/* DMA"C" timing */
+#define	MC2		0x04	/* DMA"C" timing */
+#define	MC1		0x02	/* DMA"C" timing */
+#define	MC0		0x01	/* DMA"C" timing */
 
 #if 0
 	unsigned long bibma  = pci_resource_start(dev, 4);
@@ -725,6 +780,77 @@ static int __devinit init_setup_pdc202xx
 	return ide_setup_pci_device(dev, d);
 }
 
+static ide_pci_device_t pdc202xx_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "PDC20246",
+		.init_setup	= init_setup_pdc202ata4,
+		.init_chipset	= init_chipset_pdc202xx,
+		.init_hwif	= init_hwif_pdc202xx,
+		.init_dma	= init_dma_pdc202xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+		.extra		= 16,
+	},{	/* 1 */
+		.name		= "PDC20262",
+		.init_setup	= init_setup_pdc202ata4,
+		.init_chipset	= init_chipset_pdc202xx,
+		.init_hwif	= init_hwif_pdc202xx,
+		.init_dma	= init_dma_pdc202xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+		.extra		= 48,
+		.flags		= IDEPCI_FLAG_FORCE_PDC,
+	},{	/* 2 */
+		.name		= "PDC20263",
+		.init_setup	= init_setup_pdc202ata4,
+		.init_chipset	= init_chipset_pdc202xx,
+		.init_hwif	= init_hwif_pdc202xx,
+		.init_dma	= init_dma_pdc202xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+		.extra		= 48,
+	},{	/* 3 */
+		.name		= "PDC20265",
+		.init_setup	= init_setup_pdc20265,
+		.init_chipset	= init_chipset_pdc202xx,
+		.init_hwif	= init_hwif_pdc202xx,
+		.init_dma	= init_dma_pdc202xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+		.extra		= 48,
+		.flags		= IDEPCI_FLAG_FORCE_PDC,
+	},{	/* 4 */
+		.name		= "PDC20267",
+		.init_setup	= init_setup_pdc202xx,
+		.init_chipset	= init_chipset_pdc202xx,
+		.init_hwif	= init_hwif_pdc202xx,
+		.init_dma	= init_dma_pdc202xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+		.extra		= 48,
+	}
+};
+
 /**
  *	pdc202xx_init_one	-	called when a PDC202xx is found
  *	@dev: the pdc202xx device
Index: linux-ide-export/drivers/ide/pci/pdc202xx_old.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/pdc202xx_old.h	2005-02-02 10:27:16.182154650 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,144 +0,0 @@
-#ifndef PDC202XX_H
-#define PDC202XX_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#ifndef SPLIT_BYTE
-#define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
-#endif
-
-#define PDC202XX_DEBUG_DRIVE_INFO		0
-
-static const char *pdc_quirk_drives[] = {
-	"QUANTUM FIREBALLlct08 08",
-	"QUANTUM FIREBALLP KA6.4",
-	"QUANTUM FIREBALLP KA9.1",
-	"QUANTUM FIREBALLP LM20.4",
-	"QUANTUM FIREBALLP KX13.6",
-	"QUANTUM FIREBALLP KX20.5",
-	"QUANTUM FIREBALLP KX27.3",
-	"QUANTUM FIREBALLP LM20.5",
-	NULL
-};
-
-/* A Register */
-#define	SYNC_ERRDY_EN	0xC0
-
-#define	SYNC_IN		0x80	/* control bit, different for master vs. slave drives */
-#define	ERRDY_EN	0x40	/* control bit, different for master vs. slave drives */
-#define	IORDY_EN	0x20	/* PIO: IOREADY */
-#define	PREFETCH_EN	0x10	/* PIO: PREFETCH */
-
-#define	PA3		0x08	/* PIO"A" timing */
-#define	PA2		0x04	/* PIO"A" timing */
-#define	PA1		0x02	/* PIO"A" timing */
-#define	PA0		0x01	/* PIO"A" timing */
-
-/* B Register */
-
-#define	MB2		0x80	/* DMA"B" timing */
-#define	MB1		0x40	/* DMA"B" timing */
-#define	MB0		0x20	/* DMA"B" timing */
-
-#define	PB4		0x10	/* PIO_FORCE 1:0 */
-
-#define	PB3		0x08	/* PIO"B" timing */	/* PIO flow Control mode */
-#define	PB2		0x04	/* PIO"B" timing */	/* PIO 4 */
-#define	PB1		0x02	/* PIO"B" timing */	/* PIO 3 half */
-#define	PB0		0x01	/* PIO"B" timing */	/* PIO 3 other half */
-
-/* C Register */
-#define	IORDYp_NO_SPEED	0x4F
-#define	SPEED_DIS	0x0F
-
-#define	DMARQp		0x80
-#define	IORDYp		0x40
-#define	DMAR_EN		0x20
-#define	DMAW_EN		0x10
-
-#define	MC3		0x08	/* DMA"C" timing */
-#define	MC2		0x04	/* DMA"C" timing */
-#define	MC1		0x02	/* DMA"C" timing */
-#define	MC0		0x01	/* DMA"C" timing */
-
-static int init_setup_pdc202ata4(struct pci_dev *dev, ide_pci_device_t *d);
-static int init_setup_pdc20265(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_pdc202xx(struct pci_dev *, ide_pci_device_t *);
-static unsigned int init_chipset_pdc202xx(struct pci_dev *, const char *);
-static void init_hwif_pdc202xx(ide_hwif_t *);
-static void init_dma_pdc202xx(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t pdc202xx_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "PDC20246",
-		.init_setup	= init_setup_pdc202ata4,
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-		.extra		= 16,
-	},{	/* 1 */
-		.name		= "PDC20262",
-		.init_setup	= init_setup_pdc202ata4,
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-		.extra		= 48,
-		.flags		= IDEPCI_FLAG_FORCE_PDC,
-	},{	/* 2 */
-		.name		= "PDC20263",
-		.init_setup	= init_setup_pdc202ata4,
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-		.extra		= 48,
-	},{	/* 3 */
-		.name		= "PDC20265",
-		.init_setup	= init_setup_pdc20265,
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-		.extra		= 48,
-		.flags		= IDEPCI_FLAG_FORCE_PDC,
-	},{	/* 4 */
-		.name		= "PDC20267",
-		.init_setup	= init_setup_pdc202xx,
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-		.extra		= 48,
-	}
-};
-
-#endif /* PDC202XX_H */
Index: linux-ide-export/drivers/ide/pci/piix.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/piix.c	2005-02-02 10:28:02.317669535 +0900
+++ linux-ide-export/drivers/ide/pci/piix.c	2005-02-02 10:28:02.676611297 +0900
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
Index: linux-ide-export/drivers/ide/pci/piix.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/piix.h	2005-02-02 10:28:02.317669535 +0900
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
Index: linux-ide-export/drivers/ide/pci/serverworks.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/serverworks.c	2005-02-02 10:27:16.182154650 +0900
+++ linux-ide-export/drivers/ide/pci/serverworks.c	2005-02-02 10:28:02.677611135 +0900
@@ -39,7 +39,20 @@
 
 #include <asm/io.h>
 
-#include "serverworks.h"
+#undef SVWKS_DEBUG_DRIVE_INFO
+
+#define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
+#define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
+
+/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
+ * can overrun their FIFOs when used with the CSB5 */
+static const char *svwks_bad_ata100[] = {
+	"ST320011A",
+	"ST340016A",
+	"ST360021A",
+	"ST380021A",
+	NULL
+};
 
 static u8 svwks_revision = 0;
 static struct pci_dev *isa_dev;
@@ -582,6 +595,48 @@ static int __init init_setup_csb6 (struc
 	return ide_setup_pci_device(dev, d);
 }
 
+/*
+ *	Table of the various serverworks capability blocks
+ */
+
+static ide_pci_device_t serverworks_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "SvrWks OSB4",
+		.init_setup	= init_setup_svwks,
+		.init_chipset	= init_chipset_svwks,
+		.init_hwif	= init_hwif_svwks,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 1 */
+		.name		= "SvrWks CSB5",
+		.init_setup	= init_setup_svwks,
+		.init_chipset	= init_chipset_svwks,
+		.init_hwif	= init_hwif_svwks,
+		.init_dma	= init_dma_svwks,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 2 */
+		.name		= "SvrWks CSB6",
+		.init_setup	= init_setup_csb6,
+		.init_chipset	= init_chipset_svwks,
+		.init_hwif	= init_hwif_svwks,
+		.init_dma	= init_dma_svwks,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 3 */
+		.name		= "SvrWks CSB6",
+		.init_setup	= init_setup_csb6,
+		.init_chipset	= init_chipset_svwks,
+		.init_hwif	= init_hwif_svwks,
+		.init_dma	= init_dma_svwks,
+		.channels	= 1,	/* 2 */
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	}
+};
 
 /**
  *	svwks_init_one	-	called when a OSB/CSB is found
Index: linux-ide-export/drivers/ide/pci/serverworks.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/serverworks.h	2005-02-02 10:27:16.183154488 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,69 +0,0 @@
-
-#ifndef SERVERWORKS_H
-#define SERVERWORKS_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#undef SVWKS_DEBUG_DRIVE_INFO
-
-#define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
-#define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
-
-/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
- * can overrun their FIFOs when used with the CSB5 */
-static const char *svwks_bad_ata100[] = {
-	"ST320011A",
-	"ST340016A",
-	"ST360021A",
-	"ST380021A",
-	NULL
-};
-
-static int init_setup_svwks(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_csb6(struct pci_dev *, ide_pci_device_t *);
-static unsigned int init_chipset_svwks(struct pci_dev *, const char *);
-static void init_hwif_svwks(ide_hwif_t *);
-static void init_dma_svwks(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t serverworks_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "SvrWks OSB4",
-		.init_setup	= init_setup_svwks,
-		.init_chipset	= init_chipset_svwks,
-		.init_hwif	= init_hwif_svwks,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "SvrWks CSB5",
-		.init_setup	= init_setup_svwks,
-		.init_chipset	= init_chipset_svwks,
-		.init_hwif	= init_hwif_svwks,
-		.init_dma	= init_dma_svwks,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 2 */
-		.name		= "SvrWks CSB6",
-		.init_setup	= init_setup_csb6,
-		.init_chipset	= init_chipset_svwks,
-		.init_hwif	= init_hwif_svwks,
-		.init_dma	= init_dma_svwks,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 3 */
-		.name		= "SvrWks CSB6",
-		.init_setup	= init_setup_csb6,
-		.init_chipset	= init_chipset_svwks,
-		.init_hwif	= init_hwif_svwks,
-		.init_dma	= init_dma_svwks,
-		.channels	= 1,	/* 2 */
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* SERVERWORKS_H */
