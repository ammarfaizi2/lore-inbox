Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVBBN6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVBBN6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 08:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVBBN6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 08:58:15 -0500
Received: from gprs214-204.eurotel.cz ([160.218.214.204]:30407 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262571AbVBBN6B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 08:58:01 -0500
Date: Wed, 2 Feb 2005 14:50:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050202135011.GA1323@elf.ucw.cz>
References: <20050127212902.GF15274@atomide.com> <20050201110006.GA1338@elf.ucw.cz> <20050201204008.GD14274@atomide.com> <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20050201230357.GH14274@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Hmmm, that sounds like the local APIC does not wake up the PIT
> > > interrupt properly after sleep. Hitting the keys causes the timer
> > > interrupt to get called, and that explains why it keeps running. But
> > > the timer ticks are not happening as they should for some reason.
> > > This should not happen (tm)...
> > 
> > :-). Any ideas how to debug it? Previous version of patch seemed to work better...
> 
> I don't think it's HPET timer, or CONFIG_SMP. It also looks like your
> local APIC timer is working.
> 
> If you have a serial console, you can put one letter printks in the
> code. Can you check if you ever get to smp_apic_timer_interrupt()?
> That's where you should get to after the sleep, and that calls the
> PIT timer interrupt to get it going again. I'm thinking that you'll
> get to smp_apic_timer_interrupt(), but once therebut function
> dyn_tick->interrupt(0, NULL, regs) never gets called.

I definitely get to smp_apic_timer_interrupt:

Feb  2 14:46:53 amd kernel:
ic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_ti
Feb  2 14:46:54 amd kernel:
irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsmp_apic_timer_irqsm


I'll test with this code:

                if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
                        if (dyn_tick->skip_cpu == cpu && dyn_tick->skip > DYN_TICK_MIN_SKIP) {
                                printk("dyn_tick->interrupt\n");
                                dyn_tick->interrupt(0, NULL, regs);
                        } else

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
