Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWFHLfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWFHLfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 07:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWFHLfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 07:35:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43019 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932289AbWFHLfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 07:35:47 -0400
Date: Thu, 8 Jun 2006 12:35:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patchset] Generic IRQ Subsystem: -V5
Message-ID: <20060608113534.GA5050@flint.arm.linux.org.uk>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>
References: <20060517001310.GA12877@elte.hu> <20060517221536.GA13444@elte.hu> <20060519145225.GA12703@elte.hu> <20060607165456.GC13165@flint.arm.linux.org.uk> <1149700829.5257.16.camel@localhost.localdomain> <1149706650.5257.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149706650.5257.19.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 08:57:30PM +0200, Thomas Gleixner wrote:
> On Wed, 2006-06-07 at 19:20 +0200, Thomas Gleixner wrote: 
> > > Is there an updated series?  This doesn't apply to -rc6 - it seems
> > > that maybe the ia64 folk merged some of the changes.
> > 
> > We did the latest changes against -mm. I can respin it against
> > 2.6.16-rc6.
> 
> http://www.tglx.de/projects/armirq/2.6.17-rc6/patch-2.6.17-rc6-armirq1.patches.tar.bz2
> http://www.tglx.de/projects/armirq/2.6.17-rc6/patch-2.6.17-rc6-armirq1.patch

Okay, works on Versatile (which is a trivial platform) it doesn't work
on Neponset (a rather more complex setup).  Neponset has a case where
there's an interrupt "concentrator" which consists of logically ORing
three interrupt sources, and providing a status register so you know
which occurred.

Hence, there is no "chip" for this, and while it works with the ARM
IRQ subsystem, it doesn't even boot with the genirq stuff.

This doesn't happen with the ARM IRQ subsystem because the "no chip"
handlers are all pointing at a dummy function instead of being NULL.
Could we do the same with genirq ?

SA1111 Microprocessor Companion Chip: silicon revision 1, metal revision 1
Trying to install chained interrupt type for IRQ51
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0204000
[00000000] *pgd=00000000
Internal error: Oops: 0 [#1]
Modules linked in:
CPU: 0
PC is at __init_begin+0x3fdf8000/0x30
LR is at __set_irq_handler+0xf4/0x110
pc : [<00000000>]    lr : [<c0258e6c>]    Not tainted
sp : c04dbdb4  ip : 60000093  fp : c04dbdd8
r10: c02577c4  r9 : 00000000  r8 : 00000001
r7 : 60000013  r6 : c0229234  r5 : 00000033  r4 : c040ecc0
r3 : c0416e38  r2 : 00000000  r1 : 00000629  r0 : 00000033
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C020717F  Table: C020717F  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc04da198)
[<c0258d78>] (__set_irq_handler+0x0/0x110) from [<c0229778>] (sa1111_setup_irq+0x10c/0x128)
[<c022966c>] (sa1111_setup_irq+0x0/0x128) from [<c0229b6c>] (__sa1111_probe+0x10c/0x1b4)
[<c0229a60>] (__sa1111_probe+0x0/0x1b4) from [<c0229f78>] (sa1111_probe+0x54/0x60)
[<c0229f24>] (sa1111_probe+0x0/0x60) from [<c0330b80>] (platform_drv_probe+0x20/0x24)
[<c0330b60>] (platform_drv_probe+0x0/0x24) from [<c032ebac>] (driver_probe_device+0x8c/0xd8)
[<c032eb20>] (driver_probe_device+0x0/0xd8) from [<c032ec08>] (__device_attach+0x10/0x14)
[<c032ebf8>] (__device_attach+0x0/0x14) from [<c032e1a0>] (bus_for_each_drv+0x54/0x84)
[<c032e14c>] (bus_for_each_drv+0x0/0x84) from [<c032ec70>] (device_attach+0x64/0x98)
[<c032ec0c>] (device_attach+0x0/0x98) from [<c032e30c>] (bus_add_device+0x30/0x88)
[<c032e2dc>] (bus_add_device+0x0/0x88) from [<c032d0f0>] (device_add+0xc8/0x14c)
[<c032d028>] (device_add+0x0/0x14c) from [<c032d190>] (device_register+0x1c/0x20)
[<c032d174>] (device_register+0x0/0x20) from [<c03309dc>] (platform_device_add+0xf8/0x16c)
[<c03308e4>] (platform_device_add+0x0/0x16c) from [<c0330ad0>] (platform_device_register+0x20/0x24)
[<c0330ab0>] (platform_device_register+0x0/0x24) from [<c0330750>] (platform_add_devices+0x2c/0x68)
[<c0330724>] (platform_add_devices+0x0/0x68) from [<c02121bc>] (neponset_init+0x7c/0x98)
[<c0212140>] (neponset_init+0x0/0x98) from [<c0208ae4>] (do_initcalls+0x68/0x128)
[<c0208a7c>] (do_initcalls+0x0/0x128) from [<c0208bc4>] (do_basic_setup+0x20/0x24)
[<c0208ba4>] (do_basic_setup+0x0/0x24) from [<c021f0b0>] (init+0x44/0x144)
[<c021f06c>] (init+0x0/0x144) from [<c023babc>] (do_exit+0x0/0x3c4)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
