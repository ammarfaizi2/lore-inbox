Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVCZPKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVCZPKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 10:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVCZPKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 10:10:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25612 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261811AbVCZPKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 10:10:10 -0500
Date: Sat, 26 Mar 2005 15:10:05 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Luca <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <20050326151005.D12809@flint.arm.linux.org.uk>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Luca <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org
References: <20050325202414.GA9929@dreamland.darkstar.lan> <20050325203853.C12715@flint.arm.linux.org.uk> <20050325210132.GA11201@dreamland.darkstar.lan> <Pine.LNX.4.61.0503261115480.28431@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0503261115480.28431@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Sat, Mar 26, 2005 at 11:16:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 11:16:09AM +0100, Jan Engelhardt wrote:
> >Well, serial_core seems to think so:
> >
> >Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> >ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
> >ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
> >ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
> 
> Does it work if you set the baud rate manually, as a bootloader option?

Doesn't matter.  The problem is that dwmw2's NS16550A patch (from ages
ago) changes the prescaler setting for this device so we can use the
higher speed baud rates.  This means any programmed divisor (programmed
at early serial console initialisation time) suddenly becomes wrong as
soon as we fiddle with the prescaler during normal UART initialisation
time.

I think the argument for not initialising serial console _until_ after
UART initialisation time is gaining more technical merit:

1. spinlock initialisation issues (see other threads)
2. prescaler/divisor interaction issues (this thread)

even though it isn't _that_ desirable.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
