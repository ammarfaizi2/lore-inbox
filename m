Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUJaMfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUJaMfR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUJaMfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:35:17 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8360 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261568AbUJaMfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 07:35:11 -0500
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, axboe@suse.de
In-Reply-To: <20041031121937.GA20036@elte.hu>
References: <1099158570.1972.5.camel@krustophenia.net>
	 <20041030191725.GA29747@elte.hu> <20041030214738.1918ea1d@mango.fruits.de>
	 <1099165925.1972.22.camel@krustophenia.net>
	 <20041030221548.5e82fad5@mango.fruits.de>
	 <1099167996.1434.4.camel@krustophenia.net>
	 <20041030231358.6f1eeeac@mango.fruits.de>
	 <1099189225.1754.1.camel@krustophenia.net>
	 <20041031110039.4575e49c@mango.fruits.de>
	 <1099224598.1459.28.camel@krustophenia.net>
	 <20041031121937.GA20036@elte.hu>
Content-Type: text/plain
Date: Sun, 31 Oct 2004 07:35:09 -0500
Message-Id: <1099226110.1459.42.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-31 at 13:19 +0100, Ingo Molnar wrote:
> we could do this too. The reason why i picked the current "start at
> SCHED_FIFO prio 49 and decrease it by 1 until it reaches 25, then stay
> constant" logic is that typically the irqs registered first are 'more
> important' - e.g. the timer interrupt.

Hmm, maybe the timer interrupt should be 99 and the rest say 50.
Wouldn't it be bad if you had a fully loaded jackd (DSP load in JACK is
the proportion of the process cycle to the period time; in a fully
loaded jack setup the clients are using all the available time) and
jackd + the soundcard IRQ's RT priorities are higher than the timer
interrupt?  Seems like you could starve the timer interrupt
indefinitely.

In fact, the only IRQ thread that currently _needs_ to be lower prio
than the others is IDE - the others all execute quickly enough to only
cause a problem at _extreme_ latencies that you would never use in the
real world, at least for audio/JACK.  Last time I checked no other
hardirq ran for more than about 50 usecs.  With Jens' patch to move IDE
bh processing into a softirq, I suspect the relative priorities of the
IRQ threads would not matter at all.

Lee

