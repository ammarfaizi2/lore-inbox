Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261821AbTC0JAu>; Thu, 27 Mar 2003 04:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261822AbTC0JAt>; Thu, 27 Mar 2003 04:00:49 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:2545 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261821AbTC0JAs>;
	Thu, 27 Mar 2003 04:00:48 -0500
Date: Thu, 27 Mar 2003 10:11:24 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: bert hubert <ahu@ds9a.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: [FIX] Re: 2.5.66 new fbcon oops while
 loading X
In-Reply-To: <Pine.LNX.4.44.0303262004080.21188-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.21.0303271010350.26358-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, James Simmons wrote:
> > On Tue, Mar 25, 2003 at 05:23:07PM +0000, James Simmons wrote:
> > > > While loading X, I get this oops. The weird thing is that I don't use
> > > > framebuffer. I compiled with gcc 3.2.2 but the code generated looks weird.
> > > > Virgin gcc 3.2.2 on a pentium III.
> > > 
> > > You don't use framebuffer? Can you send me your config. 
> > 
> > Ok, I've found the bug, it is in fb_open() in drivers/video/fbmem.c, it
> > needs this addition:
> > 
> >         if(fbidx >= FB_MAX)
> >                 return -ENODEV;
> > 
> > Without it, large minor numbers result in access beyond the end of
> > registered_fb.
> > 
> > On Debian, ls /dev/fb[67] results in:
> > crw--w--w-    1 root     tty       29, 192 Nov 30  2000 /dev/fb6
> > crw--w--w-    1 root     tty       29, 224 Nov 30  2000 /dev/fb7
> > 
> > On Red Hat this is: 
> > crw-------    1 root     root      29,   7 Apr 11  2002 /dev/fb7
> > crw-------    1 root     root      29,   8 Apr 11  2002 /dev/fb8
> > 
> > Which explains why many don't see this bug.
> 
> Ah. That explains it. I will apply the fix.

Note that Debian seems to use the old numbering that was obsoleted in 2.4.0.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

