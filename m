Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUIKHUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUIKHUh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 03:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268129AbUIKHUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 03:20:37 -0400
Received: from witte.sonytel.be ([80.88.33.193]:9141 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268122AbUIKHUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 03:20:23 -0400
Date: Sat, 11 Sep 2004 09:19:54 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
In-Reply-To: <200409101328.57431.adaplas@hotpop.com>
Message-ID: <Pine.GSO.4.58.0409110918001.17924@waterleaf.sonytel.be>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Antonino A. Daplas wrote:
> On Friday 10 September 2004 10:23, Benjamin Herrenschmidt wrote:
> > Recent changes upstream are breaking fbdev on pmacs.
> >
> > I haven't had time to go deep into that (but I suspect Linus sees it
> > too on his own g5 unless he removed offb from his .config).
> >
> > From what I see, it seems that offb is kicking in by default, reserves
> > the mmio regions, and then whatever chip driver loads can't access them.
> >
> > offb is supposed to be a "fallback" driver in case no fbdev is taking
> > over, it should also be "forced" in with video=ofonly kernel command
> > line. This logic has been broken.
>
> Actually, I was thinking about this problem with offb.  I was planning on
> adding video=offb:off support for offb, and then place offb at the very top
> drivers Makefile (the reason why I placed it there, but forgot to add the
> setup support for offb).  So, without the 'off' option, offb becomes the
> first driver that gets initialized by reason that it's at the top, and with
> the 'off' option, it just exits initialization immediately, giving the other
> drivers a chance to get through.

This is not suitable, since for dual-headed machines, you may want to have one
card driven by its native driver, and the other by offb (as fallback, because
no driver exists yet).

> The second method is not harder but will involve, again, changes to all
> drivers.  The only sane method I can think of is to change fb_get_options so
> it returns an error if:
>
> a. "off" option is enabled
> b. "ofonly" is enabled but only if name != "offb"
>
> If fb_get_options returns an error, drivers will not proceed with their
> initialization. The second method is more compatible with the
> previous setup semantics.

Yes, looks better (except that it's less clean, but I'm afraid we can't fix
that easily).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
