Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVBBN5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVBBN5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 08:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVBBN5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 08:57:39 -0500
Received: from gprs214-204.eurotel.cz ([160.218.214.204]:29639 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262492AbVBBN5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 08:57:32 -0500
Date: Wed, 2 Feb 2005 14:56:30 +0100
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
Message-ID: <20050202135629.GA1309@elf.ucw.cz>
References: <20050127212902.GF15274@atomide.com> <20050201110006.GA1338@elf.ucw.cz> <20050201204008.GD14274@atomide.com> <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201230357.GH14274@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I don't think it's HPET timer, or CONFIG_SMP. It also looks like your
> local APIC timer is working.
> 
> If you have a serial console, you can put one letter printks in the
> code. Can you check if you ever get to smp_apic_timer_interrupt()?
> That's where you should get to after the sleep, and that calls the
> PIT timer interrupt to get it going again. I'm thinking that you'll
> get to smp_apic_timer_interrupt(), but once therebut function
> dyn_tick->interrupt(0, NULL, regs) never gets called.

dyn_tick->interrupt *is* being called:

Feb  2 14:53:41 amd last message repeated 36 times
Feb  2 14:53:41 amd postfix/postfix-script: starting the Postfix mail
system
Feb  2 14:53:41 amd kernel: dyn_tick->interrupt
Feb  2 14:53:41 amd kernel: dyn_tick->interrupt
Feb  2 14:53:41 amd postfix/master[1301]: daemon started -- version
2.1.5
Feb  2 14:53:41 amd kernel: dyn_tick->interrupt
Feb  2 14:53:45 amd last message repeated 30 times
Feb  2 14:53:45 amd log1n[1220]: ROOT LOGIN on `tty8'
Feb  2 14:53:45 amd kernel: dyn_tick->interrupt
Feb  2 14:54:16 amd last message repeated 228 times

I'll try turning off CONFIG_PREEMPT...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
