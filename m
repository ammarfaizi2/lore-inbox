Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132666AbRC2Ehh>; Wed, 28 Mar 2001 23:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132667AbRC2Eh1>; Wed, 28 Mar 2001 23:37:27 -0500
Received: from albatross.prod.itd.earthlink.net ([207.217.120.120]:38819 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132666AbRC2EhW>; Wed, 28 Mar 2001 23:37:22 -0500
Date: Wed, 28 Mar 2001 20:37:46 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Bruno Avila <jisla@elogica.com.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Plans for 2.5
Message-ID: <Pine.LNX.4.31.0103282010380.1748-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  I got some questions. When are we going to develop stuff for 2.5? What
>is planed? My opinion for linux 2.5 should be performance. Since linux
>already is stable or well done for nature, we could thing more on
>performance to be a diferencial over others. What do you people thing?

2.5.X will start once Linus see 2.4.X being stable enough for him to move
on.

       For me I'm working on rewriting the console layer. The two
biggest parts to this are one cleanup of the fbcon layer to be much
smaller and leaner. This is very much needed especially for graphical
embedded devices that need as small a kernel as possible. We also need
to deal with the latency issues fbcon suffer so badly from. Part of the
changes is that each fbdev driver will have console code moved out of
it and into fbcon.c. This makes for a much smaller and faster fbdev
driver. Another bonus for this is it is possible to the /dev/fb interface
and not use fbcon. This means you can use vgacon and open /dev/fb and have
a graphical session and then close it and get back to vgacon. This is a
nice feature especially when debugging fbdev drivers. A even more
important function for this is again embedded devices. Most graphical
embedded devices have a graphical display but no keyboard. Instead they
use a touch screen. Here a framebuffer console doesn't make sense. What
does make sense is if we have /dev/fb and a /dev/event interface for the
touch screen. Here we would then use for the console a serial port or
maybe even a network console driver.
    The second part is is the porting of all the input devices over to the
input api. This allows for a consistant api for all input devices. This
will greatly cleanup up the mess of drivers/char/keyboard.c. The code in
keyboard.c will grab events from keybaord input devices and send them to
the correct VT. Again this is very important for embedded devices. Since a
large part of X server design is centered around the idea of input devices
this will allow the developement of micro X servers. Also with the
/dev/eventX interface we can have direct input for glut with OpenGL. Like
direct rendering you will get a enormous performance boost. This will very
important for porting linux over to game consoles. It will also allow
for fast gaming or more the more serious better interactivity for things
like molecular simulators on PCs using linux. For embedded devices that
can't afford to run X it can directly use /dev/fb and /dev/event without the
need to mess around with the console system. Also the micro X servers
will not have to as well mess with the console system as well. Of course
smaller leaner graphical systems will come to the PC as well. Meaning much
better X servers in the future (*hint hint*) :-)

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

