Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWGAAP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWGAAP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933113AbWGAAP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:15:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:48278 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932524AbWGAAP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:15:27 -0400
Subject: Re: SA_TRIGGER_* vs. SA_SAMPLE_RANDOM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tglx@linutronix.de
Cc: David Miller <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
       mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1151706327.25491.847.camel@localhost.localdomain>
References: <20060630184745.GA13429@flint.arm.linux.org.uk>
	 <20060630.132128.26278530.davem@davemloft.net>
	 <1151699247.25491.806.camel@localhost.localdomain>
	 <20060630.133123.84974324.davem@davemloft.net>
	 <1151706327.25491.847.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 10:14:02 +1000
Message-Id: <1151712843.27137.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 00:25 +0200, Thomas Gleixner wrote:
> On Fri, 2006-06-30 at 13:31 -0700, David Miller wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > Date: Fri, 30 Jun 2006 22:27:27 +0200
> > 
> > > I'll cook it up tomorrow.
> > 
> > Thanks a lot Thomas. :)
> 
> That's what I came up with:
> 
> SA_INTERRUPT		IRQF_IRQS_DISABLED
> SA_SAMPLE_RANDOM	IRQF_SAMPLE_RANDOM
> SA_SHIRQ		IRQF_SHARE_IRQ
> SA_PROBEIRQ		IRQF_PROBE_IRQ
> SA_TRIGGER_LOW		IRQF_TRIGGER_LOW
> SA_TRIGGER_HIGH		IRQF_TRIGGER_HIGH
> SA_TRIGGER_FALLING	IRQF_TRIGGER_FALLING
> SA_TRIGGER_RISING	IRQF_TRIGGER_RISING
> SA_TRIGGER_MASK		IRQF_TRIGGER_MASK
> SA_TIMER		IRQF_TIMER

Looks good to me. Do we want to keep a PERCPU flag too ? I don't really
need it anymore on powerpc as I just use the percpu flow handler and I'm
not allowing sharing of IPIs but others might.

Also, I'd like to store the IRQ types in the irq_desc regardless of the
actions that have been registered or not. Any suggestion where to put
that ? The current type values conflict with other desc->status bits at
the moment unless we shift the whole thing up...

Ben.


