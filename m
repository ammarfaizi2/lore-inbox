Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWIHMb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWIHMb5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 08:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWIHMb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 08:31:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42153 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750964AbWIHMbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 08:31:55 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1157669602.22705.326.camel@localhost.localdomain> 
References: <1157669602.22705.326.camel@localhost.localdomain>  <1157583693.22705.254.camel@localhost.localdomain> <20060906125626.GA3718@elte.hu> <20060906094301.GA8694@elte.hu> <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <6260.1157470557@warthog.cambridge.redhat.com> <8430.1157534853@warthog.cambridge.redhat.com> <13982.1157545856@warthog.cambridge.redhat.com> <17274.1157553962@warthog.cambridge.redhat.com> <8934.1157622928@warthog.cambridge.redhat.com> 
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 08 Sep 2006 13:29:52 +0100
Message-ID: <21606.1157718592@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > > Now, if you have funky cascades, then you can always group them into a
> > > virtual irq cascade line and have a special chained flow handler that
> > > does all the "figuring out" off those... it's up to you. 
> > 
> > You make it sound so easy, but it's not obvious how to do this, apart from
> > installing interrupt handlers for the auxiliary PIC interrupts on the CPU and
> > having those call back into __do_IRQ().  Chaining isn't mentioned in
> > genericirq.tmpl.
> 
> No, you do a chain handler. Look at how I do it in
> arch/powerpc/platform/pseries/setup.c for example. It's actually
> trivial. You install a special flow handler (which means that there is
> very little overhead, almost none, from the toplevel irq to the chained
> irq). You can _also_ if you want just install an IRQ handler for the
> cascaded controller and call generic_handle_irq (rather than __do_IRQ)
> from it, but that has more overhead. A chained handler completely
> relaces the flow handler for the cascade, and thus, if you don't need
> all of the nits and bits of the other flow handlers for your cascade,
> you can speed things up by hooking at that level.

But funky cascading using chained flow handlers doesn't work if the cascade
must share an IRQ with some other device, right?

David
