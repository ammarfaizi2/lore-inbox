Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132487AbRDCDHq>; Mon, 2 Apr 2001 23:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132338AbRDCDHb>; Mon, 2 Apr 2001 23:07:31 -0400
Received: from avocet.prod.itd.earthlink.net ([207.217.121.50]:15082 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132494AbRDCDGx>; Mon, 2 Apr 2001 23:06:53 -0400
Date: Mon, 2 Apr 2001 19:04:57 -0700 (PDT)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <Pine.LNX.4.31.0104021837260.3867-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Is it possible that "jump scroll" would provide more performance benefit
>than an accelerated driver anyway?

I wouldn't rule it out. If someone wants to wipe up some code I would have
no problem testing it to see if it is worth it.

>Seeing as you bring up this topic of writing a 9525 driver.  It seems to
>me rather wasteful that you (collectively linux framebuffer authors),
>XFree86 and Berlin are all writing drivers for the same, hugely diverse
>class of hardware, to support more or less the same ops on the hardware.
>
>Isn't possible to pool the development effort of video drivers?  Doesn't
>X require basically the same set of operations as the kernel?  I.e.,
>initialise the card and video mode (usually the very complex part); do
>some rendering ops (usually fairly simple).  Sure, X provides a few more
>kinds of rendering op, but that part of the code is usually much simpler
>and smaller than the initialisation code.

Well the goal of each is very much different. Fbcon was developed to deal
the fact that most modern video hardware doesn't support text but graphical
based modes instead. VGA text is slowly going away. Since are goal is to
emulate a text console we just have to provide basic support to provide
just this. We need to

1) Draw basic text -> Glyph operations.

2) scrolling -> hardware panning or a copy area operation.

3) scroll a region of the screen -> copy area operation.

4) Clear the display or region of display -> fillrect

5) Set color palette.

6) Manage a hardware cursor.

7) Manage the current resolution for VC switching or a mode change vi
   VT_RESIZE or TIOCSWINSZ.

So fbcon is out of necessite. Now X you mean XFree86 which is really a OS
in itself. Its goal to do everything itself so it can run everywhere
know to mankind. As for Berlin I don't know the code so I can't say.
As people are finding out XFree86 doing everything itself is having
issues. A good example is the classic problem of X dying and you have to
reboot the machine. Also when under heavy load and you exit X to the
console you don't get the text mode. Well right now its tough luck and
just reboot your machine. A M$ solution but people have been doing it
so long they don't mind it. I hope to fix those problems for 2.5.X.
As you can see I think the OS should handle the transfer from console mode
to text mode and vice versa. Now for programming the accel engine to do
graphics in userland. Well their is nothing wrong that each does their own
thing. What does matter is their is a GIU independent kernel manager of
the graphics engine state. DRI attempts to handle this.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

