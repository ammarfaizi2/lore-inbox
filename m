Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317444AbSF1Ok3>; Fri, 28 Jun 2002 10:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317445AbSF1Ok2>; Fri, 28 Jun 2002 10:40:28 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:19671 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317444AbSF1Ok1>;
	Fri, 28 Jun 2002 10:40:27 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15644.30181.956053.553768@argo.ozlabs.ibm.com>
Date: Fri, 28 Jun 2002 10:42:45 -0400 (EDT)
To: dalecki@evision-ventures.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix ide-pmac.c compile errors
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

The following patch fixes some compile errors in ide-pmac.c.  Please
apply.

Paul.

diff -urN linux-2.5/drivers/ide/ide-pmac.c pmac-2.5/drivers/ide/ide-pmac.c
--- linux-2.5/drivers/ide/ide-pmac.c	Fri Jun 28 10:35:07 2002
+++ pmac-2.5/drivers/ide/ide-pmac.c	Tue Jun 25 15:06:34 2002
@@ -256,7 +256,7 @@
 static void pmac_ide_setup_dma(struct device_node *np, int ix);
 
 static void pmac_udma_enable(struct ata_device *drive, int on, int verbose);
-static int pmac_udma_start(struct ata_device *drive, struct request *rq);
+static void pmac_udma_start(struct ata_device *drive, struct request *rq);
 static int pmac_udma_stop(struct ata_device *drive);
 static int pmac_udma_init(struct ata_device *drive, struct request *rq);
 static int pmac_udma_irq_status(struct ata_device *drive);
@@ -1340,7 +1340,7 @@
 	ide_toggle_bounce(drive, 0);
 }
 
-static int pmac_udma_start(struct ata_device *drive, struct request *rq)
+static void pmac_udma_start(struct ata_device *drive, struct request *rq)
 {
 	int ix, ata4;
 	volatile struct dbdma_regs *dma;
@@ -1350,7 +1350,7 @@
 	 */
 	ix = pmac_ide_find(drive);
 	if (ix < 0)
-		return ide_stopped;
+		return;
 
 	dma = pmac_ide[ix].dma_regs;
 	ata4 = (pmac_ide[ix].kind == controller_kl_ata4 ||
@@ -1359,8 +1359,6 @@
 	out_le32(&dma->control, (RUN << 16) | RUN);
 	/* Make sure it gets to the controller right now */
 	(void)in_le32(&dma->control);
-
-	return ide_started;
 }
 
 static int pmac_udma_stop(struct ata_device *drive)
@@ -1490,10 +1488,10 @@
 	 * active bit is still set */
 	set_bit(IDE_DMA, drive->channel->active);
 //	if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
-//		printk(KERN_WARNING "ide%d, timeout waiting \
-				for dbdma command stop\n", ix);
-		return 1;
-	}
+//		printk(KERN_WARNING "ide%d, timeout waiting "
+//			"for dbdma command stop\n", ix);
+//		return 1;
+//	}
 	udelay(1);
 	return 0;
 }
