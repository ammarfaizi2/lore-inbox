Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbVKIAPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbVKIAPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbVKIAPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:15:24 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:43230 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1030443AbVKIAPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:15:22 -0500
Subject: Re: [PATCH] backup timer for UARTs that lose interrupts
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051108232316.GH13357@flint.arm.linux.org.uk>
References: <1131481677.8541.24.camel@tdi>
	 <20051108232316.GH13357@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 08 Nov 2005 17:16:32 -0700
Message-Id: <1131495392.9657.9.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 23:23 +0000, Russell King wrote:
> On Tue, Nov 08, 2005 at 01:27:57PM -0700, Alex Williamson wrote:
> > Hi Russell,
> > 
> >    The patch below works around a minor bug found in the UART of the
> > remote management card used in many HP ia64 and parisc servers (aka the
> > Diva UARTs).
> 
> Would setting UART_BUG_TXEN help ?
> 
> UART_BUG_TXEN is set for ports which need a kick up their backsides
> to get their transmit interrupt status asserted, so that when new
> chars are placed in the ring buffer we start transmitting them.
> 
> Your problem sounds very similar to this.

  I was hoping that would be the solution too.  I just tried enabling
UART_BUG_TXEN to double check my previous results.  Somehow it makes the
problem much, much worse.  Instead of being the nuisance it usually is,
it seems like the UART gets way behind on transmitting bits.  So it
would probably prevent the unattended reboot stall since we kick it
every time we want to transmit, but it renders the UART completely
unusable as a console.  I can't even get it caught up enough to login
via the serial console w/ UART_BUG_TXEN enabled on the port.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

