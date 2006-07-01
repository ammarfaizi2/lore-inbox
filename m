Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751888AbWGAPLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbWGAPLp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbWGAPLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:11:11 -0400
Received: from www.osadl.org ([213.239.205.134]:51108 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751888AbWGAO5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:21 -0400
Message-Id: <20060701145226.344530000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:51 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, axboe@suse.de
Subject: [RFC][patch 27/44] drivers/block Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-block.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/block/DAC960.c   |    2 +-
 drivers/block/cciss.c    |    2 +-
 drivers/block/cpqarray.c |    2 +-
 drivers/block/ps2esdi.c  |    4 ++--
 drivers/block/sx8.c      |    2 +-
 drivers/block/umem.c     |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.git/drivers/block/cciss.c
===================================================================
--- linux-2.6.git.orig/drivers/block/cciss.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/block/cciss.c	2006-07-01 16:51:39.000000000 +0200
@@ -3159,7 +3159,7 @@ static int __devinit cciss_init_one(stru
 	/* make sure the board interrupts are off */
 	hba[i]->access.set_intr_mask(hba[i], CCISS_INTR_OFF);
 	if (request_irq(hba[i]->intr[SIMPLE_MODE_INT], do_cciss_intr,
-			SA_INTERRUPT | SA_SHIRQ, hba[i]->devname, hba[i])) {
+			IRQF_DISABLED | IRQF_SHARED, hba[i]->devname, hba[i])) {
 		printk(KERN_ERR "cciss: Unable to get irq %d for %s\n",
 		       hba[i]->intr[SIMPLE_MODE_INT], hba[i]->devname);
 		goto clean2;
Index: linux-2.6.git/drivers/block/cpqarray.c
===================================================================
--- linux-2.6.git.orig/drivers/block/cpqarray.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/block/cpqarray.c	2006-07-01 16:51:39.000000000 +0200
@@ -408,7 +408,7 @@ static int __init cpqarray_register_ctlr
 	}
 	hba[i]->access.set_intr_mask(hba[i], 0);
 	if (request_irq(hba[i]->intr, do_ida_intr,
-		SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i]))
+		IRQF_DISABLED|IRQF_SHARED, hba[i]->devname, hba[i]))
 	{
 		printk(KERN_ERR "cpqarray: Unable to get irq %d for %s\n",
 				hba[i]->intr, hba[i]->devname);
Index: linux-2.6.git/drivers/block/DAC960.c
===================================================================
--- linux-2.6.git.orig/drivers/block/DAC960.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/block/DAC960.c	2006-07-01 16:51:39.000000000 +0200
@@ -3014,7 +3014,7 @@ DAC960_DetectController(struct pci_dev *
      Acquire shared access to the IRQ Channel.
   */
   IRQ_Channel = PCI_Device->irq;
-  if (request_irq(IRQ_Channel, InterruptHandler, SA_SHIRQ,
+  if (request_irq(IRQ_Channel, InterruptHandler, IRQF_SHARED,
 		      Controller->FullModelName, Controller) < 0)
   {
 	DAC960_Error("Unable to acquire IRQ Channel %d for Controller at\n",
Index: linux-2.6.git/drivers/block/ps2esdi.c
===================================================================
--- linux-2.6.git.orig/drivers/block/ps2esdi.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/block/ps2esdi.c	2006-07-01 16:51:39.000000000 +0200
@@ -340,9 +340,9 @@ static int __init ps2esdi_geninit(void)
 	/* try to grab IRQ, and try to grab a slow IRQ if it fails, so we can
 	   share with the SCSI driver */
 	if (request_irq(PS2ESDI_IRQ, ps2esdi_interrupt_handler,
-		  SA_INTERRUPT | SA_SHIRQ, "PS/2 ESDI", &ps2esdi_gendisk)
+		  IRQF_DISABLED | IRQF_SHARED, "PS/2 ESDI", &ps2esdi_gendisk)
 	    && request_irq(PS2ESDI_IRQ, ps2esdi_interrupt_handler,
-			   SA_SHIRQ, "PS/2 ESDI", &ps2esdi_gendisk)
+			   IRQF_SHARED, "PS/2 ESDI", &ps2esdi_gendisk)
 	    ) {
 		printk("%s: Unable to get IRQ %d\n", DEVICE_NAME, PS2ESDI_IRQ);
 		error = -EBUSY;
Index: linux-2.6.git/drivers/block/sx8.c
===================================================================
--- linux-2.6.git.orig/drivers/block/sx8.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/block/sx8.c	2006-07-01 16:51:39.000000000 +0200
@@ -1676,7 +1676,7 @@ static int carm_init_one (struct pci_dev
 
 	pci_set_master(pdev);
 
-	rc = request_irq(pdev->irq, carm_interrupt, SA_SHIRQ, DRV_NAME, host);
+	rc = request_irq(pdev->irq, carm_interrupt, IRQF_SHARED, DRV_NAME, host);
 	if (rc) {
 		printk(KERN_ERR DRV_NAME "(%s): irq alloc failure\n",
 		       pci_name(pdev));
Index: linux-2.6.git/drivers/block/umem.c
===================================================================
--- linux-2.6.git.orig/drivers/block/umem.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/drivers/block/umem.c	2006-07-01 16:51:39.000000000 +0200
@@ -1040,7 +1040,7 @@ static int __devinit mm_pci_probe(struct
 	card->win_size = data;
 
 
-	if (request_irq(dev->irq, mm_interrupt, SA_SHIRQ, "pci-umem", card)) {
+	if (request_irq(dev->irq, mm_interrupt, IRQF_SHARED, "pci-umem", card)) {
 		printk(KERN_ERR "MM%d: Unable to allocate IRQ\n", card->card_number);
 		ret = -ENODEV;
 

--

