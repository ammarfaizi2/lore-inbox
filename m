Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbTAHKou>; Wed, 8 Jan 2003 05:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbTAHKou>; Wed, 8 Jan 2003 05:44:50 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:28630 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265633AbTAHKos>;
	Wed, 8 Jan 2003 05:44:48 -0500
Date: Wed, 8 Jan 2003 11:47:12 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Antonino Daplas <adaplas@pol.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
In-Reply-To: <Pine.LNX.4.44.0301072147070.17129-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.21.0301081142190.21171-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2003, James Simmons wrote:
> > Why? (a) only those which will use putcs, and (b) I see no 512 chars limit
> > anywhere in new code. And in old code it is there only because of passed
> > data are only 16bit, not 32bit wide... With simple search&replace you can
> > extend it to any size you want, as long as you'll not use sparse font
> > bitmap.
> 
> The current "core" console code screen_buf layout is designed after VGA 
> text mode. 16 bits which only 8 bits are used to represent a character, 9 
> if you have high_fonts flag set. The other 8,7 bits are for attributes. 
> This is very limiting and it does effect fbcon.c :-( I like to the console
> system remove these awful limitation in the future. This why I like to see 
> fbdev drivers avoid touching strings from the console layer.

Please note that Tony's new accel_putcs() code uses __u32 to pass the character
indices.  So it's not limited to 256/512 characters per font. Fonts can be as
large as you want. Sparse fonts can be handled as well, if accel_putcs() takes
care of the conversion from sparse character indices to dense character
indices.

His code can be viewed as a way to do multiple monochrome to color expansions
with one single call, using a predefined table of patterns. Quite generic,
unless you want to have multi-color fonts later :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

