Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVCUUho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVCUUho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVCUUeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:34:46 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:3423 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261867AbVCUUcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:32:51 -0500
Date: Mon, 21 Mar 2005 21:25:50 +0100
Message-Id: <200503212025.j2LKPomJ011322@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 544] Mac NCR5380 SCSI: Fix bus error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac NCR5380 SCSI: Fix bus error by passing the correct instance pointer to
request_irq()

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.12-rc1/drivers/scsi/mac_scsi.c	2005-03-09 22:21:01.369397570 +1100
+++ linux-m68k-2.6.12-rc1/drivers/scsi/mac_scsi.c	2005-03-09 22:02:12.594082086 +1100
@@ -302,7 +302,7 @@ int macscsi_detect(Scsi_Host_Template * 
 
     if (instance->irq != SCSI_IRQ_NONE)
 	if (request_irq(instance->irq, NCR5380_intr, IRQ_FLG_SLOW, 
-		"ncr5380", NCR5380_intr)) {
+		"ncr5380", instance)) {
 	    printk(KERN_WARNING "scsi%d: IRQ%d not free, interrupts disabled\n",
 		   instance->host_no, instance->irq);
 	    instance->irq = SCSI_IRQ_NONE;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
