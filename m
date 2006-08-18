Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWHRRE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWHRRE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWHRRE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:04:59 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:7944 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030279AbWHRRE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:04:58 -0400
Date: Fri, 18 Aug 2006 18:04:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Fulghum <paulkf@microgate.com>
Subject: Re: R: How to avoid serial port buffer overruns?
Message-ID: <20060818170450.GC21101@flint.arm.linux.org.uk>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Giampaolo Tomassoni <g.tomassoni@libero.it>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Fulghum <paulkf@microgate.com>
References: <NBBBIHMOBLOHKCGIMJMDGEIMFNAA.g.tomassoni@libero.it> <1155920400.24907.63.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155920400.24907.63.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 01:00:00PM -0400, Lee Revell wrote:
> On Fri, 2006-08-18 at 10:48 +0200, Giampaolo Tomassoni wrote:
> > > On Thu, 2006-08-17 at 00:19 +0100, Russell King wrote:
> > > 
> > > 
> > > OK, thanks.  FWIW here is the serial board we are using:
> > > 
> > > http://www.moschip.com/html/MCS9845.html
> > > 
> > > The hardware guy says "The mn9845cv, have in default 2 serial ports and
> > > one ISA bus, where we have connected the tl16c554, quad serial port."
> > > 
> > > Hopefully Ingo's latency tracer can tell me what is holding off
> > > interrupts.
> > 
> > I beg your pardon: I'm not used that much to interrupts handling in Linux, but this piece of code from sound/drivers/serial-u16550.c in a linux-2.6.16:
> 
> OK, they are not using serial-u16550 but 8250_fourport for some reason:

Doesn't look like it.  fourport cards have their ports at 0x1a0..0x1bf
and 0x2a0..0x2bf, and have some special and non-standard features.

> # cat /proc/tty/driver/serial 
> serinfo:1.0 driver revision:
> 0: uart:16550A port:000003F8 irq:4 tx:0 rx:0
> 1: uart:unknown port:000002B8 irq:5
> 2: uart:unknown port:000003E8 irq:4
> 3: uart:unknown port:000002E8 irq:3
> 4: uart:16550A port:0000DD00 irq:185 tx:234335 rx:47502 RTS|DTR
> 5: uart:16550A port:0000E300 irq:185 tx:249926 rx:27732 RTS|DTR
> 6: uart:16550A port:0000E400 irq:185 tx:120958 rx:0 RTS|DTR
> 7: uart:16550A port:0000D000 irq:185 tx:0 rx:0
> 8: uart:16550A port:0000D100 irq:185 tx:0 rx:0 RTS|DTR
> 9: uart:16550A port:0000D200 irq:185 tx:0 rx:123406 RTS|DTR
> 
> It looks like no overruns are reported, but I have to find out whether
> they have reproduced the bug since the last reboot.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
