Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277156AbRJDHnO>; Thu, 4 Oct 2001 03:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277159AbRJDHnE>; Thu, 4 Oct 2001 03:43:04 -0400
Received: from mail.sonytel.be ([193.74.243.200]:49898 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S277156AbRJDHnA>;
	Thu, 4 Oct 2001 03:43:00 -0400
Date: Thu, 4 Oct 2001 09:41:43 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ricky Beam <jfbeam@bluetopia.net>,
        Andrew Morton <akpm@zip.com.au>,
        Lorenzo Allegrucci <lenstra@tiscalinet.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: Huge console switching lags
In-Reply-To: <Pine.LNX.4.10.10110021536080.30587-100000@transvirtual.com>
Message-ID: <Pine.GSO.4.21.0110040937480.17814-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001, James Simmons wrote:
> > > Well the reason the framebuffer suck is because the current api sucks for
> > > them. It draws pixel by pixel. Slow slow slow!!! I have developed a new
            ^^^^^^^^^^^^^^^^^^^^^^^
Where does it draw pixel by pixel?

> > > api that takes advantage of the accel engine of graphics hardware. It is
> > 
> > Great. VESAfb doesnt have one. Lots of older machines dont have one.
> 
>    True. Of course VESAfb exist because we lack so fbdev drivers. In time

Yep. Vesafb started as a nice gimmick to show that it's possible, and turned
out to be a solution for yet another
we-don't-release-specs-to-OS/FS-people company.

>    The software accel functions needed by the console layer (copyarea,
> fillrect, and drawimage) have been already written. Okay the drawimage one
> needs alot of work. I haven't benchmarked the new code versus the current
> code but you can see the difference. One of the big changes I have have
> made is that on write data to the framebuffer word aligned and a long at
> a time. For 8bpp you have 4 pixels written at a time. This makes for a
> much tigher loop. On ix86 you can see a huge difference in performance due
> to the word alignment. I knwo because at first I had a bug that wasn't
> doing it right. After I fix that bug you could see the difference. 

Euh, most fbcon-* drivers already do this. Grep for fb_write in e.g.
drivers/video/fbcon-cfb8.c and count the byte accesses (=> 0).

Gr{oetje,eeting}s,

						Geert

P.S. Not to criticize the development in the Ruby tree of the linux-console
     project, but I don't like facts that aren't true.
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

