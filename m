Return-Path: <linux-kernel-owner+w=401wt.eu-S932112AbXADSyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbXADSyZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbXADSyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:54:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2923 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932086AbXADSx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:53:56 -0500
Date: Thu, 4 Jan 2007 19:53:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] remove the broken SCSI_AMIGA7XX driver
Message-ID: <20070104185359.GJ20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SCSI_AMIGA7XX driver:
- has been marked as BROKEN for more than two years and
- is still marked as BROKEN.

Drivers that had been marked as BROKEN for such a long time seem to be
unlikely to be revived in the forseeable future.

But if anyone wants to ever revive this driver, the code is still
present in the older kernel releases.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/Kconfig    |   21 ------
 drivers/scsi/Makefile   |    1 
 drivers/scsi/amiga7xx.c |  139 ----------------------------------------
 drivers/scsi/amiga7xx.h |   23 ------
 4 files changed, 1 insertion(+), 183 deletions(-)

--- linux-2.6.20-rc2-mm1/drivers/scsi/Kconfig.old	2007-01-04 19:16:49.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/scsi/Kconfig	2007-01-04 19:29:19.000000000 +0100
@@ -1609,25 +1609,6 @@
 	  If you have the Phase5 Fastlane Z3 SCSI controller, or plan to use
 	  one in the near future, say Y to this question. Otherwise, say N.
 
