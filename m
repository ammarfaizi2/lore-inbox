Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966769AbWKTVVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966769AbWKTVVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966771AbWKTVVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:21:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:42219 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S966769AbWKTVV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:21:29 -0500
X-Authenticated: #20450766
Date: Mon, 20 Nov 2006 22:21:27 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Alan <alan@lxorguk.ukuu.org.uk>, Stefan Roese <ml@stefan-roese.de>,
       linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
In-Reply-To: <20061120130455.GB22330@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.60.0611202210400.5957@poirot.grange>
References: <200611201200.36780.ml@stefan-roese.de>
 <20061120114248.60bb0869@localhost.localdomain> <200611201255.37754.ml@stefan-roese.de>
 <20061120121015.2fb667d0@localhost.localdomain> <20061120130455.GB22330@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Russell King wrote:

> > On Mon, 20 Nov 2006 12:54:32 +0100 (MET)
> > Stefan Roese <ml@stefan-roese.de> wrote:
> > > Let's see, if I got this right. You mean that on such a platform, where 0 is a 
> > > valid physical IRQ, we should assign another value as virtual IRQ number (not 
> > > 0 and not -1 of course). And then the platform "pic" implementation should 
> > > take care of the remapping of these virtual IRQ numbers to the physical 
> > > numbers.
> 
> Since IRQ0 is not valid, can we arrange for the generic interrupt
> infrastructure to always fail it's allocation, and then remove the
> utterly unused bloatful irq_desc[0] ?
> 
> Didn't think so since x86 folk would scream.  Wait a moment, x86 can
> map IRQ0 to some other number for the timer interrupt, just like
> other architectures are being forced to map their UART interrupts.

I think, what Russell means, is this:

#define is_real_interrupt(irq) ((irq) != NO_IRQ)

where the NO_IRQ macro has been introduced a LONG time ago specifically 
for this purpose, and is conveniently defined on some platforms to 
(unsigned int)-1 or similar, including asm-powerpc/irq.h. And yes, this 
has been discussed MANY times.

Thanks
Guennadi
---
Guennadi Liakhovetski
