Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWGJJTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWGJJTa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWGJJTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:19:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60431 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932468AbWGJJT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:19:29 -0400
Date: Mon, 10 Jul 2006 10:19:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>, David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
       mingo@redhat.com, Andrew Victor <andrew@sanpeople.com>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [patch 2.6.18-rc1] genirq: {en,dis}able_irq_wake() need refcounting too
Message-ID: <20060710091920.GB4400@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	David Brownell <david-b@pacbell.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	tglx@linutronix.de, mingo@redhat.com,
	Andrew Victor <andrew@sanpeople.com>,
	Alessandro Zummo <alessandro.zummo@towertech.it>
References: <200607091458.52298.david-b@pacbell.net> <20060710085849.GA6016@elte.hu> <20060710091340.GA4400@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710091340.GA4400@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 10:13:40AM +0100, Russell King wrote:
> On Mon, Jul 10, 2006 at 10:58:49AM +0200, Ingo Molnar wrote:
> > 
> > * David Brownell <david-b@pacbell.net> wrote:
> > 
> > > It's not just "normal" mode operation that needs refcounting for the 
> > > {en,dis}able_irq() calls ... "wakeup" mode calls need it too, for the 
> > > very same reasons.
> > > 
> > > This patch adds that refcounting.  I expect that some ARM drivers will 
> > > be triggering the new warning, but this call isn't yet widely used. 
> > > (Which is probably why the bug has lingered this long...)
> > 
> > Acked-by: Ingo Molnar <mingo@elte.hu>
> > 
> > we should also add disable_irq_wake() / enable_irq_wake() APIs and start 
> > migrating most ARM users over to the new APIs, agreed? That makes the 
> > APIs more symmetric and the code more readable too.
> 
> That _is_ the API anyway.  set_irq_wake() was never intended to be called
> directly from drivers.

Also note that genirq has a bigger problem to fry at the moment - it's
currently broken for ARM SMP + hotplug CPU due to missing functionality
(as in, the kernel doesn't even link.)  Thomas has a patch which is
going through the test mills at the moment.

Let's first get genirq to a point where it's a direct replacement for
my IRQ subsystem before thinking about changing existing APIs (and
thereby possibly introducing other breakage.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
