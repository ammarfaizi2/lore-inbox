Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVCTVwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVCTVwe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 16:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVCTVwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 16:52:34 -0500
Received: from witte.sonytel.be ([80.88.33.193]:29631 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261289AbVCTVwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 16:52:25 -0500
Date: Sun, 20 Mar 2005 22:49:51 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Alex Kern <alex.kern@gmx.de>, Ani Joshi <ajoshi@shell.unixbox.com>,
       "Ben. Herrenschmidt" <benh@kernel.crashing.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
       Helge Deller <deller@gmx.de>, Philipp Rumpf <prumpf@tux.org>,
       James Simmons <jsimmons@users.sourceforge.net>,
       "Eddie C. Dost" <ecd@skynet.be>, Nicolas Pitre <nico@cam.org>,
       linux-arm-kernel@lists.arm.linux.org.uk, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove redundant NULL checks before kfree() in drivers/video/
In-Reply-To: <200503210453.47487.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.62.0503202248270.27963@gorilla.sonytel.be>
References: <Pine.LNX.4.62.0503192339190.5507@dragon.hyggekrogen.localhost>
 <200503210453.47487.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Antonino A. Daplas wrote:
> On Sunday 20 March 2005 06:59, Jesper Juhl wrote:
> > Checking a pointer for NULL before calling kfree() on it is redundant,
> > kfree() deals with NULL pointers just fine.
> > This patch removes such checks from files in drivers/video/
> >
> > Since this is a fairly trivial change (and the same change made
> > everywhere) I've just made a single patch for all the files and CC all
> > authors/maintainers of those files I could find for comments. If spliting
> > this into one patch pr file is prefered, then I can easily do that as
> > well.
> >
> 
> [snip]
> 
> > --- linux-2.6.11-mm4-orig/drivers/video/console/bitblit.c	2005-03-16
> > 15:45:26.000000000 +0100 +++
> > linux-2.6.11-mm4/drivers/video/console/bitblit.c	2005-03-19
> > 22:27:39.000000000 +0100 @@ -199,8 +199,7 @@ static void bit_putcs(struct
> > vc_data *vc
> >  		count -= cnt;
> >  	}
> >
> > -	if (buf)
> > -		kfree(buf);
> > +	kfree(buf);
> >  }
> >
> 
> This is performance critical, so I would like the check to remain. A comment
> may be added in this section.

The first thing kfree() does is check for the NULL pointer. And since kfree()
is used a lot, it's probably already in the cache.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
