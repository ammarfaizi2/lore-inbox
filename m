Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUBTM6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUBTM5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:57:55 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:32321 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261228AbUBTMzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:55:10 -0500
Date: Fri, 20 Feb 2004 13:54:55 +0100
Message-Id: <200402201254.i1KCst8Q004410@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 400] Amifb modedb bug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amifb: Fix bugs in the video mode database:
  - ntsc-lace lacks the yres value
  - a2024-15 is 15 Hz, not 10

--- linux-2.6.3/drivers/video/amifb.c	2003-05-27 19:03:30.000000000 +0200
+++ linux-m68k-2.6.3/drivers/video/amifb.c	2004-02-02 15:38:21.000000000 +0100
@@ -832,7 +832,7 @@
 	FB_SYNC_BROADCAST, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
     }, {
 	/* 640x400, 15 kHz, 60 Hz interlaced (NTSC) */
-	"ntsc-lace", 60, 640, TAG_HIRES, 106, 86, 88, 33, 76, 4,
+	"ntsc-lace", 60, 640, 400, TAG_HIRES, 106, 86, 88, 33, 76, 4,
 	FB_SYNC_BROADCAST, FB_VMODE_INTERLACED | FB_VMODE_YWRAP
     }, {
 	/* 640x256, 15 kHz, 50 Hz (PAL) */
@@ -927,7 +927,7 @@
 	0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
     }, {
 	/* 1024x800, 15 Hz */
-	"a2024-15", 10, 1024, 800, TAG_HIRES, 0, 0, 0, 0, 0, 0,
+	"a2024-15", 15, 1024, 800, TAG_HIRES, 0, 0, 0, 0, 0, 0,
 	0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
     }
 #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
