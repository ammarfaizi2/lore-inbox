Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbSKGWnJ>; Thu, 7 Nov 2002 17:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266628AbSKGWnJ>; Thu, 7 Nov 2002 17:43:09 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:5843 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266627AbSKGWnI>;
	Thu, 7 Nov 2002 17:43:08 -0500
Date: Thu, 7 Nov 2002 14:47:50 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       rmk@arm.linux.org.uk
Cc: Martin Diehl <lists@mdiehl.de>
Subject: [Serial 2.5]: packet drop problem (FE ?)
Message-ID: <20021107224750.GA699@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I've got two identical boxes (dual P6 200MHz) talking to each
other through serial IrDA dongles (each attached to the first serial
port).

	One side has 2.4.20-pre8 :
-------------------------------
# cat /proc/tty/driver/serial 
serinfo:1.0 driver:5.05c revision:2001-07-08
0: uart:16550A port:3F8 irq:4 baud:9600 tx:5249946 rx:120379 RTS|DTR
1: uart:16550A port:2F8 irq:3 tx:0 rx:0 
-------------------------------

	The other side has 2.5.46 :
----------------------------
# cat /proc/tty/driver/serial 
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:19541287 rx:14370938 fe:1384 RTS|DTR
1: uart:16550A port:000002F8 irq:3 tx:39761 rx:3 RTS|DTR
[...]
# setserial -a /dev/ttyS0
/dev/ttyS0, Line 0, UART: 16550A, Port: 0x03f8, IRQ: 4
        Baud_base: 115200, close_delay: 500, divisor: 0
        closing_wait: 30000
        Flags: spd_normal skip_test
----------------------------

	Problem : a noticeable number of large packet from 2.4.X to
2.5.X are dropped (and retransmitted), whereas almost no packet from
2.5.X to 2.4.X are dropped.
	I tried swapping the IrDA dongles themselves, and this didn't
make any difference. No other device/driver is using irq4. I also try
using a FIR as a sender, and I still see this packet dropped in Rx in
2.5.X. And this used to work properly way back when I had 2.4.X on
this box.
	I'm kind of suspicious about the "fe" number above. Could
anybody tell me a bit more about what "fe" means ?

	Thanks...

	Jean