-config SCSI_AMIGA7XX
-	bool "Amiga NCR53c710 SCSI support (EXPERIMENTAL)"
-	depends on AMIGA && SCSI && EXPERIMENTAL && BROKEN
-	help
-	  Support for various NCR53c710-based SCSI controllers on the Amiga.
-	  This includes:
-	    - the builtin SCSI controller on the Amiga 4000T,
-	    - the Amiga 4091 Zorro III SCSI-2 controller,
-	    - the MacroSystem Development's WarpEngine Amiga SCSI-2 controller
-	      (info at
-	      <http://www.lysator.liu.se/amiga/ar/guide/ar310.guide?FEATURE5>),
-	    - the SCSI controller on the Phase5 Blizzard PowerUP 603e+
-	      accelerator card for the Amiga 1200,
-	    - the SCSI controller on the GVP Turbo 040/060 accelerator.
-	  Note that all of the above SCSI controllers, except for the builtin
-	  SCSI controller on the Amiga 4000T, reside on the Zorro expansion
-	  bus, so you also have to enable Zorro bus support if you want to use
-	  them.
-
 config OKTAGON_SCSI
 	tristate "BSC Oktagon SCSI support (EXPERIMENTAL)"
 	depends on ZORRO && SCSI && EXPERIMENTAL
@@ -1729,7 +1710,7 @@
 
 config SCSI_NCR53C7xx_FAST
 	bool "allow FAST-SCSI [10MHz]"
-	depends on SCSI_AMIGA7XX || MVME16x_SCSI || BVME6000_SCSI
+	depends on MVME16x_SCSI || BVME6000_SCSI
 	help
 	  This will enable 10MHz FAST-SCSI transfers with your host
 	  adapter. Some systems have problems with that speed, so it's safest
--- linux-2.6.20-rc2-mm1/drivers/scsi/Makefile.old	2007-01-04 19:29:27.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/scsi/Makefile	2007-01-04 19:29:47.000000000 +0100
@@ -37,7 +37,6 @@
 
 obj-$(CONFIG_ISCSI_TCP) 	+= libiscsi.o	iscsi_tcp.o
 obj-$(CONFIG_INFINIBAND_ISER) 	+= libiscsi.o
-obj-$(CONFIG_SCSI_AMIGA7XX)	+= amiga7xx.o	53c7xx.o
 obj-$(CONFIG_A3000_SCSI)	+= a3000.o	wd33c93.o
 obj-$(CONFIG_A2091_SCSI)	+= a2091.o	wd33c93.o
 obj-$(CONFIG_GVP11_SCSI)	+= gvp11.o	wd33c93.o
--- linux-2.6.20-rc2-mm1/drivers/scsi/amiga7xx.h	2006-11-29 22:57:37.000000000 +0100
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,23 +0,0 @@
-#ifndef AMIGA7XX_H
-
-#include <linux/types.h>
-
-int amiga7xx_detect(struct scsi_host_template *);
-const char *NCR53c7x0_info(void);
-int NCR53c7xx_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int NCR53c7xx_abort(Scsi_Cmnd *);
-int NCR53c7x0_release (struct Scsi_Host *);
-int NCR53c7xx_reset(Scsi_Cmnd *, unsigned int);
-void NCR53c7x0_intr(int irq, void *dev_id);
-
-#ifndef CMD_PER_LUN
-#define CMD_PER_LUN 3
-#endif
-
-#ifndef CAN_QUEUE
-#define CAN_QUEUE 24
-#endif
-
-#include <scsi/scsicam.h>
-
-#endif /* AMIGA7XX_H */
--- linux-2.6.20-rc2-mm1/drivers/scsi/amiga7xx.c	2006-11-29 22:57:37.000000000 +0100
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,139 +0,0 @@
-/*
- * Detection routine for the NCR53c710 based Amiga SCSI Controllers for Linux.
- *		Amiga MacroSystemUS WarpEngine SCSI controller.
- *		Amiga Technologies A4000T SCSI controller.
- *		Amiga Technologies/DKB A4091 SCSI controller.
- *
- * Written 1997 by Alan Hourihane <alanh@fairlite.demon.co.uk>
- * plus modifications of the 53c7xx.c driver to support the Amiga.
- */
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/blkdev.h>
-#include <linux/sched.h>
-#include <linux/zorro.h>
-#include <linux/stat.h>
-
-#include <asm/setup.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/amigaints.h>
-#include <asm/amigahw.h>
-#include <asm/dma.h>
-#include <asm/irq.h>
-
-#include "scsi.h"
-#include <scsi/scsi_host.h>
-#include "53c7xx.h"
-#include "amiga7xx.h"
-
-
-static int amiga7xx_register_one(struct scsi_host_template *tpnt,
-				 unsigned long address)
-{
-    long long options;
-    int clock;
-
-    if (!request_mem_region(address, 0x1000, "ncr53c710"))
-	return 0;
-
-    address = (unsigned long)z_ioremap(address, 0x1000);
-    options = OPTION_MEMORY_MAPPED | OPTION_DEBUG_TEST1 | OPTION_INTFLY |
-	      OPTION_SYNCHRONOUS | OPTION_ALWAYS_SYNCHRONOUS |
-	      OPTION_DISCONNECT;
-    clock = 50000000;	/* 50 MHz SCSI Clock */
-    ncr53c7xx_init(tpnt, 0, 710, address, 0, IRQ_AMIGA_PORTS, DMA_NONE,
-		   options, clock);
-    return 1;
-}
-
-
-#ifdef CONFIG_ZORRO
-
-static struct {
-    zorro_id id;
-    unsigned long offset;
-    int absolute;	/* offset is absolute address */
-} amiga7xx_table[] = {
-    { .id = ZORRO_PROD_PHASE5_BLIZZARD_603E_PLUS, .offset = 0xf40000,
-      .absolute = 1 },
-    { .id = ZORRO_PROD_MACROSYSTEMS_WARP_ENGINE_40xx, .offset = 0x40000 },
-    { .id = ZORRO_PROD_CBM_A4091_1, .offset = 0x800000 },
-    { .id = ZORRO_PROD_CBM_A4091_2, .offset = 0x800000 },
-    { .id = ZORRO_PROD_GVP_GFORCE_040_060, .offset = 0x40000 },
-    { 0 }
-};
-
-static int __init amiga7xx_zorro_detect(struct scsi_host_template *tpnt)
-{
-    int num = 0, i;
-    struct zorro_dev *z = NULL;
-    unsigned long address;
-
-    while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
-	for (i = 0; amiga7xx_table[i].id; i++)
-	    if (z->id == amiga7xx_table[i].id)
-		break;
-	if (!amiga7xx_table[i].id)
-	    continue;
-	if (amiga7xx_table[i].absolute)
-	    address = amiga7xx_table[i].offset;
-	else
-	    address = z->resource.start + amiga7xx_table[i].offset;
-	num += amiga7xx_register_one(tpnt, address);
-    }
-    return num;
-}
-
-#endif /* CONFIG_ZORRO */
-
-
-int __init amiga7xx_detect(struct scsi_host_template *tpnt)
-{
-    static unsigned char called = 0;
-    int num = 0;
-
-    if (called || !MACH_IS_AMIGA)
-	return 0;
-
-    tpnt->proc_name = "Amiga7xx";
-
-    if (AMIGAHW_PRESENT(A4000_SCSI))
-	num += amiga7xx_register_one(tpnt, 0xdd0040);
-
-#ifdef CONFIG_ZORRO
-    num += amiga7xx_zorro_detect(tpnt);
-#endif
-
-    called = 1;
-    return num;
-}
-
-static int amiga7xx_release(struct Scsi_Host *shost)
-{
-	if (shost->irq)
-		free_irq(shost->irq, NULL);
-	if (shost->dma_channel != 0xff)
-		free_dma(shost->dma_channel);
-	if (shost->io_port && shost->n_io_port)
-		release_region(shost->io_port, shost->n_io_port);
-	scsi_unregister(shost);
-	return 0;
-}
-
-static struct scsi_host_template driver_template = {
-	.name			= "Amiga NCR53c710 SCSI",
-	.detect			= amiga7xx_detect,
-	.release		= amiga7xx_release,
-	.queuecommand		= NCR53c7xx_queue_command,
-	.abort			= NCR53c7xx_abort,
-	.reset			= NCR53c7xx_reset,
-	.can_queue		= 24,
-	.this_id		= 7,
-	.sg_tablesize		= 63,
-	.cmd_per_lun		= 3,
-	.use_clustering		= DISABLE_CLUSTERING
-};
-
-
-#include "scsi_module.c"

