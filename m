Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSGBLCv>; Tue, 2 Jul 2002 07:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316766AbSGBLCu>; Tue, 2 Jul 2002 07:02:50 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:26614 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S316757AbSGBLCt>;
	Tue, 2 Jul 2002 07:02:49 -0400
Date: Tue, 2 Jul 2002 13:05:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] bitops operate on unsigned long
Message-ID: <Pine.GSO.4.21.0207021303460.25055-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bitops must operate on unsigned long.

--- linux-2.5.24/drivers/zorro/zorro.c	Mon May 13 10:55:35 2002
+++ linux-m68k-2.5.24/drivers/zorro/zorro.c	Tue Jul  2 12:59:34 2002
@@ -80,7 +80,7 @@
      *  FIXME: use the normal resource management
      */
 
-u32 zorro_unused_z2ram[4] = { 0, 0, 0, 0 };
+unsigned long zorro_unused_z2ram[128/BITS_PER_LONG];
 
 
 static void __init mark_region(unsigned long start, unsigned long end,
--- linux-2.5.24/include/linux/generic_serial.h	Mon Feb 11 13:14:29 2002
+++ linux-m68k-2.5.24/include/linux/generic_serial.h	Tue Jun 25 20:50:38 2002
@@ -45,7 +45,7 @@
   int                     count;
   int                     blocked_open;
   struct tty_struct       *tty;
-  int                     event;
+  unsigned long           event;
   unsigned short          closing_wait;
   int                     close_delay;
   struct real_driver      *rd;
--- linux-2.5.24/include/linux/serial167.h	Sun May 16 00:05:37 1999
+++ linux-m68k-2.5.24/include/linux/serial167.h	Tue Jun 25 20:50:38 2002
@@ -37,7 +37,7 @@
 	int			ignore_status_mask;
 	int			close_delay;
 	int			IER; 	/* Interrupt Enable Register */
-	int			event;
+	unsigned long		event;
 	unsigned long		last_active;
 	int			count;	/* # of fd on device */
 	int                     x_char; /* to be pushed out ASAP */
--- linux-2.5.24/include/linux/zorro.h	Mon May 13 10:55:40 2002
+++ linux-m68k-2.5.24/include/linux/zorro.h	Tue Jul  2 12:59:34 2002
@@ -199,7 +199,7 @@
      *  the corresponding bits.
      */
 
-extern __u32 zorro_unused_z2ram[4];
+extern unsigned long zorro_unused_z2ram[128/BITS_PER_LONG];
 
 #define Z2RAM_START		(0x00200000)
 #define Z2RAM_END		(0x00a00000)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

