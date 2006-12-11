Return-Path: <linux-kernel-owner+w=401wt.eu-S937554AbWLKTyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937554AbWLKTyQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937576AbWLKTyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:54:15 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4261 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937623AbWLKTyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:54:13 -0500
Date: Mon, 11 Dec 2006 19:54:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt][RESEND] fix preempt hardirqs on OMAP
Message-ID: <20061211195401.GA12440@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Walker <dwalker@mvista.com>,
	Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
	linux-kernel@vger.kernel.org
References: <20061210163545.488430000@mvista.com> <20061211190554.GA26392@elte.hu> <1165865908.8103.30.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165865908.8103.30.camel@imap.mvista.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 11:38:28AM -0800, Daniel Walker wrote:
> On Mon, 2006-12-11 at 20:05 +0100, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > +	/*
> > > +	 * Some boards will disable an interrupt when it
> > > +	 * sets IRQ_PENDING . So we have to remove the flag
> > > +	 * and re-enable to handle it.
> > > +	 */
> > > +	if (desc->status & IRQ_PENDING) {
> > > +		desc->status &= ~IRQ_PENDING;
> > > +		if (desc->chip)
> > > +			desc->chip->enable(irq);
> > > +		goto restart;
> > > +	}
> > 
> > what if the irq got disabled meanwhile? Also, chip->enable is a 
> > compatibility method, not something we should use in a flow handler.
> 
> I don't know how other arches deal with IRQ_PENDING, but ARM (OMAP at
> least) disables the IRQ on IRQ_PENDING.

Please point out where it's doing that, and I'll take a look to see
if it's doing something it shouldn't.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
