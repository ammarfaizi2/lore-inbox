Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267906AbTBRSFK>; Tue, 18 Feb 2003 13:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267986AbTBRSCp>; Tue, 18 Feb 2003 13:02:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31241 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267972AbTBRSAr>; Tue, 18 Feb 2003 13:00:47 -0500
Subject: PATCH: path/ide_ioreg_t fixes for legacy drivers
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:11:07 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCCx-00069P-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/buddha.c linux-2.5.61-ac2/drivers/ide/legacy/buddha.c
--- linux-2.5.61/drivers/ide/legacy/buddha.c	2003-02-10 18:38:20.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/buddha.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/buddha.c -- Amiga Buddha, Catweasel and X-Surf IDE Driver
+ *  linux/drivers/ide/legacy/buddha.c -- Amiga Buddha, Catweasel and X-Surf IDE Driver
  *
  *	Copyright (C) 1997, 2001 by Geert Uytterhoeven and others
  *
@@ -197,16 +197,16 @@
 		
 		for(i=0;i<buddha_num_hwifs;i++) {
 			if(type != BOARD_XSURF) {
-				ide_setup_ports(&hw, (ide_ioreg_t)(buddha_board+buddha_bases[i]),
+				ide_setup_ports(&hw, (buddha_board+buddha_bases[i]),
 						buddha_offsets, 0,
-						(ide_ioreg_t)(buddha_board+buddha_irqports[i]),
+						(buddha_board+buddha_irqports[i]),
 						buddha_ack_intr,
 //						budda_iops,
 						IRQ_AMIGA_PORTS);
 			} else {
-				ide_setup_ports(&hw, (ide_ioreg_t)(buddha_board+xsurf_bases[i]),
+				ide_setup_ports(&hw, (buddha_board+xsurf_bases[i]),
 						xsurf_offsets, 0,
-						(ide_ioreg_t)(buddha_board+xsurf_irqports[i]),
+						(buddha_board+xsurf_irqports[i]),
 						xsurf_ack_intr,
 //						xsurf_iops,
 						IRQ_AMIGA_PORTS);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/dtc2278.c linux-2.5.61-ac2/drivers/ide/legacy/dtc2278.c
--- linux-2.5.61/drivers/ide/legacy/dtc2278.c	2003-02-10 18:38:16.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/dtc2278.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/dtc2278.c		Version 0.02	Feb 10, 1996
+ *  linux/drivers/ide/legacy/dtc2278.c		Version 0.02	Feb 10, 1996
  *
  *  Copyright (C) 1996  Linus Torvalds & author (see below)
  */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/falconide.c linux-2.5.61-ac2/drivers/ide/legacy/falconide.c
--- linux-2.5.61/drivers/ide/legacy/falconide.c	2003-02-10 18:38:45.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/falconide.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/falconide.c -- Atari Falcon IDE Driver
+ *  linux/drivers/ide/legacy/falconide.c -- Atari Falcon IDE Driver
  *
  *     Created 12 Jul 1997 by Geert Uytterhoeven
  *
@@ -66,7 +66,7 @@
 	hw_regs_t hw;
 	int index;
 
-	ide_setup_ports(&hw, (ide_ioreg_t)ATA_HD_BASE, falconide_offsets,
+	ide_setup_ports(&hw, ATA_HD_BASE, falconide_offsets,
 			0, 0, NULL,
 //			falconide_iops,
 			IRQ_MFP_IDE);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/gayle.c linux-2.5.61-ac2/drivers/ide/legacy/gayle.c
--- linux-2.5.61/drivers/ide/legacy/gayle.c	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/gayle.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/gayle.c -- Amiga Gayle IDE Driver
+ *  linux/drivers/ide/legacy/gayle.c -- Amiga Gayle IDE Driver
  *
  *     Created 9 Jul 1997 by Geert Uytterhoeven
  *
@@ -122,7 +122,7 @@
 	return;
 
     for (i = 0; i < GAYLE_NUM_PROBE_HWIFS; i++) {
-	ide_ioreg_t base, ctrlport, irqport;
+	unsigned long base, ctrlport, irqport;
 	ide_ack_intr_t *ack_intr;
 	hw_regs_t hw;
 	int index;
@@ -130,11 +130,11 @@
 
 	if (a4000) {
 	    phys_base = GAYLE_BASE_4000;
-	    irqport = (ide_ioreg_t)ZTWO_VADDR(GAYLE_IRQ_4000);
+	    irqport = (unsigned long)ZTWO_VADDR(GAYLE_IRQ_4000);
 	    ack_intr = gayle_ack_intr_a4000;
 	} else {
 	    phys_base = GAYLE_BASE_1200;
-	    irqport = (ide_ioreg_t)ZTWO_VADDR(GAYLE_IRQ_1200);
+	    irqport = (unsigned long)ZTWO_VADDR(GAYLE_IRQ_1200);
 	    ack_intr = gayle_ack_intr_a1200;
 	}
 /*
@@ -149,7 +149,7 @@
 	if (!request_mem_region(res_start, res_n, "IDE"))
 	    continue;
 
-	base = (ide_ioreg_t)ZTWO_VADDR(phys_base);
+	base = (unsigned long)ZTWO_VADDR(phys_base);
 	ctrlport = GAYLE_HAS_CONTROL_REG ? (base + GAYLE_CONTROL) : 0;
 
 	ide_setup_ports(&hw, base, gayle_offsets,
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/ht6560b.c linux-2.5.61-ac2/drivers/ide/legacy/ht6560b.c
--- linux-2.5.61/drivers/ide/legacy/ht6560b.c	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/ht6560b.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/ht6560b.c		Version 0.07	Feb  1, 2000
+ *  linux/drivers/ide/legacy/ht6560b.c		Version 0.07	Feb  1, 2000
  *
  *  Copyright (C) 1995-2000  Linus Torvalds & author (see below)
  */
