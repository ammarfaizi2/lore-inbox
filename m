Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274016AbRISGy0>; Wed, 19 Sep 2001 02:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274014AbRISGyG>; Wed, 19 Sep 2001 02:54:06 -0400
Received: from mail.sonytel.be ([193.74.243.200]:5856 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S271587AbRISGyA>;
	Wed, 19 Sep 2001 02:54:00 -0400
Date: Wed, 19 Sep 2001 08:54:23 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Linux 2.4.10-pre12
In-Reply-To: <Pine.LNX.4.33.0109181737550.1111-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0109190851450.14079-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, Linus Torvalds wrote:
> pre12:
>  - Alan Cox: much more merging

Anybody with an idea where this comes from?!?

  - There should be a test for a failed kmalloc()
  - sun3fb_init_fb() returns void (it returns int in the m68k tree)

diff -u --recursive --new-file v2.4.9/linux/drivers/video/sun3fb.c linux/drivers/video/sun3fb.c
--- v2.4.9/linux/drivers/video/sun3fb.c	Thu Apr 26 22:17:27 2001
+++ linux/drivers/video/sun3fb.c	Mon Sep 17 22:52:35 2001
@@ -586,9 +586,11 @@
 	fb->cursor.hwsize.fbx = 32;
 	fb->cursor.hwsize.fby = 32;
 	
-	if (depth > 1 && !fb->color_map)
+	if (depth > 1 && !fb->color_map) {
 		fb->color_map = kmalloc(256 * 3, GFP_ATOMIC);
-		
+		return -ENOMEM;
+	}
+			
 	switch(fbtype) {
 #ifdef CONFIG_FB_CGSIX
 	case FBTYPE_SUNFAST_COLOR:

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

