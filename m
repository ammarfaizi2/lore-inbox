Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVKJKo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVKJKo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 05:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVKJKo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 05:44:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24332 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750768AbVKJKo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 05:44:28 -0500
Date: Thu, 10 Nov 2005 10:44:19 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backup timer for UARTs that lose interrupts
Message-ID: <20051110104419.GA20693@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Williamson <alex.williamson@hp.com>,
	linux-kernel@vger.kernel.org
References: <1131481677.8541.24.camel@tdi> <20051108232316.GH13357@flint.arm.linux.org.uk> <1131495392.9657.9.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131495392.9657.9.camel@tdi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 05:16:32PM -0700, Alex Williamson wrote:
>   I was hoping that would be the solution too.  I just tried enabling
> UART_BUG_TXEN to double check my previous results.  Somehow it makes the
> problem much, much worse.  Instead of being the nuisance it usually is,
> it seems like the UART gets way behind on transmitting bits.  So it
> would probably prevent the unattended reboot stall since we kick it
> every time we want to transmit, but it renders the UART completely
> unusable as a console.  I can't even get it caught up enough to login
> via the serial console w/ UART_BUG_TXEN enabled on the port.  Thanks,

Ok, would you mind fixing the patch so it isn't screwing up the
default use of up->timer please?  You may notice that this timer
is already used, and overwriting up->timer.function is a one-way
process in your patch (which kills off the point of serial8250_timeout).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
