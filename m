Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262601AbSJEU7h>; Sat, 5 Oct 2002 16:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262610AbSJEU7h>; Sat, 5 Oct 2002 16:59:37 -0400
Received: from 62-190-219-86.pdu.pipex.net ([62.190.219.86]:55814 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262601AbSJEU7e>; Sat, 5 Oct 2002 16:59:34 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210052112.g95LC23B002031@darkstar.example.net>
Subject: Re: 2.5.x and 8250 UART problems
To: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 5 Oct 2002 22:12:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021005205954.A1682@flint.arm.linux.org.uk> from "Russell King" at Oct 05, 2002 08:59:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The 486 SX-20 with 4 MB RAM, running 2.2.21 reliably achieves about 650
> > BPS download from another machine, with the port runnnig at 9600 bps.
> > With 2.5.40, many characters are lost at 9600, making, e.g. a ZModem
> > transfer retry for almost every block.

OK, first of all, I was wrong about it being an 8250 UART, I checked, and it is infact a 16540, not that it should make much difference, anyway :-)

> Ok, we need to find out where stuff is getting dropped.  Dumping
> /proc/tty/driver/serial is always a good idea when reporting anything
> like this.
> 
> The important thing is the change in the counters.  Can you supply the
> port in question both before and after the zmodem run please?

OK, here goes, I used RZ on the command line instead of Minicom on the laptop, to maximize available memory.

---

Using 2.2.21 on the 486 laptop:

Laptop, (just booted):

0: uart:16450 port:3F8 irq:4 tx:0 rx:0 CTS|DTR|DSR

Desktop: 

1: uart:16550A port:000002F8 irq:3 tx:946840 rx:5516126 RTS|CTS|DTR|DSR

Now transfer a 64K file using Z-modem.

Laptop:

0: uart:16450 port:3F8 irq:4 baud:9600 tx:104 rx:66050 CTS|DSR

Desktop:

1: uart:16550A port:000002F8 irq:3 tx:1012890 rx:5516209 RTS|DTR

---

Using 2.5.40 on the laptop:

Laptop, (just booted):

0: uart:16450 port:000003F8 irq:4 tx:0 rx:0 CTS|DSR

Desktop: 

1: uart:16550A port:000002F8 irq:3 tx:1012890 rx:5516209 RTS|DTR

Now transfer a 64K file using Z-modem.

Contrary to what I originally thought, it did drop characters during disk access, but then it seemed to continue, only to drop characters again a second later.

Laptop:

0: uart:16450 port:000003F8 irq:4 tx:230 rx:73291 oe:45 CTS|DSR

Desktop:

1: uart:16550A port:000002F8 irq:3 tx:1086246 rx:5516439 RTS|DTR

---

I am begining to wonder whether it is something straightforward, like the newer kernel being more bloated, and therefore not being cached so well, causing the machine to run generally slower.

I remember seeing dropped characters with a bloated 2.2.13 kernel on that machine.

However, when I upgraded the other laptop from 2.2.x to 2.4.x, I saw an improvement in serial port performance, from an average of ~650 cps to ~950 cps.  Although I also upgraded glibc at the same time.  Seems like there are a lot of variables, sorry about that!  :-)

Hope the above info is helpful.  If you need me to do any more tests, or some with the other machine, let me know.

Cheers,

John.
