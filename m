Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268026AbTCFK3V>; Thu, 6 Mar 2003 05:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268032AbTCFK3U>; Thu, 6 Mar 2003 05:29:20 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:43201 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S268026AbTCFK3S>;
	Thu, 6 Mar 2003 05:29:18 -0500
Date: Thu, 6 Mar 2003 11:39:40 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.64
In-Reply-To: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0303061137580.28248-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003, Linus Torvalds wrote:
> Christoph Hellwig <hch@sgi.com>:
>   o wd33c93 updates

> Dave Jones <davej@codemonkey.org.uk>:
>   o wd33c93 sync up with 2.4

These were not compatible. The patch below (untested) fixes the breakage for
sgiwd93:

--- linux-2.5.64/drivers/scsi/wd33c93.c.orig	Wed Mar  5 10:07:20 2003
+++ linux-2.5.64/drivers/scsi/wd33c93.c	Wed Mar  5 11:56:14 2003
@@ -1471,7 +1471,7 @@
 		int busycount = 0;
 		extern void sgiwd93_reset(unsigned long);
 		/* wait 'til the chip gets some time for us */
-		while ((READ_AUX_STAT() & ASR_BSY) && busycount++ < 100)
+		while ((read_aux_stat(regs) & ASR_BSY) && busycount++ < 100)
 			udelay (10);
 	/*
  	 * there are scsi devices out there, which manage to lock up
@@ -1481,7 +1481,7 @@
 	 * does this for the SGI Indy, where this is possible
 	 */
 	/* still busy ? */
-	if (READ_AUX_STAT() & ASR_BSY)
+	if (read_aux_stat(regs) & ASR_BSY)
 		sgiwd93_reset(instance->base); /* yeah, give it the hard one */
 	}
 #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

