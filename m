Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267874AbTBRSIE>; Tue, 18 Feb 2003 13:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267911AbTBRSGd>; Tue, 18 Feb 2003 13:06:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37129 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267966AbTBRSDz>; Tue, 18 Feb 2003 13:03:55 -0500
Subject: PATCH: fix path names and printks in IDE pci
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:14:05 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCFp-0006A8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/adma100.c linux-2.5.61-ac2/drivers/ide/pci/adma100.c
--- linux-2.5.61/drivers/ide/pci/adma100.c	2003-02-10 18:38:19.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/adma100.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/adma100.c -- basic support for Pacific Digital ADMA-100 boards
+ *  linux/drivers/ide/pci/adma100.c -- basic support for Pacific Digital ADMA-100 boards
  *
  *     Created 09 Apr 2002 by Mark Lord
  *
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/aec62xx.c linux-2.5.61-ac2/drivers/ide/pci/aec62xx.c
--- linux-2.5.61/drivers/ide/pci/aec62xx.c	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/aec62xx.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/aec62xx.c		Version 0.11	March 27, 2002
+ * linux/drivers/ide/pci/aec62xx.c		Version 0.11	March 27, 2002
  *
  * Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
  *
@@ -409,7 +409,7 @@
 
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk("%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 #if defined(DISPLAY_AEC62XX_TIMINGS) && defined(CONFIG_PROC_FS)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/cmd640.c linux-2.5.61-ac2/drivers/ide/pci/cmd640.c
--- linux-2.5.61/drivers/ide/pci/cmd640.c	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/cmd640.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/cmd640.c		Version 1.02  Sep 01, 1996
+ *  linux/drivers/ide/pci/cmd640.c		Version 1.02  Sep 01, 1996
  *
  *  Copyright (C) 1995-1996  Linus Torvalds & authors (see below)
  */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/cmd64x.c linux-2.5.61-ac2/drivers/ide/pci/cmd64x.c
--- linux-2.5.61/drivers/ide/pci/cmd64x.c	2003-02-10 18:38:52.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/cmd64x.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,6 +1,6 @@
 /* $Id: cmd64x.c,v 1.21 2000/01/30 23:23:16
  *
- * linux/drivers/ide/cmd64x.c		Version 1.30	Sept 10, 2002
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.30	Sept 10, 2002
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Note, this driver is not used at all on other systems because
@@ -596,7 +596,7 @@
 #ifdef __i386__
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_byte(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk("%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 #endif
 
@@ -604,7 +604,7 @@
 		case PCI_DEVICE_ID_CMD_643:
 			break;
 		case PCI_DEVICE_ID_CMD_646:
-			printk("%s: chipset revision 0x%02X, ", name, class_rev);
+			printk(KERN_INFO "%s: chipset revision 0x%02X, ", name, class_rev);
 			switch(class_rev) {
 				case 0x07:
 				case 0x05:
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/cs5530.c linux-2.5.61-ac2/drivers/ide/pci/cs5530.c
--- linux-2.5.61/drivers/ide/pci/cs5530.c	2003-02-10 18:38:19.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/cs5530.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/cs5530.c		Version 0.7	Sept 10, 2002
+ * linux/drivers/ide/pci/cs5530.c		Version 0.7	Sept 10, 2002
  *
  * Copyright (C) 2000			Andre Hedrick <andre@linux-ide.org>
  * Ditto of GNU General Public License.
@@ -9,6 +9,9 @@
  *
  * Development of this chipset driver was funded
  * by the nice folks at National Semiconductor.
+ *
+ * Documentation:
+ *	CS5530 documentation available from National Semiconductor.
  */
 
 #include <linux/config.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/hpt34x.c linux-2.5.61-ac2/drivers/ide/pci/hpt34x.c
--- linux-2.5.61/drivers/ide/pci/hpt34x.c	2003-02-10 18:38:20.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/hpt34x.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/hpt34x.c		Version 0.40	Sept 10, 2002
+ * linux/drivers/ide/pci/hpt34x.c		Version 0.40	Sept 10, 2002
  *
  * Copyright (C) 1998-2000	Andre Hedrick <andre@linux-ide.org>
  * May be copied or modified under the terms of the GNU General Public License
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/ns87415.c linux-2.5.61-ac2/drivers/ide/pci/ns87415.c
--- linux-2.5.61/drivers/ide/pci/ns87415.c	2003-02-10 18:38:30.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/ns87415.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/ns87415.c		Version 2.00  Sep. 10, 2002
+ * linux/drivers/ide/pci/ns87415.c		Version 2.00  Sep. 10, 2002
  *
  * Copyright (C) 1997-1998	Mark Lord <mlord@pobox.com>
  * Copyright (C) 1998		Eddie C. Dost <ecd@skynet.be>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/opti621.c linux-2.5.61-ac2/drivers/ide/pci/opti621.c
--- linux-2.5.61/drivers/ide/pci/opti621.c	2003-02-10 18:38:20.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/opti621.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/opti621.c		Version 0.7	Sept 10, 2002
+ *  linux/drivers/ide/pci/opti621.c		Version 0.7	Sept 10, 2002
  *
  *  Copyright (C) 1996-1998  Linus Torvalds & authors (see below)
  */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/pdc202xx_new.c linux-2.5.61-ac2/drivers/ide/pci/pdc202xx_new.c
--- linux-2.5.61/drivers/ide/pci/pdc202xx_new.c	2003-02-10 18:38:48.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/pdc202xx_new.c	2003-02-18 18:06:19.000000000 +0000
@@ -224,7 +224,7 @@
 	decode_registers(REG_D, DP);
 #endif /* PDC202XX_DECODE_REGISTER_INFO */
 #if PDC202XX_DEBUG_DRIVE_INFO
-	printk("%s: %s drive%d 0x%08x ",
+	printk(KERN_DEBUG "%s: %s drive%d 0x%08x ",
 		drive->name, ide_xfer_verbose(speed),
 		drive->dn, drive_conf);
 		pci_read_config_dword(dev, drive_pci, &drive_conf);
@@ -321,7 +321,7 @@
 		case PCI_DEVICE_ID_PROMISE_20268:
 			cable = pdcnew_new_cable_detect(hwif);
 #if PDC202_DEBUG_CABLE
-			printk("%s: %s-pin cable, %s-pin cable, %d\n",
+			printk(KERN_DEBUG "%s: %s-pin cable, %s-pin cable, %d\n",
 				hwif->name, hwif->udma_four ? "80" : "40",
 				cable ? "40" : "80", cable);
 #endif /* PDC202_DEBUG_CABLE */
@@ -347,15 +347,15 @@
 
 	if ((ultra_66) && (cable)) {
 #ifdef DEBUG
-		printk("ULTRA 66/100/133: %s channel of Ultra 66/100/133 "
+		printk(KERN_DEBUG "ULTRA 66/100/133: %s channel of Ultra 66/100/133 "
 			"requires an 80-pin cable for Ultra66 operation.\n",
 			hwif->channel ? "Secondary" : "Primary");
-		printk("         Switching to Ultra33 mode.\n");
+		printk(KERN_DEBUG "         Switching to Ultra33 mode.\n");
 #endif /* DEBUG */
 		/* Primary   : zero out second bit */
 		/* Secondary : zero out fourth bit */
-		printk("Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
-		printk("%s reduced to Ultra33 mode.\n", drive->name);
+		printk(KERN_WARNING "Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
+		printk(KERN_WARNING "%s reduced to Ultra33 mode.\n", drive->name);
 	}
 
 	if (drive->media != ide_disk)
@@ -444,7 +444,7 @@
 	/*
 	 * Deleted this because it is redundant from the caller.
 	 */
-	printk("PDC202XX: %s channel reset.\n",
+	printk(KERN_WARNING "PDC202XX: %s channel reset.\n",
 		HWIF(drive)->channel ? "Secondary" : "Primary");
 }
 
@@ -459,7 +459,7 @@
 	hwif->OUTB((udma_speed_flag & ~0x10), (high_16|0x001f));
 	mdelay(2000);	/* 2 seconds ?! */
 
-	printk("PDC202XX: %s channel reset.\n",
+	printk(KERN_WARNING "PDC202XX: %s channel reset.\n",
 		hwif->channel ? "Secondary" : "Primary");
 }
 
@@ -513,7 +513,7 @@
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk("%s: ROM enabled at 0x%08lx\n",
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
 			name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
@@ -555,7 +555,7 @@
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
 #if PDC202_DEBUG_CABLE
-	printk("%s: %s-pin cable\n",
+	printk(KERN_DEBUG "%s: %s-pin cable\n",
 		hwif->name, hwif->udma_four ? "80" : "40");
 #endif /* PDC202_DEBUG_CABLE */
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/pdc202xx_old.c linux-2.5.61-ac2/drivers/ide/pci/pdc202xx_old.c
--- linux-2.5.61/drivers/ide/pci/pdc202xx_old.c	2003-02-10 18:38:56.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/pdc202xx_old.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pdc202xx.c	Version 0.36	Sept 11, 2002
+ *  linux/drivers/ide/pci/pdc202xx_old.c	Version 0.36	Sept 11, 2002
  *
  *  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org>
  *
@@ -323,7 +323,7 @@
 	decode_registers(REG_D, DP);
 #endif /* PDC202XX_DECODE_REGISTER_INFO */
 #if PDC202XX_DEBUG_DRIVE_INFO
-	printk("%s: %s drive%d 0x%08x ",
+	printk(KERN_DEBUG "%s: %s drive%d 0x%08x ",
 		drive->name, ide_xfer_verbose(speed),
 		drive->dn, drive_conf);
 		pci_read_config_dword(dev, drive_pci, &drive_conf);
@@ -379,7 +379,7 @@
 		case PCI_DEVICE_ID_PROMISE_20262:
 			cable = pdc202xx_old_cable_detect(hwif);
 #if PDC202_DEBUG_CABLE
-			printk("%s: %s-pin cable, %s-pin cable, %d\n",
+			printk(KERN_DEBUG "%s: %s-pin cable, %s-pin cable, %d\n",
 				hwif->name, hwif->udma_four ? "80" : "40",
 				cable ? "40" : "80", cable);
 #endif /* PDC202_DEBUG_CABLE */
@@ -408,16 +408,16 @@
 
 	if ((ultra_66) && (cable)) {
 #ifdef DEBUG
-		printk("ULTRA 66/100/133: %s channel of Ultra 66/100/133 "
+		printk(KERN_DEBUG "ULTRA 66/100/133: %s channel of Ultra 66/100/133 "
 			"requires an 80-pin cable for Ultra66 operation.\n",
 			hwif->channel ? "Secondary" : "Primary");
-		printk("         Switching to Ultra33 mode.\n");
+		printk(KERN_DEBUG "         Switching to Ultra33 mode.\n");
 #endif /* DEBUG */
 		/* Primary   : zero out second bit */
 		/* Secondary : zero out fourth bit */
 		hwif->OUTB(CLKSPD & ~mask, (hwif->dma_master + 0x11));
-		printk("Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
-		printk("%s reduced to Ultra33 mode.\n", drive->name);
+		printk(KERN_WARNING "Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
+		printk(KERN_WARNING "%s reduced to Ultra33 mode.\n", drive->name);
 	} else {
 		if (ultra_66) {
 			/*
@@ -620,7 +620,7 @@
 	hwif->OUTB((udma_speed_flag & ~0x10), (high_16|0x001f));
 	mdelay(2000);	/* 2 seconds ?! */
 
-	printk("PDC202XX: %s channel reset.\n",
+	printk(KERN_WARNING "PDC202XX: %s channel reset.\n",
 		hwif->channel ? "Secondary" : "Primary");
 }
 
@@ -699,7 +699,7 @@
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk("%s: ROM enabled at 0x%08lx\n",
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
 			name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
@@ -780,7 +780,7 @@
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
 #if PDC202_DEBUG_CABLE
-	printk("%s: %s-pin cable\n",
+	printk(KERN_DEBUG "%s: %s-pin cable\n",
 		hwif->name, hwif->udma_four ? "80" : "40");
 #endif /* PDC202_DEBUG_CABLE */	
 }
@@ -797,7 +797,7 @@
 	udma_speed_flag	= hwif->INB((dmabase|0x1f));
 	primary_mode	= hwif->INB((dmabase|0x1a));
 	secondary_mode	= hwif->INB((dmabase|0x1b));
-	printk("%s: (U)DMA Burst Bit %sABLED " \
+	printk(KERN_INFO "%s: (U)DMA Burst Bit %sABLED " \
 		"Primary %s Mode " \
 		"Secondary %s Mode.\n", hwif->cds->name,
 		(udma_speed_flag & 1) ? "EN" : "DIS",
@@ -806,7 +806,7 @@
 
 #ifdef CONFIG_PDC202XX_BURST
 	if (!(udma_speed_flag & 1)) {
-		printk("%s: FORCING BURST BIT 0x%02x->0x%02x ",
+		printk(KERN_INFO "%s: FORCING BURST BIT 0x%02x->0x%02x ",
 			hwif->cds->name, udma_speed_flag,
 			(udma_speed_flag|1));
 		hwif->OUTB(udma_speed_flag|1,(dmabase|0x1f));
@@ -816,7 +816,7 @@
 #endif /* CONFIG_PDC202XX_BURST */
 #ifdef CONFIG_PDC202XX_MASTER
 	if (!(primary_mode & 1)) {
-		printk("%s: FORCING PRIMARY MODE BIT "
+		printk(KERN_INFO "%s: FORCING PRIMARY MODE BIT "
 			"0x%02x -> 0x%02x ", hwif->cds->name,
 			primary_mode, (primary_mode|1));
 		hwif->OUTB(primary_mode|1, (dmabase|0x1a));
@@ -825,7 +825,7 @@
 	}
 
 	if (!(secondary_mode & 1)) {
-		printk("%s: FORCING SECONDARY MODE BIT "
+		printk(KERN_INFO "%s: FORCING SECONDARY MODE BIT "
 			"0x%02x -> 0x%02x ", hwif->cds->name,
 			secondary_mode, (secondary_mode|1));
 		hwif->OUTB(secondary_mode|1, (dmabase|0x1b));
@@ -850,7 +850,7 @@
 		if (irq != irq2) {
 			pci_write_config_byte(dev,
 				(PCI_INTERRUPT_LINE)|0x80, irq);     /* 0xbc */
-			printk("%s: pci-config space interrupt "
+			printk(KERN_INFO "%s: pci-config space interrupt "
 				"mirror fixed.\n", d->name);
 		}
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/pdcadma.c linux-2.5.61-ac2/drivers/ide/pci/pdcadma.c
--- linux-2.5.61/drivers/ide/pci/pdcadma.c	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/pdcadma.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pdcadma.c		Version 0.05	Sept 10, 2002
+ * linux/drivers/ide/pci/pdcadma.c		Version 0.05	Sept 10, 2002
  *
  * Copyright (C) 1999-2000		Andre Hedrick <andre@linux-ide.org>
  * May be copied or modified under the terms of the GNU General Public License
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/piix.c linux-2.5.61-ac2/drivers/ide/pci/piix.c
--- linux-2.5.61/drivers/ide/pci/piix.c	2003-02-10 18:37:57.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/piix.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/piix.c		Version 0.42	January 11, 2003
+ *  linux/drivers/ide/pci/piix.c	Version 0.42	January 11, 2003
  *
  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/rz1000.c linux-2.5.61-ac2/drivers/ide/pci/rz1000.c
--- linux-2.5.61/drivers/ide/pci/rz1000.c	2003-02-10 18:38:19.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/rz1000.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/rz1000.c		Version 0.05	December 8, 1997
+ *  linux/drivers/ide/pci/rz1000.c	Version 0.06	January 12, 2003
  *
  *  Copyright (C) 1995-1998  Linus Torvalds & author (see below)
  */
@@ -43,13 +43,13 @@
 	hwif->chipset = ide_rz1000;
 	if (!pci_read_config_word (dev, 0x40, &reg) &&
 	    !pci_write_config_word(dev, 0x40, reg & 0xdfff)) {
-		printk("%s: disabled chipset read-ahead "
+		printk(KERN_INFO "%s: disabled chipset read-ahead "
 			"(buggy RZ1000/RZ1001)\n", hwif->name);
 	} else {
 		hwif->serialized = 1;
 		hwif->drives[0].no_unmask = 1;
 		hwif->drives[1].no_unmask = 1;
-		printk("%s: serialized, disabled unmasking "
+		printk(KERN_INFO "%s: serialized, disabled unmasking "
 			"(buggy RZ1000/RZ1001)\n", hwif->name);
 	}
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/sc1200.c linux-2.5.61-ac2/drivers/ide/pci/sc1200.c
--- linux-2.5.61/drivers/ide/pci/sc1200.c	2003-02-10 18:38:43.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/sc1200.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,11 +1,14 @@
 /*
- * linux/drivers/ide/sc1200.c		Version 0.9	24-Oct-2002
+ * linux/drivers/ide/pci/sc1200.c		Version 0.91	28-Jan-2003
  *
  * Copyright (C) 2000-2002		Mark Lord <mlord@pobox.com>
  * May be copied or modified under the terms of the GNU General Public License
  *
  * Development of this chipset driver was funded
  * by the nice folks at National Semiconductor.
+ *
+ * Documentation:
+ *	Available from National Semiconductor
  */
 
 #include <linux/config.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/serverworks.c linux-2.5.61-ac2/drivers/ide/pci/serverworks.c
--- linux-2.5.61/drivers/ide/pci/serverworks.c	2003-02-10 18:37:57.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/serverworks.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/serverworks.c		Version 0.7	10 Sept 2002
+ * linux/drivers/ide/pci/serverworks.c		Version 0.7	10 Sept 2002
  *
  * Copyright (C) 1998-2000 Michel Aubry
  * Copyright (C) 1998-2000 Andrzej Krzysztofowicz
@@ -21,6 +21,9 @@
  *
  *   CSB6: `Champion South Bridge' IDE Interface (optional: third channel)
  *
+ * Documentation:
+ *	Available under NDA only. Errata info very hard to get.
+ *
  */
 
 #include <linux/config.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/slc90e66.c linux-2.5.61-ac2/drivers/ide/pci/slc90e66.c
--- linux-2.5.61/drivers/ide/pci/slc90e66.c	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/slc90e66.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/slc90e66.c	Version 0.11	September 11, 2002
+ *  linux/drivers/ide/pci/slc90e66.c	Version 0.11	September 11, 2002
  *
  *  Copyright (C) 2000-2002 Andre Hedrick <andre@linux-ide.org>
  *
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/trm290.c linux-2.5.61-ac2/drivers/ide/pci/trm290.c
--- linux-2.5.61/drivers/ide/pci/trm290.c	2003-02-10 18:38:03.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/trm290.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/trm290.c		Version 1.02	Mar. 18, 2000
+ *  linux/drivers/ide/pci/trm290.c		Version 1.02	Mar. 18, 2000
  *
  *  Copyright (c) 1997-1998  Mark Lord
  *  May be copied or modified under the terms of the GNU General Public License
@@ -176,6 +176,7 @@
 	trm290_prepare_drive(drive, drive->using_dma);
 }
 
+#ifdef CONFIG_BLK_DEV_IDEDMA
 static int trm290_ide_dma_write (ide_drive_t *drive /*, struct request *rq */)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -296,6 +297,7 @@
 	status = hwif->INW(hwif->dma_status);
 	return (status == 0x00ff);
 }
+#endif /* CONFIG_BLK_DEV_IDEDMA */
 
 /*
  * Invoked from ide-dma.c at boot time.
@@ -342,11 +344,13 @@
 
 	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->channel ? 0x0080 : 0x0000), 3);
 
+#ifdef CONFIG_BLK_DEV_IDEDMA
 	hwif->ide_dma_write = &trm290_ide_dma_write;
 	hwif->ide_dma_read = &trm290_ide_dma_read;
 	hwif->ide_dma_begin = &trm290_ide_dma_begin;
 	hwif->ide_dma_end = &trm290_ide_dma_end;
 	hwif->ide_dma_test_irq = &trm290_ide_dma_test_irq;
+#endif /* CONFIG_BLK_DEV_IDEDMA */
 
 	hwif->selectproc = &trm290_selectproc;
 	hwif->autodma = 0;		/* play it safe for now */
