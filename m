Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWIHLIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWIHLIe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 07:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWIHLIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 07:08:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:14208 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750802AbWIHLId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 07:08:33 -0400
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <10720.1157711152@warthog.cambridge.redhat.com>
References: <1157669602.22705.326.camel@localhost.localdomain>
	 <1157583693.22705.254.camel@localhost.localdomain>
	 <20060906125626.GA3718@elte.hu> <20060906094301.GA8694@elte.hu>
	 <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de>
	 <20060901015818.42767813.akpm@osdl.org>
	 <6260.1157470557@warthog.cambridge.redhat.com>
	 <8430.1157534853@warthog.cambridge.redhat.com>
	 <13982.1157545856@warthog.cambridge.redhat.com>
	 <17274.1157553962@warthog.cambridge.redhat.com>
	 <8934.1157622928@warthog.cambridge.redhat.com>
	 <10720.1157711152@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 21:05:05 +1000
Message-Id: <1157713505.31071.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 11:25 +0100, David Howells wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > No, you do a chain handler. Look at how I do it in
> > arch/powerpc/platform/pseries/setup.c for example. It's actually
> > trivial. You install a special flow handler (which means that there is
> > very little overhead, almost none, from the toplevel irq to the chained
> > irq). You can _also_ if you want just install an IRQ handler for the
> > cascaded controller and call generic_handle_irq (rather than __do_IRQ)
> > from it, but that has more overhead. A chained handler completely
> > relaces the flow handler for the cascade, and thus, if you don't need
> > all of the nits and bits of the other flow handlers for your cascade,
> > you can speed things up by hooking at that level.
> 
> Please update Documentation/DocBook/genericirq.tmpl.  That doesn't mention it.

I must admit I haven't read the documentation :) I looked at the
code/patches when genirq was posted and did my powerpc implementation
based on my understanding of the code and discussions with Thomas and
Ingo. I'll have a look at the doc next week and see if I can improve it.

Cheers,
Ben.


