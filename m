Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263015AbTCSMUm>; Wed, 19 Mar 2003 07:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263012AbTCSMUb>; Wed, 19 Mar 2003 07:20:31 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:43656 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262997AbTCSMSe>;
	Wed, 19 Mar 2003 07:18:34 -0500
Date: Wed, 19 Mar 2003 13:29:36 +0100 (MET)
Message-Id: <200303191229.h2JCTa800982@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] wd33c93 SCSI merge error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wd33c93 SCSI: Fix 2.5.64 merge error

--- linux-2.5.x/drivers/scsi/wd33c93.c	Sun Mar  9 22:40:15 2003
+++ linux-m68k-2.5.x/drivers/scsi/wd33c93.c	Thu Mar  6 12:03:12 2003
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
