Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbUKRPZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbUKRPZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbUKRPZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:25:40 -0500
Received: from mail.onestepahead.de ([62.96.100.59]:10395 "EHLO
	mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S262469AbUKRPZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:25:29 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
From: Christian Meder <chris@onestepahead.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041118123521.GA29091@elte.hu>
References: <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu>
	 <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu>
	 <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu>
	 <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu>
	 <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
	 <20041118123521.GA29091@elte.hu>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 16:23:30 +0100
Message-Id: <1100791410.3397.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 13:35 +0100, Ingo Molnar wrote:
> i have released the -V0.7.28-1 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
> 	http://redhat.com/~mingo/realtime-preempt/
> 
> this should fix the lockup bug reported by Florian Schmidt.
> 
> there's a generic PREEMPT bug in the upstream kernel: there exists a
> single-instruction race window in __flush_tlb(), if the kernel preempted
> exactly there in a lazy-TLB thread and certain other, rare scheduling
> and MM properties were true as well (a certain constellation of threads
> and lazy-TLB kernel threads occured), and the lazy-TLB task then got
> another user TLB to inherit, and switched to a task from which it
> inherited that new TLB, thus the wrong cr3 was loaded and inherited by
> this next, non-lazy-TLB next task; then (and only then) this scenario
> would typically manifest itself in the form of an infinite pagefault
> lockup occuring much after the fact, upon the next userspace access (to
> the joy of a totally baffled kernel developer). I suspect from the
> description you can guess how much fun it was to debug it =B-)
> 
> the bug is even more rare in the generic kernel, because there most (but
> not all) TLB flush points are in a critical section.
> 
> this fix could resolve some of the other 'my box just locked up'
> reports.

Hi,

I've got one of those 'my box just locked up'. I can reproduce it with
0.7.25-1, 0.7.28-0 and 0.7.28-1 by starting the Jetty servlet container
with our inhouse java project under a Blackdown 1.4 jdk. Within a minute
the laptop just locks up: no mouse, no ping, console switching sysrq-t
or anything. The peculiar thing is that I was running 0.7.25-1 for two
or three days before and it was rocksolid. It was just when I started to
work with the jvm that things fell apart.

Any chance to get any interesting and helpful data in this setup ?



			Christian


-- 
Christian Meder, email: chris@onestepahead.de

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

