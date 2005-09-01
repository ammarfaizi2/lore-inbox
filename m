Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbVIAVrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbVIAVrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVIAVrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:47:22 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40151 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030417AbVIAVrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:47:21 -0400
Date: Thu, 1 Sep 2005 14:47:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/1] 8250_kgdb driver reworked
Message-ID: <20050901214720.GU3966@smtp.west.cox.net>
References: <20050901190251.GS3966@smtp.west.cox.net> <1125611874.15768.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125611874.15768.79.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 10:57:54PM +0100, Alan Cox wrote:
> > +static irqreturn_t
> > +kgdb8250_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> > +{
> > +	char iir;
> > +
> > +	if (irq != KGDB8250_IRQ)
> > +		return IRQ_NONE;
> 
> How can this occur - you gave the IRQ number in the register_irq. WHy
> test for it, and if it occurs why not BUG()

Early sanity tests, dropped.

> > +	/*
> > +	 * If  there is some other CPU in KGDB then this is a
> > +	 * spurious interrupt. so return without even checking a byte
> > +	 */
> > +	if (atomic_read(&debugger_active))
> > +		return IRQ_NONE;
> > +
> 
> Shared IRQ -> hung box. 

Can you elaborate a bit more please?  When we're actually in KGDB and
working on stuff we're polling so it's really just the
GDB-is-interrupting case.

> Also lose the ugly confusing macros like CURRENTPORT please to follow
> kernel style better. In fact why not keep a pointer to the 'current'
> uart to get tighter code too ?

Sure, why not.

-- 
Tom Rini
http://gate.crashing.org/~trini/
