Return-Path: <linux-kernel-owner+w=401wt.eu-S1750736AbWLMUbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWLMUbf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWLMUbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:31:35 -0500
Received: from ns1.suse.de ([195.135.220.2]:48720 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbWLMUbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:31:34 -0500
Date: Wed, 13 Dec 2006 12:31:13 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061213203113.GA9026@suse.de>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 12:12:04PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 13 Dec 2006, Greg KH wrote:
> >
> > 	- userspace io driver interface added.  This allows the ability
> > 	  to write userspace drivers for some types of hardware much
> > 	  easier than before, going through a simple interface to get
> > 	  accesses to irqs and memory regions.  A small kernel portion
> > 	  is still needed to handle the irq properly, but that is it.
> 
> Ok, what kind of ass-hat idiotic thing is this?
> 
> 	irqreturn_t uio_irq_handler(int irq, void *dev_id)
> 	{
> 	        return IRQ_HANDLED;
> 	}
> 
> exactly what is the point here? No way will I pull this kind of crap. You 
> just seem to have guaranteed a dead machine if the irq is level-triggered, 
> since it will keep on happening forever.

It's a stupid test module for the uio core for isa devices.  It's not
the main code, or core.

> Please remove.
> 
> YOU CANNOT DO IRQ'S BY LETTING USER SPACE SORT IT OUT!

I agree, that's why this code doesn't let userspace sort it out.  You
have to have a kernel driver to handle the irq.

> It's really that easy. The irq handler has to be _entirely_ in kernel 
> space. No user-space ass-hattery here.

Agreed.

> And I don't care one whit if it happens to work on parport with an old 
> legacy ISA interrupt that is edge-triggered. That's not even the 
> interesting case. Never will be.

I agree.  But that's all that this test module did.  It handled an isa
interrupt that was edge triggered.

> NAK NAK NAK NAK.

Ok, I can pull this example module out if you want, but people seem to
want examples these days.  If I do that, any objection to the rest?

thanks,

greg k-h
