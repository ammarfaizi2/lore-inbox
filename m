Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWJFFfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWJFFfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWJFFfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:35:36 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:16054 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751360AbWJFFfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:35:33 -0400
Subject: [PATCH 9/9] sound/pci/rme96.c: ioremap balanced with iounmap
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:08:54 +0530
Message-Id: <1160113134.19143.131.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 rme96.c |    4 ++++
 1 files changed, 4 insertions(+)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/sound/pci/rme96.c linux-2.6.19-rc1/sound/pci/rme96.c
--- linux-2.6.19-rc1-orig/sound/pci/rme96.c	2006-09-21 10:15:53.000000000 +0530
+++ linux-2.6.19-rc1/sound/pci/rme96.c	2006-10-05 16:53:17.000000000 +0530
@@ -1590,6 +1590,7 @@ snd_rme96_create(struct rme96 *rme96)
 
 	if (request_irq(pci->irq, snd_rme96_interrupt, IRQF_DISABLED|IRQF_SHARED, "RME96", (void *)rme96)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		iounmap(rme96->iobase);
 		return -EBUSY;
 	}
 	rme96->irq = pci->irq;
@@ -1601,6 +1602,7 @@ snd_rme96_create(struct rme96 *rme96)
 	if ((err = snd_pcm_new(rme96->card, "Digi96 IEC958", 0,
 			       1, 1, &rme96->spdif_pcm)) < 0)
 	{
+		iounmap(rme96->iobase);
 		return err;
 	}
 	rme96->spdif_pcm->private_data = rme96;
@@ -1619,6 +1621,7 @@ snd_rme96_create(struct rme96 *rme96)
 		if ((err = snd_pcm_new(rme96->card, "Digi96 ADAT", 1,
 				       1, 1, &rme96->adat_pcm)) < 0)
 		{
+			iounmap(rme96->iobase);
 			return err;
 		}		
 		rme96->adat_pcm->private_data = rme96;
@@ -1671,6 +1674,7 @@ snd_rme96_create(struct rme96 *rme96)
 	
 	/* init switch interface */
 	if ((err = snd_rme96_create_switches(rme96->card, rme96)) < 0) {
+		iounmap(rme96->iobase);
 		return err;
 	}
 


