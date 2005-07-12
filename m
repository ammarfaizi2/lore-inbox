Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVGLMEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVGLMEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVGLMCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:02:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16659 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261377AbVGLMBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:01:23 -0400
Date: Tue, 12 Jul 2005 13:01:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Message-ID: <20050712130119.A30358@flint.arm.linux.org.uk>
Mail-Followup-To: david-b@pacbell.net, linux-kernel@vger.kernel.org
References: <200507111922.04800.david-b@pacbell.net> <20050712081943.B25543@flint.arm.linux.org.uk> <20050712102512.A7F30BF3C9@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <20050712120825.E28413@flint.arm.linux.org.uk> <20050712113212.0C90EBF3D5@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050712113212.0C90EBF3D5@adsl-69-107-32-110.dsl.pltn13.pacbell.net>; from david-b@pacbell.net on Tue, Jul 12, 2005 at 04:32:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 04:32:12AM -0700, david-b@pacbell.net wrote:
> > >     ttyS0 at MMIO 0xfffb0000 (irq = 46) is a ST16654
> > >     serial8250 serial8250.0: unable to register port at index 1 (IO0 MEM0 IRQ47): -28
> > >     serial8250 serial8250.0: unable to register port at index 2 (IO0 MEM0 IRQ15): -28
> >
> > Thanks, that's exactly what I wanted to know.
> >
> > -28 is -ENOSPC which means that you've run out of available serial devices
> > to register these others.
> 
> The idea is _not_ to register them on boards that only have a
> single RS232 connector.  The fix was just having the 8250 code
> understand that it should only register ports that are real.

The tty code doesn't work like that.  You must know how many ports
you want right from the start.  You can't dynamically add new ports
to an already registered driver without first unregistering all the
existing ports, unregistering the driver, adjusting the number of
ports, reregistering the driver and all the ports.

If you've got one already open, your only option in that case is to
ignore any attempt to add new ports.

Obviously this is not acceptable.  So please don't try to dictate
what serial should do.  It does things the way it does them to work
around other bits of the kernel which are lacking in various ways.

> > If you wish to have three ports in an plat_serial8250_port array, you'll
> > need to ensure that CONFIG_SERIAL_8250_NR_UARTS is set to at least 3.
> 
> That is, there's no third way which (a) doesn't waste that memory,
> and (b) doesn't produce annoying messages about non-error cases?

Correct.

> ISTR that having NR_UARTS bigger just produced different messages...

Which were?

It works for me on my platforms here, and everyone else on x86.  I
even had a situation where I had NR_UARTS set to 64 but only one
registered... which also worked fine with no extraneous kernel
messages.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
