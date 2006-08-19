Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWHSJwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWHSJwS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 05:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWHSJwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 05:52:18 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:48653 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751692AbWHSJwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 05:52:17 -0400
Date: Sat, 19 Aug 2006 10:52:10 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: jean-paul.saman@philips.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] UART driver for PNX8550/8950 revised
Message-ID: <20060819095210.GD25767@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vitalywool@gmail.com>,
	jean-paul.saman@philips.com, linux-kernel@vger.kernel.org
References: <20060819122600.000017e6.vitalywool@gmail.com> <20060819090427.GB25767@flint.arm.linux.org.uk> <acd2a5930608190234y4b4bee8dqfc17d109f86d4318@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd2a5930608190234y4b4bee8dqfc17d109f86d4318@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 01:34:26PM +0400, Vitaly Wool wrote:
> Hello Russell,
> >serial_pnx8xxx.h just contains structure and register definitions for
> >this driver - wouldn't it make more sense for it to be in drivers/serial
> >along side this driver?
> 
> Well it's used in arch/mips/philips/... so I doubt it's a right thing
> to move it to drivers/serial.

Okay, then it should stay where it is.

> >> +     /*
> >> +      * Disable all interrupts, port and break condition.
> >> +      */
> >> +     serial_out(sport, PNX8XXX_IEN, 0);
> >
> >This comment's not correct - where is the break condition disabled?
> >I thought it might be in the next serial_out() but it seems to be
> >missing from there as well?
> 
> I don't think you're right here - break condition is also disabled
> unsetting the corresponding bit in  IEN register for this particular
> UART.

Hmm, in that case why does break_ctl do this:

+       lcr = serial_in(sport, PNX8XXX_LCR);
+       if (break_state == -1)
+               lcr |= PNX8XXX_UART_LCR_TXBREAK;
+       else
+               lcr &= ~PNX8XXX_UART_LCR_TXBREAK;
+       serial_out(sport, PNX8XXX_LCR, lcr);

which appears to imply that the bit for the break state is in the LCR.
Moreover, there isn't a PNX8XXX_INT_* bit defined for break.  Confused.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
