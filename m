Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264161AbUECXgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbUECXgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUECXgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:36:08 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11661 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264154AbUECXfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:35:40 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] remove dead drivers/ide/ppc/swarm.c
Date: Tue, 4 May 2004 01:34:22 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405040134.22092.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This driver was merged in 2.5.32 but depends on <asm/sibyte/swarm_ide.h>
which hasn't been merged in 2.5.  Additionally it is a MIPS specific driver
so it should be in drivers/ide/mips/ if somebody ever decides to re-add it.

 linux-2.6.6-rc3-bk2-bzolnier/drivers/ide/Kconfig  |    4 
 linux-2.6.6-rc3-bk2-bzolnier/drivers/ide/Makefile |    1 
 linux-2.6.6-rc3-bk2-bzolnier/drivers/ide/ide.c    |    6 -
 linux-2.6.6-rc3-bk2/drivers/ide/ppc/swarm.c       |  101 ----------------------
 4 files changed, 112 deletions(-)

diff -puN drivers/ide/ide.c~ide_swarm drivers/ide/ide.c
--- linux-2.6.6-rc3-bk2/drivers/ide/ide.c~ide_swarm	2004-05-04 01:32:48.841860272 +0200
+++ linux-2.6.6-rc3-bk2-bzolnier/drivers/ide/ide.c	2004-05-04 01:32:48.861857232 +0200
@@ -2090,12 +2090,6 @@ static void __init probe_for_hwifs (void
 		pmac_ide_probe();
 	}
 #endif /* CONFIG_BLK_DEV_IDE_PMAC */
