Return-Path: <linux-kernel-owner+w=401wt.eu-S937559AbWLKTxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937559AbWLKTxq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937601AbWLKTxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:53:46 -0500
Received: from nlpi012.sbcis.sbc.com ([207.115.36.41]:50924 "EHLO
	nlpi012.sbcis.sbc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937559AbWLKTxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:53:45 -0500
X-ORBL: [67.117.73.34]
Date: Mon, 11 Dec 2006 11:53:04 -0800
From: Tony Lindgren <tony@atomide.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt][RESEND] fix preempt hardirqs on OMAP
Message-ID: <20061211195303.GA6693@atomide.com>
References: <20061210163545.488430000@mvista.com> <20061211190554.GA26392@elte.hu> <1165865908.8103.30.camel@imap.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165865908.8103.30.camel@imap.mvista.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Daniel Walker <dwalker@mvista.com> [061211 11:41]:
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
> least) disables the IRQ on IRQ_PENDING. The problem is that by threading
> the IRQ we take some control away from the low level code, which needs
> to be replaced.
> 
> I'm open to potentially removing the irq disable()->enable() cycle on
> IRQ_PENDING if it's only done on OMAP. My feeling is that it's in other
> ARM's which would make that change more invasive, but I haven't actually
> researched that.

Hmm, I wonder if this is just legacy left over from earlier when
set_irq_type() was used and the flags not passed with request_irq().
This was causing some omap gpio interrupts to trigger immediately
after request_irq().

Regards,

Tony
