Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSGUVSg>; Sun, 21 Jul 2002 17:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSGUVSf>; Sun, 21 Jul 2002 17:18:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23959 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S314707AbSGUVSc>;
	Sun, 21 Jul 2002 17:18:32 -0400
Date: Sun, 21 Jul 2002 23:20:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
In-Reply-To: <20020721221815.E26376@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207212317510.28593-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jul 2002, Russell King wrote:

> > (gdb) list *0xc01b1f03
> > 0xc01b1f03 is in serial_in (serial_8250.c:189).
> > 184                     return readb(up->port.membase + offset);
> > 185
> > 186             default:
> > 187                     return inb(up->port.iobase + offset);
> > 188             }
> > 189     }
> > 190
> > 191     static _INLINE_ void
> > 192     serial_out(struct uart_8250_port *up, int offset, int value)
> > 193     {
> > (gdb)
> 
> Interesting.  Not had a report of that thus far.  Can you send me any
> kernel messages relating to serial devices please, and the bad address
> that caused the oops?  (line 189 is obviously a lie...)

i believe it was the inb's dereference.

i dont have the oops around anymore, since serial logging is not working
;-) Had to write it down from screen.

> > when echo-ing into a serial port, which is also set up for kernel serial
> > console. (the kernel serial console produces no output.)
> 
> Weird.  Currently I've no idea what's causing this; I've been booting
> machines with "console=ttyS0,115200n8" fine here with no noticable
> problems.
> 
> Again, any useful kernel messages?

will reproduce and write down the full oops - it was an illegal
dereference on 0xfffffff8 (-8 offset of a NULL pointer) or something like
that.

my serial setup is:

        append="console=ttyS1,115200 console=tty0"

old serial driver:

 Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
 SERIAL_PCI enabled
 ttyS00 at 0x03f8 (irq = 4) is a 16550A
 ttyS01 at 0x02f8 (irq = 3) is a 16550A

i'm pretty sure it hung when i echoed to ttyS1 - not 100% sure though.

	Ingo

