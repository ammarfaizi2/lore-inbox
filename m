Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWE3Xzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWE3Xzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWE3Xzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:55:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:6545 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932241AbWE3Xzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:55:50 -0400
Date: Tue, 30 May 2006 16:53:18 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530235318.GB26478@kroah.com>
References: <20060530022925.8a67b613.akpm@osdl.org> <adawtc34364.fsf@cisco.com> <20060530154521.d737cc65.akpm@osdl.org> <20060530224955.GA5500@elte.hu> <20060530225254.GA5681@elte.hu> <20060530225808.GA5836@elte.hu> <1149030330.20582.45.camel@localhost.localdomain> <1149030950.9986.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149030950.9986.83.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 09:15:49AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2006-05-31 at 01:05 +0200, Thomas Gleixner wrote:
> > CC'ed Ben, who is hacking on msi, IIRC
> > 
> > On Wed, 2006-05-31 at 00:58 +0200, Ingo Molnar wrote:
> > > > > 
> > > > > does MSI much with the irq_desc[] separately perhaps, clearing 
> > > > > handle_irq in the process perhaps?
> > > > 
> > > > aha - drivers/pci/msi.c sets msix_irq_type, which has no handle_irq 
> > > > entry. This needs to be converted to irqchips.
> > > 
> > > still ... that doesnt explain how the irq_desc[].irq_handler got NULL. 
> > 
> > It has it's own irq_desc array
> > 
> > static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
> > 
> > Too tired right now. I look into this tomorrow.
> 
> The only way to fix drivers/pci/msi.c is to delete it.
> 
> Honest, there is nothing salvageable in that code. I've been looking at
> the issues involved in supporting MSIs on various powerpc platforms and
> I came to the conclusion that there isn't a single re-useable line of
> code in there. Not only it's totally specific to a given set of intel
> chipsets, but it's also broken beyond imagination. I wonder how that
> code got in there in the first place, especially maskqueraded as
> "generic" code. Greg must have been drunk.

No, not drunk, just that no other arch offered up any potential help to
get this working.  So, we have one arch that has it working well, and
finally, many years later when PPC64 catches up with the rest of the
world, we have issues :)

Feel free to help untangle it.  ia64 just did a big chunk of work on
this, and there are further patches in the -mm tree that help get it
working there.  ppc64 and other arch support are also welcome.  You are
the ones who know how your arch handles this stuff the best.

> At this point, the only solution for us (powerpc) is to allow the arch
> to have it's own implementatin of the toplevel MSI API (pci_enable_msi()
> etc...). From there, depending on what we come up with, we'll look into
> moving that back into generic code, but we are under some pressure for
> time (stupid 2 weeks merge window thing is a pain sometimes).

2 week merge window?  Come on, just give it to me and let it sit in -mm
for a while.  I have some stuff in there for over 2 months before it
goes to Linus to make sure that it's safe.  You can do the same for your
trees.

I gladly accept patches...

thanks,

greg k-h
