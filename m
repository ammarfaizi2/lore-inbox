Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751878AbWGAPJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbWGAPJW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWGAPIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:08:51 -0400
Received: from www.osadl.org ([213.239.205.134]:54948 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751837AbWGAO5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:25 -0400
Message-Id: <20060701145226.813774000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:56 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, bcollins@debian.org
Subject: [RFC][patch 31/44] firewire: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-firewire.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/ieee1394/ohci1394.c |    4 ++--
 drivers/ieee1394/pcilynx.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.git/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-2.6.git.orig/drivers/ieee1394/ohci1394.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/ieee1394/ohci1394.c	2006-07-01 16:51:41.000000000 +0200
@@ -3392,12 +3392,12 @@ static int __devinit ohci1394_pci_probe(
 	spin_lock_init(&ohci->event_lock);
 
 	/*
-	 * interrupts are disabled, all right, but... due to SA_SHIRQ we
+	 * interrupts are disabled, all right, but... due to IRQF_SHARED we
 	 * might get called anyway.  We'll see no event, of course, but
 	 * we need to get to that "no event", so enough should be initialized
 	 * by that point.
 	 */
-	if (request_irq(dev->irq, ohci_irq_handler, SA_SHIRQ,
+	if (request_irq(dev->irq, ohci_irq_handler, IRQF_SHARED,
 			 OHCI1394_DRIVER_NAME, ohci))
 		FAIL(-ENOMEM, "Failed to allocate shared interrupt %d", dev->irq);
 
Index: linux-2.6.git/drivers/ieee1394/pcilynx.c
===================================================================
--- linux-2.6.git.orig/drivers/ieee1394/pcilynx.c	2006-07-01 16:51:18.000000000 +0200
+++ linux-2.6.git/drivers/ieee1394/pcilynx.c	2006-07-01 16:51:41.000000000 +0200
@@ -1253,7 +1253,7 @@ static int __devinit add_card(struct pci
 
 	sprintf (irq_buf, "%d", dev->irq);
 
-        if (!request_irq(dev->irq, lynx_irq_handler, SA_SHIRQ,
+        if (!request_irq(dev->irq, lynx_irq_handler, IRQF_SHARED,
                          PCILYNX_DRIVER_NAME, lynx)) {
                 PRINT(KERN_INFO, lynx->id, "allocated interrupt %s", irq_buf);
                 lynx->state = have_intr;

--

