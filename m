Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424015AbWKKPaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424015AbWKKPaQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 10:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424016AbWKKPaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 10:30:16 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:22033 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1424015AbWKKPaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 10:30:14 -0500
Date: Sat, 11 Nov 2006 15:30:05 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ttyS0 not working any more, LSR safety check engaged
Message-ID: <20061111153005.GA28277@flint.arm.linux.org.uk>
Mail-Followup-To: Marc Haber <mh+linux-kernel@zugschlus.de>,
	linux-kernel@vger.kernel.org
References: <20061111114352.GA9206@torres.l21.ma.zugschlus.de> <20061111115016.GA24112@flint.arm.linux.org.uk> <20061111123455.GB9206@torres.l21.ma.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061111123455.GB9206@torres.l21.ma.zugschlus.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 01:34:55PM +0100, Marc Haber wrote:
> On Sat, Nov 11, 2006 at 11:50:16AM +0000, Russell King wrote:
> > Maybe something to do with PNP?  Maybe ACPI?  Both of those I know
> > nothing about, but I suggest that if you have PNP enabled, you
> > build and use the 8250_pnp module, even if your port is detected
> > by the legacy detection methods in 8250.
> 
> How do I configure that?
> 
> I have:
>   ? ?<*> 8250/16550 and compatible serial support                         ? ?
>   ? ?[*]   Console on 8250/16550 and compatible serial port               ? ?
>   ? ?<*>   8250/16550 PCI device support                                  ? ?
>   ? ?<*>   8250/16550 PNP device support                                  ? ?

That's fine.

> $ grep -i 'nov 11.*\(8250\|serial\|ttyS\|pnp\)' /var/log/syslog/syslog
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 15 devices
> PnPBIOS: Disabled by ACPI PNP
> pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
> pnp: 00:0d: ioport range 0x1000-0x107f could not be reserved
> pnp: 00:0d: ioport range 0x1100-0x113f has been reserved
> pnp: 00:0d: ioport range 0x1200-0x121f has been reserved
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

ttyS0 detected via legacy ISA probes.

> serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A

ttyS2 detected via legacy ISA probes.

> 00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

ttyS0 detected via PNP device 00:02.

> ttyS0: LSR safety check engaged!
> ttyS2: LSR safety check engaged!

and then it mysteriously disappears on us.

It's certainly a mystery.  Suggest you git bisect to find the offending
change - I doubt it'll be serial/8250 itself.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
