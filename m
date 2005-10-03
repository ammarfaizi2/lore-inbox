Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVJCPXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVJCPXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVJCPXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:23:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35592 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932279AbVJCPXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:23:31 -0400
Date: Mon, 3 Oct 2005 16:23:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: basicmark@yahoo.com, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] SPI subsystem
Message-ID: <20051003152312.GH16717@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>, basicmark@yahoo.com,
	arjan@infradead.org, linux-kernel@vger.kernel.org
References: <20051003105748.213.qmail@web33014.mail.mud.yahoo.com> <1128337656.17024.10.camel@laptopd505.fenrus.org> <20051003151457.AD64FEE8CE@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003151457.AD64FEE8CE@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 08:14:57AM -0700, David Brownell wrote:
> > From: Arjan van de Ven <arjan@infradead.org>
> > Date: Mon, 03 Oct 2005 13:07:36 +0200
> >
> > please NEVER EVER do dma from or to a stack variable. It's not allowed
> > on all architectures and it is really really bad practice in general
> > anyway. 
> 
> Arjan, could you mention some Linuxes which don't allow it?
> 
> Every time the topic of DMA to/from stack comes up, the advice is
> always to avoid it ... but so far as I recall, nobody's yet provided
> us with an example where it actually doesn't work.
> 
> Failing such examples, it's normal to discount such dire warnings and
> just plan to apply the relevant minor tweaks if/when they're needed.

I believe the issue is that you can't properly control the alignment
to ensure that you don't inadvertantly dirty the cache lines
corresponding with the memory you're performing DMA to/from.

Eg, on ARM, if the memory you're DMAing to/from is just above the
next stack location which will be used when you call a sub-function,
you'll have just undone the effects of the DMA API.  Provided GCC
decided to arrange the stack that way.

Or maybe there's a local variable right next to the DMA region.
Same effect.

However, who knows how different gcc versions will lay out the
stack?  That's completely up to the compilers whims.

So, if you want portable code and don't want random failures,
avoid DMA to/from the stack.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
