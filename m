Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130359AbQKLKRH>; Sun, 12 Nov 2000 05:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbQKLKQ6>; Sun, 12 Nov 2000 05:16:58 -0500
Received: from aeon.tvd.be ([195.162.196.20]:23804 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S130359AbQKLKQp>;
	Sun, 12 Nov 2000 05:16:45 -0500
Date: Sun, 12 Nov 2000 11:16:42 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test11-pre3
In-Reply-To: <Pine.LNX.4.10.10011111914170.7609-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.05.10011121115050.24986-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2000, Linus Torvalds wrote:
>     - Alan Cox: SCSI driver NULL ptr checks

Which needs the following fix:

--- linux-2.4.0-test11-pre3/drivers/scsi/a2091.c.orig	Sun Nov 12 10:50:26 2000
+++ linux-2.4.0-test11-pre3/drivers/scsi/a2091.c	Sun Nov 12 11:14:15 2000
@@ -207,8 +207,10 @@
 	    continue;
 
 	instance = scsi_register (tpnt, sizeof (struct WD33C93_hostdata));
-	if(instance == NULL)
-		continue;
+	if (instance == NULL) {
+	    release_mem_region(address, 256);
+	    continue;
+	}
 	instance->base = ZTWO_VADDR(address);
 	instance->irq = IRQ_AMIGA_PORTS;
 	instance->unique_id = z->slotaddr;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
