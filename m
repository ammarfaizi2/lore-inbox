Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUIIUSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUIIUSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUIIUPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:15:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33801 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266821AbUIIUK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:10:56 -0400
Date: Thu, 9 Sep 2004 21:10:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-ID: <20040909211038.E6434@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
	Scott Wood <scott@timesys.com>
References: <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com> <20040908143143.A32002@infradead.org> <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com> <1094652572.2800.14.camel@laptop.fenrus.com> <20040908182509.GA6009@elte.hu> <20040908211415.GA20168@elte.hu> <20040909175748.A12336@infradead.org> <20040909172401.GA28376@elte.hu> <20040909175314.GD3106@holomorphy.com> <20040909175441.GA25686@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040909175441.GA25686@devserv.devel.redhat.com>; from arjanv@redhat.com on Thu, Sep 09, 2004 at 07:54:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 07:54:41PM +0200, Arjan van de Ven wrote:
> 
> On Thu, Sep 09, 2004 at 10:53:14AM -0700, William Lee Irwin III wrote:
> > On Thu, Sep 09, 2004 at 07:24:01PM +0200, Ingo Molnar wrote:
> > > you can find a pretty good approximation done by Scott Wood (and Andrey
> > > Panin?) in the ppc/ppc64 portion of the VP patches:
> > >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-S0
> > > basically you only have to zap some of the irq-threading changes such as
> > > calls to redirect_hardirq(), do a s/generic_// and zap the PIC changes
> > > (these are done for redirection too). Scott has tested those changes so
> > > kernel/hardirq.c should work pretty well with ppc/ppc64.
> > 
> > By any chance can the generic code be made not to be reliant on
> > irq_desc[] and/or irq_desc[] being an array?
> 
> I would say one step at a time.
> First extract out the code that most arch's share already
> only THEN start working on seeing if the few remaining ones can be moved in,
> and if other cleanups are appropriate

If it uses irq_desc then ARM won't use it.  irq_desc is part of the
far-too-restrictive x86 IRQ handlign code which is unsuitable for
ARM platforms.

Sorry, try again.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
