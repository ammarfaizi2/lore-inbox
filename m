Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSK1NK6>; Thu, 28 Nov 2002 08:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSK1NK6>; Thu, 28 Nov 2002 08:10:58 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:54714 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265470AbSK1NK5>;
	Thu, 28 Nov 2002 08:10:57 -0500
Date: Thu, 28 Nov 2002 14:17:05 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andre M. Hedrick" <andre@linux-ide.org>,
       Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.50
In-Reply-To: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0211281415290.9187-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002, Linus Torvalds wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>   o remove io related stuff from ide.c

ide_intr_lock() is used in ide-io.c (new file in 2.5.50), but it's static in
ide.c.

--- linux-2.5.50/drivers/ide/ide.c	Thu Nov 28 10:19:40 2002
+++ linux-m68k-2.5.50/drivers/ide/ide.c	Thu Nov 28 12:02:23 2002
@@ -186,7 +186,7 @@
  * ide_lock is used by the Atari code to obtain access to the IDE interrupt,
  * which is shared between several drivers.
  */
-static int	ide_intr_lock;
+int ide_intr_lock;
 #endif /* IDE_ARCH_LOCK */
 
 #ifdef CONFIG_IDEDMA_AUTO
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file ./linux-m68k-2.5.50/include/linux/ide.h testing/linux-m68k-2.5.50/include/linux/ide.h
--- linux-2.5.50/include/linux/ide.h	Thu Nov 28 10:20:12 2002
+++ linux-m68k-2.5.50/include/linux/ide.h	Thu Nov 28 12:02:01 2002
@@ -358,8 +358,10 @@
 # define ide_ack_intr(hwif) (1)
 #endif
 
+#ifdef IDE_ARCH_LOCK
 /* Currently only Atari needs it */
-#ifndef IDE_ARCH_LOCK
+extern int ide_intr_lock;
+#else
 # define ide_release_lock(lock)			do {} while (0)
 # define ide_get_lock(lock, hdlr, data)		do {} while (0)
 #endif /* IDE_ARCH_LOCK */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