-#ifdef CONFIG_BLK_DEV_IDE_SWARM
-	{
-		extern void swarm_ide_probe(void);
-		swarm_ide_probe();
-	}
-#endif /* CONFIG_BLK_DEV_IDE_SWARM */
 #ifdef CONFIG_BLK_DEV_GAYLE
 	{
 		extern void gayle_init(void);
diff -puN drivers/ide/Kconfig~ide_swarm drivers/ide/Kconfig
--- linux-2.6.6-rc3-bk2/drivers/ide/Kconfig~ide_swarm	2004-05-04 01:32:48.848859208 +0200
+++ linux-2.6.6-rc3-bk2-bzolnier/drivers/ide/Kconfig	2004-05-04 01:32:48.863856928 +0200
@@ -851,10 +851,6 @@ config BLK_DEV_IDEDMA_PMAC_AUTO
 	  hardware may have caused damage.  Saying Y should be safe on all
 	  Apple machines.
 
-config BLK_DEV_IDE_SWARM
-	bool "SWARM onboard IDE support"
-	depends on SIBYTE_SWARM
-
 config BLK_DEV_IDE_ICSIDE
 	tristate "ICS IDE interface support"
 	depends on ARM && ARCH_ACORN
diff -puN drivers/ide/Makefile~ide_swarm drivers/ide/Makefile
--- linux-2.6.6-rc3-bk2/drivers/ide/Makefile~ide_swarm	2004-05-04 01:32:48.853858448 +0200
+++ linux-2.6.6-rc3-bk2-bzolnier/drivers/ide/Makefile	2004-05-04 01:32:48.864856776 +0200
@@ -36,7 +36,6 @@ ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= leg
 # built-in only drivers from ppc/
 ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= ppc/mpc8xx.o
 ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ppc/pmac.o
-ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)	+= ppc/swarm.o
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
diff -puN -L drivers/ide/ppc/swarm.c drivers/ide/ppc/swarm.c~ide_swarm /dev/null
--- linux-2.6.6-rc3-bk2/drivers/ide/ppc/swarm.c
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,101 +0,0 @@
-/*
- * Copyright (C) 2001 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- */
-
-/*  Derived loosely from ide-pmac.c, so:
- *  
- *  Copyright (C) 1998 Paul Mackerras.
- *  Copyright (C) 1995-1998 Mark Lord
- */
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/ide.h>
-#include <asm/irq.h>
-#include <asm/io.h>
-#include <asm/sibyte/sb1250_int.h>
-
-#define __IDE_SWARM_C
-
-#include <asm/sibyte/swarm_ide.h>
-
-void __init swarm_ide_probe(void)
-{
-	int i;
-	ide_hwif_t *hwif;
-	/* 
-	 * Find the first untaken slot in hwifs 
-	 */
-	for (i = 0; i < MAX_HWIFS; i++) {
-		if (!ide_hwifs[i].io_ports[IDE_DATA_OFFSET]) {
-			break;
-		}
-	}
-	if (i == MAX_HWIFS) {
-		printk("No space for SWARM onboard IDE driver in ide_hwifs[].  Not enabled.\n");
-		return;
-	}
-
-	/* Set up our stuff */
-	hwif = &ide_hwifs[i];
-	hwif->hw.io_ports[IDE_DATA_OFFSET]    = SWARM_IDE_REG(0x1f0);
-	hwif->hw.io_ports[IDE_ERROR_OFFSET]   = SWARM_IDE_REG(0x1f1);
-	hwif->hw.io_ports[IDE_NSECTOR_OFFSET] = SWARM_IDE_REG(0x1f2);
-	hwif->hw.io_ports[IDE_SECTOR_OFFSET]  = SWARM_IDE_REG(0x1f3);
-	hwif->hw.io_ports[IDE_LCYL_OFFSET]    = SWARM_IDE_REG(0x1f4);
-	hwif->hw.io_ports[IDE_HCYL_OFFSET]    = SWARM_IDE_REG(0x1f5);
-	hwif->hw.io_ports[IDE_SELECT_OFFSET]  = SWARM_IDE_REG(0x1f6);
-	hwif->hw.io_ports[IDE_STATUS_OFFSET]  = SWARM_IDE_REG(0x1f7);
-	hwif->hw.io_ports[IDE_CONTROL_OFFSET] = SWARM_IDE_REG(0x3f6);
-	hwif->hw.io_ports[IDE_IRQ_OFFSET]     = SWARM_IDE_REG(0x3f7);
-//	hwif->hw->ack_intr                    = swarm_ide_ack_intr;
-	hwif->hw.irq                          = SWARM_IDE_INT;
-#if 0
-	hwif->iops                            = swarm_iops;
-#else
-	hwif->OUTB      = hwif->OUTBP         = swarm_outb;
-	hwif->OUTW      = hwif->OUTWP         = swarm_outw;
-	hwif->OUTL      = hwif->OUTLP         = swarm_outl;
-	hwif->OUTSW     = hwif->OUTSWP        = swarm_outsw;
-	hwif->OUTSL     = hwif->OUTSLP        = swarm_outsl;
-	hwif->INB       = hwif->INBP          = swarm_inb;
-	hwif->INW       = hwif->INWP          = swarm_inw;
-	hwif->INL       = hwif->INLP          = swarm_inl;
-	hwif->INSW      = hwif->INSWP         = swarm_insw;
-	hwif->INSL      = hwif->INSLP         = swarm_insl;
-#endif
-#if 0
-	hwif->pioops                          = swarm_pio_ops;
-#else
-	hwif->ata_input_data                  = swarm_ata_input_data;
-	hwif->ata_output_data                 = swarm_ata_output_data;
-	hwif->atapi_input_bytes               = swarm_atapi_input_bytes;
-	hwif->atapi_output_bytes              = swarm_atapi_output_bytes;
-#endif
-	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
-	hwif->irq                             = hwif->hw.irq;
-	printk("SWARM onboard IDE configured as device %i\n", i);
-
-#ifndef HWIF_PROBE_CLASSIC_METHOD
-	probe_hwif_init(hwif->index);
-#endif /* HWIF_PROBE_CLASSIC_METHOD */
-
-}
-

_

