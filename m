Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSGUVPK>; Sun, 21 Jul 2002 17:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSGUVPK>; Sun, 21 Jul 2002 17:15:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62730 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313711AbSGUVPK>; Sun, 21 Jul 2002 17:15:10 -0400
Date: Sun, 21 Jul 2002 22:18:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
Message-ID: <20020721221815.E26376@flint.arm.linux.org.uk>
References: <20020721214239.C26376@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207212307570.28392-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207212307570.28392-100000@localhost.localdomain>; from mingo@elte.hu on Sun, Jul 21, 2002 at 11:09:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 11:09:34PM +0200, Ingo Molnar wrote:
> using serial-2.5.26-3.diff, i get an oops here:
> 
> (gdb) list *0xc01b1f03
> 0xc01b1f03 is in serial_in (serial_8250.c:189).
> 184                     return readb(up->port.membase + offset);
> 185
> 186             default:
> 187                     return inb(up->port.iobase + offset);
> 188             }
> 189     }
> 190
> 191     static _INLINE_ void
> 192     serial_out(struct uart_8250_port *up, int offset, int value)
> 193     {
> (gdb)

Interesting.  Not had a report of that thus far.  Can you send me any
kernel messages relating to serial devices please, and the bad address
that caused the oops?  (line 189 is obviously a lie...)

> when echo-ing into a serial port, which is also set up for kernel serial
> console. (the kernel serial console produces no output.)

Weird.  Currently I've no idea what's causing this; I've been booting
machines with "console=ttyS0,115200n8" fine here with no noticable
problems.

Again, any useful kernel messages?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

