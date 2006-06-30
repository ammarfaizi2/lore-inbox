Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWF3Sr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWF3Sr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932995AbWF3Sr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:47:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62730 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932086AbWF3Srz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:47:55 -0400
Date: Fri, 30 Jun 2006 19:47:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Miller <davem@davemloft.net>, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: SA_TRIGGER_* vs. SA_SAMPLE_RANDOM
Message-ID: <20060630184745.GA13429@flint.arm.linux.org.uk>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
	David Miller <davem@davemloft.net>, mingo@redhat.com,
	linux-kernel@vger.kernel.org
References: <20060629.141703.59468770.davem@davemloft.net> <1151676007.25491.712.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151676007.25491.712.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 04:00:07PM +0200, Thomas Gleixner wrote:
> On Thu, 2006-06-29 at 14:17 -0700, David Miller wrote:
> > Since SA_SAMPLE_RANDOM is defined as "SA_RESTART", it
> > could be just about any value.
> > 
> > On sparc, it's value is "2", so it aliases some of
> > the SA_TRIGGER_* defines the new genirq code adds.
> > And therefore we get a bunch of these on sparc64:
> > 
> > [   16.650540] setup_irq(2) SA_TRIGGERset. No set_type function available
> > 
> > (btw: missing space in the kernel log message between 'SA_TRIGGER'
> >       and 'set' :-)
> > 
> > I can't see any reason why SA_SAMPLE_RANDOM is set to
> > a signal mask value, or why IRQ flags are defined in
> > linux/signal.h :-)
> > 
> > Anyways, probably the best bet for now is to define
> > SA_SAMPLE_RANDOM explicitly to some value instead of
> > relying on the arbitrary platform definition of SA_RANDOM.
> > 
> > Ingo could you cook up and submit a patch which does this?
> > Thanks.
> 
> We have the same hassle with SA_INTERRUPT. The question arises, if we
> should move the SA_XX flags for interrupts completely out of the signal
> SA name space. Rename to IRQ_xxx and put them into interrupt.h.

It would probably be sensible, but isn't there rather a lot of
drivers to update?  We could do it as a transitional thing -
#define the old SA_* names to the new in interrupt.h for a while.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
