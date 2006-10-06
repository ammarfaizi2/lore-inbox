Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWJFFgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWJFFgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWJFFgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:36:08 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:16822 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S932196AbWJFFfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:35:34 -0400
Subject: [PATCH 7/9] sound/pci/rme9652/hdspm.c: ioremap balanced with
	iounmap
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:08:56 +0530
Message-Id: <1160113136.19143.135.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 hdspm.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/sound/pci/rme9652/hdspm.c linux-2.6.19-rc1/sound/pci/rme9652/hdspm.c
--- linux-2.6.19-rc1-orig/sound/pci/rme9652/hdspm.c	2006-09-21 10:15:53.000000000 +0530
+++ linux-2.6.19-rc1/sound/pci/rme9652/hdspm.c	2006-10-05 16:55:32.000000000 +0530
@@ -3500,6 +3500,7 @@ static int __devinit snd_hdspm_create(st
 			IRQF_DISABLED | IRQF_SHARED, "hdspm",
 			(void *) hdspm)) {
 		snd_printk(KERN_ERR "HDSPM: unable to use IRQ %d\n", pci->irq);
+		iounmap(hdspm->iobase);
 		return -EBUSY;
 	}
 
@@ -3516,6 +3517,7 @@ static int __devinit snd_hdspm_create(st
 	    == NULL) {
 		snd_printk(KERN_ERR "HDSPM: unable to kmalloc Mixer memory of %d Bytes\n",
 			   (int)sizeof(struct hdspm_mixer));
+		iounmap(hdspm->iobase);
 		return err;
 	}
 
@@ -3524,8 +3526,10 @@ static int __devinit snd_hdspm_create(st
 	hdspm->qs_channels = MADI_QS_CHANNELS;
 
 	snd_printdd("create alsa devices.\n");
-	if ((err = snd_hdspm_create_alsa_devices(card, hdspm)) < 0)
+	if ((err = snd_hdspm_create_alsa_devices(card, hdspm)) < 0) {
+		iounmap(hdspm->iobase);
 		return err;
+	}
 
 	snd_hdspm_initialize_midi_flush(hdspm);
 


