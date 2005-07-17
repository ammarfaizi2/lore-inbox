Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVGQVPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVGQVPD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 17:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVGQVPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 17:15:02 -0400
Received: from witte.sonytel.be ([80.88.33.193]:43955 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261306AbVGQVPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 17:15:00 -0400
Date: Sun, 17 Jul 2005 23:14:38 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] add NULL short circuit to fb_dealloc_cmap()
In-Reply-To: <9e473391050717132233347d25@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
References: <200507172043.41473.jesper.juhl@gmail.com>
 <9e473391050717132233347d25@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2005, Jon Smirl wrote:
> On 7/17/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > Resource freeing functions should generally be safe to call with NULL pointers.
> > Why?
> >  - there is some precedence in the kernel for this for deallocation functions.
> >  - removes the need for callers to check pointers for NULL.
> >  - space is saved overall by less code to test pointers for NULL all over the place.
> >  - removes possible NULL pointer dereferences when a caller forgot to check.
> > 
> > This patch makes  fb_dealloc_cmap()  safe to call with a NULL pointer argument.
> 
> The fb cmap copde would be a lot simpler if it did everything with a
> single allocation instead of five. Make a super cmap struct:
> 
> struct fb_super_cmap {
>    struct fb_cmap cmap;
>    __u16 red[255];
>    __u16 blue[255];
>    __u16 green[255];
>    __u16 transp[255];
                  ^^^
I assume you meant 256?

> }
> 
> Then adjust the code as need. Have the embedded cmap struct point to
> the fields in the super_cmap and the drivers don't have to be changed.

What if your colormap has more than 256 entries?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
