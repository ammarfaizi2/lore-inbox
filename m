Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbWHRQ7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbWHRQ7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbWHRQ7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:59:18 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47000 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030503AbWHRQ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:59:16 -0400
Subject: Re: R: How to avoid serial port buffer overruns?
From: Lee Revell <rlrevell@joe-job.com>
To: Giampaolo Tomassoni <g.tomassoni@libero.it>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <NBBBIHMOBLOHKCGIMJMDGEIMFNAA.g.tomassoni@libero.it>
References: <NBBBIHMOBLOHKCGIMJMDGEIMFNAA.g.tomassoni@libero.it>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 13:00:00 -0400
Message-Id: <1155920400.24907.63.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 10:48 +0200, Giampaolo Tomassoni wrote:
> > On Thu, 2006-08-17 at 00:19 +0100, Russell King wrote:
> > 
> > 
> > OK, thanks.  FWIW here is the serial board we are using:
> > 
> > http://www.moschip.com/html/MCS9845.html
> > 
> > The hardware guy says "The mn9845cv, have in default 2 serial ports and
> > one ISA bus, where we have connected the tl16c554, quad serial port."
> > 
> > Hopefully Ingo's latency tracer can tell me what is holding off
> > interrupts.
> 
> I beg your pardon: I'm not used that much to interrupts handling in Linux, but this piece of code from sound/drivers/serial-u16550.c in a linux-2.6.16:

OK, they are not using serial-u16550 but 8250_fourport for some reason:

# cat /proc/tty/driver/serial 
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:0 rx:0
1: uart:unknown port:000002B8 irq:5
2: uart:unknown port:000003E8 irq:4
3: uart:unknown port:000002E8 irq:3
4: uart:16550A port:0000DD00 irq:185 tx:234335 rx:47502 RTS|DTR
5: uart:16550A port:0000E300 irq:185 tx:249926 rx:27732 RTS|DTR
6: uart:16550A port:0000E400 irq:185 tx:120958 rx:0 RTS|DTR
7: uart:16550A port:0000D000 irq:185 tx:0 rx:0
8: uart:16550A port:0000D100 irq:185 tx:0 rx:0 RTS|DTR
9: uart:16550A port:0000D200 irq:185 tx:0 rx:123406 RTS|DTR

It looks like no overruns are reported, but I have to find out whether
they have reproduced the bug since the last reboot.

