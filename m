Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWJFFho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWJFFho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWJFFhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:37:08 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:16566 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751374AbWJFFfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:35:34 -0400
Subject: [PATCH 8/9] sound/pci/rme9652/rme9652.c: ioremap balanced with
	iounmap
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:08:55 +0530
Message-Id: <1160113135.19143.133.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 rme9652.c |    4 ++++
 1 files changed, 4 insertions(+)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/sound/pci/rme9652/rme9652.c linux-2.6.19-rc1/sound/pci/rme9652/rme9652.c
--- linux-2.6.19-rc1-orig/sound/pci/rme9652/rme9652.c	2006-09-21 10:15:53.000000000 +0530
+++ linux-2.6.19-rc1/sound/pci/rme9652/rme9652.c	2006-10-05 16:56:18.000000000 +0530
@@ -2502,6 +2502,7 @@ static int __devinit snd_rme9652_create(
 	
 	if (request_irq(pci->irq, snd_rme9652_interrupt, IRQF_DISABLED|IRQF_SHARED, "rme9652", (void *)rme9652)) {
 		snd_printk(KERN_ERR "unable to request IRQ %d\n", pci->irq);
+		iounmap(rme9652->iobase);
 		return -EBUSY;
 	}
 	rme9652->irq = pci->irq;
@@ -2562,14 +2563,17 @@ static int __devinit snd_rme9652_create(
 	pci_set_master(rme9652->pci);
 
 	if ((err = snd_rme9652_initialize_memory(rme9652)) < 0) {
+		iounmap(rme9652->iobase);
 		return err;
 	}
 
 	if ((err = snd_rme9652_create_pcm(card, rme9652)) < 0) {
+		iounmap(rme9652->iobase);
 		return err;
 	}
 
 	if ((err = snd_rme9652_create_controls(card, rme9652)) < 0) {
+		iounmap(rme9652->iobase);
 		return err;
 	}
 


