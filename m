Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSGXPOM>; Wed, 24 Jul 2002 11:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSGXPOM>; Wed, 24 Jul 2002 11:14:12 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:60865 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S317351AbSGXPOL>;
	Wed, 24 Jul 2002 11:14:11 -0400
Date: Wed, 24 Jul 2002 17:15:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] penguin logo code
Message-ID: <Pine.GSO.4.21.0207241714220.5289-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


### Comments for changeset
The penguin logo resides in normal RAM, not in frame buffer memory, so we must
not use fb_readb()

### Comments for drivers/video/fbcon.c
The penguin logo resides in normal RAM, not in frame buffer memory, so we must
not use fb_readb()

--- linux-2.4.19-rc3/drivers/video/fbcon.c	Fri Feb 22 16:28:32 2002
+++ linux-m68k-2.4.19-rc3/drivers/video/fbcon.c	Mon Jul 22 21:45:01 2002
@@ -2417,7 +2417,7 @@
 		else
 		    dst = fb + y1*line + x/8;
 		for( x1 = 0; x1 < LOGO_LINE; ++x1 )
-		    fb_writeb(fb_readb(src++) ^ inverse, dst++);
+		    fb_writeb(*src++ ^ inverse, dst++);
 	    }
 	    done = 1;
 	}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

