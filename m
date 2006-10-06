Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWJFFhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWJFFhD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWJFFf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:35:59 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:19126 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751360AbWJFFfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:35:48 -0400
Subject: [PATCH 5/9] sound/pci/rme32.c: ioremap balanced with iounmap
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:09:09 +0530
Message-Id: <1160113149.19143.142.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 rme32.c |    4 ++++
 1 files changed, 4 insertions(+)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/sound/pci/rme32.c linux-2.6.19-rc1/sound/pci/rme32.c
--- linux-2.6.19-rc1-orig/sound/pci/rme32.c	2006-09-21 10:15:53.000000000 +0530
+++ linux-2.6.19-rc1/sound/pci/rme32.c	2006-10-05 16:52:01.000000000 +0530
@@ -1376,6 +1376,7 @@ static int __devinit snd_rme32_create(st
 
 	if (request_irq(pci->irq, snd_rme32_interrupt, IRQF_DISABLED | IRQF_SHARED, "RME32", (void *) rme32)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		iounmap(rme32->iobase);
 		return -EBUSY;
 	}
 	rme32->irq = pci->irq;
@@ -1385,6 +1386,7 @@ static int __devinit snd_rme32_create(st
 
 	/* set up ALSA pcm device for S/PDIF */
 	if ((err = snd_pcm_new(rme32->card, "Digi32 IEC958", 0, 1, 1, &rme32->spdif_pcm)) < 0) {
+		iounmap(rme32->iobase);
 		return err;
 	}
 	rme32->spdif_pcm->private_data = rme32;
@@ -1417,6 +1419,7 @@ static int __devinit snd_rme32_create(st
 		if ((err = snd_pcm_new(rme32->card, "Digi32 ADAT", 1,
 				       1, 1, &rme32->adat_pcm)) < 0)
 		{
+			iounmap(rme32->iobase);
 			return err;
 		}		
 		rme32->adat_pcm->private_data = rme32;
@@ -1462,6 +1465,7 @@ static int __devinit snd_rme32_create(st
 
 	/* init switch interface */
 	if ((err = snd_rme32_create_switches(rme32->card, rme32)) < 0) {
+		iounmap(rme32->iobase);
 		return err;
 	}
 


