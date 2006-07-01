Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751899AbWGAPKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWGAPKP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWGAPJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:09:40 -0400
Received: from www.osadl.org ([213.239.205.134]:53924 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751897AbWGAO5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:24 -0400
Message-Id: <20060701145226.697263000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:54 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [RFC][patch 30/44] ide: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-ide.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/ide/ide-probe.c |   10 +++++-----
 drivers/ide/legacy/hd.c |    4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.git/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.git.orig/drivers/ide/ide-probe.c	2006-07-01 16:51:19.000000000 +0200
+++ linux-2.6.git/drivers/ide/ide-probe.c	2006-07-01 16:51:40.000000000 +0200
@@ -1004,7 +1004,7 @@ static int ide_init_queue(ide_drive_t *d
  * and irq serialization situations.  This is somewhat complex because
  * it handles static as well as dynamic (PCMCIA) IDE interfaces.
  *
- * The SA_INTERRUPT in sa_flags means ide_intr() is always entered with
+ * The IRQF_DISABLED in sa_flags means ide_intr() is always entered with
  * interrupts completely disabled.  This can be bad for interrupt latency,
  * but anything else has led to problems on some machines.  We re-enable
  * interrupts as much as we can safely do in most places.
@@ -1090,15 +1090,15 @@ static int init_irq (ide_hwif_t *hwif)
 	 * Allocate the irq, if not already obtained for another hwif
 	 */
 	if (!match || match->irq != hwif->irq) {
-		int sa = SA_INTERRUPT;
+		int sa = IRQF_DISABLED;
 #if defined(__mc68000__) || defined(CONFIG_APUS)
-		sa = SA_SHIRQ;
+		sa = IRQF_SHARED;
 #endif /* __mc68000__ || CONFIG_APUS */
 
 		if (IDE_CHIPSET_IS_PCI(hwif->chipset)) {
-			sa = SA_SHIRQ;
+			sa = IRQF_SHARED;
 #ifndef CONFIG_IDEPCI_SHARE_IRQ
-			sa |= SA_INTERRUPT;
+			sa |= IRQF_DISABLED;
 #endif /* CONFIG_IDEPCI_SHARE_IRQ */
 		}
 
Index: linux-2.6.git/drivers/ide/legacy/hd.c
===================================================================
--- linux-2.6.git.orig/drivers/ide/legacy/hd.c	2006-07-01 16:51:19.000000000 +0200
+++ linux-2.6.git/drivers/ide/legacy/hd.c	2006-07-01 16:51:40.000000000 +0200
@@ -691,7 +691,7 @@ static struct block_device_operations hd
 };
 
 /*
- * This is the hard disk IRQ description. The SA_INTERRUPT in sa_flags
+ * This is the hard disk IRQ description. The IRQF_DISABLED in sa_flags
  * means we run the IRQ-handler with interrupts disabled:  this is bad for
  * interrupt latency, but anything else has led to problems on some
  * machines.
@@ -806,7 +806,7 @@ static int __init hd_init(void)
 			p->cyl, p->head, p->sect);
 	}
 
-	if (request_irq(HD_IRQ, hd_interrupt, SA_INTERRUPT, "hd", NULL)) {
+	if (request_irq(HD_IRQ, hd_interrupt, IRQF_DISABLED, "hd", NULL)) {
 		printk("hd: unable to get IRQ%d for the hard disk driver\n",
 			HD_IRQ);
 		goto out1;

--

