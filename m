Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVGLLJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVGLLJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVGLLJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:09:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44302 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261333AbVGLLIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:08:31 -0400
Date: Tue, 12 Jul 2005 12:08:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Message-ID: <20050712120825.E28413@flint.arm.linux.org.uk>
Mail-Followup-To: david-b@pacbell.net, linux-kernel@vger.kernel.org
References: <200507111922.04800.david-b@pacbell.net> <20050712081943.B25543@flint.arm.linux.org.uk> <20050712102512.A7F30BF3C9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050712102512.A7F30BF3C9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>; from david-b@pacbell.net on Tue, Jul 12, 2005 at 03:25:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 03:25:12AM -0700, david-b@pacbell.net wrote:
> > Date: Tue, 12 Jul 2005 08:19:43 +0100
> > From: Russell King <rmk+lkml@arm.linux.org.uk>
> >
> > On Mon, Jul 11, 2005 at 07:22:04PM -0700, David Brownell wrote:
> > > and stop
> > > whining about certain non-errors (details in the patch comments).
> >
> > Please explain what the whining is (details were missing from the
> > patch comments).
> 
> The kernel "recently" started issuing the second and third messages
> after initializing the serial port on for example an OSK board:
> 
>     ttyS0 at MMIO 0xfffb0000 (irq = 46) is a ST16654
>     serial8250 serial8250.0: unable to register port at index 1 (IO0 MEM0 IRQ47): -28
>     serial8250 serial8250.0: unable to register port at index 2 (IO0 MEM0 IRQ15): -28

Thanks, that's exactly what I wanted to know.

-28 is -ENOSPC which means that you've run out of available serial devices
to register these others.

If you wish to have three ports in an plat_serial8250_port array, you'll
need to ensure that CONFIG_SERIAL_8250_NR_UARTS is set to at least 3.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
