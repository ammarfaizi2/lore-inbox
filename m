Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWGAPGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWGAPGn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWGAPG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:06:29 -0400
Received: from www.osadl.org ([213.239.205.134]:61092 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751813AbWGAO5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:33 -0400
Message-Id: <20060701145227.433791000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:55:02 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, matthew@wil.cx
Subject: [RFC][patch 36/44] PARISC: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-parisc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/parisc/eisa.c    |    2 +-
 drivers/parisc/superio.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.git/drivers/parisc/eisa.c
===================================================================
--- linux-2.6.git.orig/drivers/parisc/eisa.c	2006-07-01 16:51:13.000000000 +0200
+++ linux-2.6.git/drivers/parisc/eisa.c	2006-07-01 16:51:46.000000000 +0200
@@ -340,7 +340,7 @@ static int __devinit eisa_probe(struct p
 	}
 	pcibios_register_hba(&eisa_dev.hba);
 
-	result = request_irq(dev->irq, eisa_irq, SA_SHIRQ, "EISA", &eisa_dev);
+	result = request_irq(dev->irq, eisa_irq, IRQF_SHARED, "EISA", &eisa_dev);
 	if (result) {
 		printk(KERN_ERR "EISA: request_irq failed!\n");
 		return result;
Index: linux-2.6.git/drivers/parisc/superio.c
===================================================================
--- linux-2.6.git.orig/drivers/parisc/superio.c	2006-07-01 16:51:13.000000000 +0200
+++ linux-2.6.git/drivers/parisc/superio.c	2006-07-01 16:51:46.000000000 +0200
@@ -271,7 +271,7 @@ superio_init(struct pci_dev *pcidev)
 	else
 		printk(KERN_ERR PFX "USB regulator not initialized!\n");
 
-	if (request_irq(pdev->irq, superio_interrupt, SA_INTERRUPT,
+	if (request_irq(pdev->irq, superio_interrupt, IRQF_DISABLED,
 			SUPERIO, (void *)sio)) {
 
 		printk(KERN_ERR PFX "could not get irq\n");

--

