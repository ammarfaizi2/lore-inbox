Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVHOUyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVHOUyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVHOUyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:54:24 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12817 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964960AbVHOUyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:54:23 -0400
Date: Mon, 15 Aug 2005 22:54:18 +0200
From: Willy TARREAU <willy@w.ods.org>
To: mustang4@free.fr
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Hang or stop after uncompressing MPC8245
Message-ID: <20050815205418.GA1745@pcw.home.local>
References: <1124122213.4300be659dc89@imp5-q.free.fr> <20050815155505.GF20363@alpha.home.local> <1124125002.4300c94a31810@imp5-q.free.fr> <20050815165141.GA29660@alpha.home.local> <1124136498.4300f6321bb1b@imp5-q.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124136498.4300f6321bb1b@imp5-q.free.fr>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 10:08:18PM +0200, mustang4@free.fr wrote:
> Thanks Willy,
> 
> So i just compile a new Kernel with options we have talking about...
> And it's freeze, nothing to the console...
> 
> So i need to find the way to enable the Level-Triggered Interrupts in the kernel
> to the right IRQ address...

sorry, but I did not find much more info either. I don't know how to change those
IRQs from edge to level. It is from software, on the board itself ? I don't know.
I found interesting pieces of code there :

   # grep -r IRQ_SENSE /usr/src/linux-2.4.31/arch/ppc/kernel

They seem to imply that the interrupt mode (level/edge) is read from somewhere at
boot, but I have no idea where. May be they can be configured from the boot loader ?

> I read the thread... but i can't find the thing to change in kernel source or
> kernel configuration.
> 
> Or perhaps i enable to many option in
> "Device Drivers  --->" "Character devices-->" "Serial drivers  --->"
> <*> 8250/16550 and compatible serial support                     x x
>   x x    [*]   Console on 8250/16550 and compatible serial port           x x
>   x x    (4)   Maximum number of non-legacy 8250/16550 serial ports       x x
>   x x    [*]   Extended 8250/16550 serial driver options                  x x
>   x x    [*]     Support more than 4 legacy serial ports                  x x
>   x x    [*]     Support for sharing serial interrupts                    x x
>   x x    [ ]     Autodetect IRQ on standard ports (unsafe)                x x
>   x x    [*]     Support special multiport boards                         x x
>   x x    [*]     Support RSA serial ports
> 
> Try autodetect IRQ ?
> I'll try to learn more about  edge/level irq sharing...

well, I still do not know how the serial driver manages to find those specific
addresses. You should ask one of the people involved in the previous threads,
he might have more clue.

Regards,
Willy

> 
> Yann
> 
> > Hi,
> >
> > On Mon, Aug 15, 2005 at 06:56:42PM +0200, mustang4@free.fr wrote:
> > > Hi,
> >
> > > This is what my board say (in console mode) about serial address:
> > > 0x08 COM1             DUART8245    0xfc004500 0x07a12000 0x00000001
> > 0x01effc70
> > > 0x09 COM2             DUART8245    0xfc004600 0x07a12000 0x00000001
> > 0x01e107d0
> >
> > Have you read this thread ?
> >
> >   http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019482.html
> >
> > It discusses your about your board, on which interrupts must be set to LEVEL
> > and not EDGE. BTW, they also used 8250. I don't know how you have to
> > configure
> > the serial ports though.
> >
> > This boot log also confirms that you have to use 8250/16550 :
> >
> >   http://mhonarc.axis.se/jffs-dev/msg01350.html
> >
> > > >   - are you sure that you enabled "console on serial port" in the config
> > ?
> > > Yes, i enable " Support for console on virtual terminal" but i enable
> > > "Non-standard serial port support" option too...
> > > So i recompile without the last one... and i recompile "with Serial drivers
> > > --->" "[*]   Console on 8250/16550 and compatible serial port" perhaps it's
> > > that... And i came back to you.
> > > But, perhaps i've allready tested... i ll check.. it's not a default option
> > ?
> >
> > It's not necessarily a default option. There are many console and serial
> > ports combination available. BTW, you could also try netconsole which will
> > send you the console data over an ethernet port if you cannot get the serial
> > to work.
> >
> > > >   - how can you be certain that the serial will appear on ttyS0 and not
> > ttyS1
> > > >     or another one (the kernel might detect another serial port which it
> > > >     assigns ttyS0)
> > > I pass parameter directly to the kernel;
> >
> > ok.
> >
> > > Another option i set :
> > >  Default bootloader kernel arguments  x x  x x(console=ttyS0,9600
> > console=tty0
> >
> > ok.
> >
> > Regards,
> > Willy
> >
> >
> 
