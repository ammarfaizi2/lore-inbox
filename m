Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVCMVLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVCMVLj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 16:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVCMVLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 16:11:39 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:43125 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261459AbVCMVLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 16:11:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Dp6LuXoHCSHaG7wO2oj2fkFhpbQPKpqaNC1LLtSuueozzXwhnI8Cj/LGWIGXwlM7EWXZwm3zlQso0WUNxe4lpeHjTAahDYYstSybD3hTgRlwIWYaoC9ajCyfvbcZFKn8oCSfaL/IIVdrPEA5n+eTnucxjE75s0Sr2K5gSDdSlBc=
Message-ID: <9e47339105031311242c7f9597@mail.gmail.com>
Date: Sun, 13 Mar 2005 14:24:50 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer Splash
Cc: Pavel Machek <pavel@ucw.cz>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
In-Reply-To: <Pine.LNX.4.62.0503131953090.3876@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050308015731.GA26249@spock.one.pl>
	 <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
	 <1110392212.3116.215.camel@localhost.localdomain>
	 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
	 <1110408049.9942.275.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>
	 <20050310145419.GD632@openzaurus.ucw.cz>
	 <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
	 <20050313182032.GA1427@elf.ucw.cz>
	 <Pine.LNX.4.62.0503131953090.3876@numbat.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2005 19:53:55 +0100 (CET), Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, 13 Mar 2005, Pavel Machek wrote:
> > > > > > Thats why moving the eye candy console into user space is such a good
> > > > > > idea. You don't have to run it 8) It also means that the console
> > > > > > development is accessible to all the crazy rasterman types.
> > > > >
> > > > > Yep. The basic console we already have. Everyone who wants eye candy can switch
> > > > > from basic console to user space console in early userspace.
> > > > >
> > > >
> > > > Heh, I'm afraid it does not work like that. Anyone who wants eye-candy
> > > > simply applies broken patch to their kernel... unless their distribution applied one
> > > > already.
> > > >
> > > > Situation where we have one working eye-candy patch would certainly
> > > > be an improvement.
> > >
> > > Why do we need patches in the kernel. Just set you config to
> > > CONFIG_DUMMY_CONSOLE, CONFIG_FB, CONFIG_INPUT and don't set fbcon or
> > > vgacon. Then have a userspace app using /dev/fb and /dev/input create a
> > > userland console. There is no need to do special hacks in the kernel.
> >
> > Except that I'll not get usefull reports from Oopsen and panic's,
> > right? Ideally I'd also like high-priority kernel messages to be
> > displayed during boot.
> 
> Indeed. I thought the idea was to use the existing fbcon support to draw
> emergency messages to the screen.

That is the idea. I would like to even simplify the fbcon/dev even
more in this model and remove all in-kernel acceleration in fbdev. 
The user space console would be fully accelerated using DRM. If we
aren't using fbcon for normal console then it doesn't need to be
accelerated and that source of conflicts can be removed. fbcon would
be used for system recovery, OOPs, boot, kdbg, etc only kernel use, no
normal logins.


> 
> Gr{oetje,eeting}s,
> 
>                                                 Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


-- 
Jon Smirl
jonsmirl@gmail.com
