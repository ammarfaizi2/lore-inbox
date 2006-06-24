Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWFXXtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWFXXtM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 19:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWFXXtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 19:49:12 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:40330 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751279AbWFXXtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 19:49:10 -0400
Subject: Re: More weird latency trace output (was Re: 2.6.17-rt1)
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <20060624221235.GA23423@elte.hu>
References: <20060618070641.GA6759@elte.hu>
	 <1150937848.2754.379.camel@mindpipe> <1150944663.2754.416.camel@mindpipe>
	 <1151025892.17952.32.camel@mindpipe> <1151187320.2931.191.camel@mindpipe>
	 <20060624221235.GA23423@elte.hu>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 19:49:12 -0400
Message-Id: <1151192953.2931.208.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 00:12 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> The latency tracer uses get_cycles() for
> > > timestamping, which uses rdtsc, which is unusable for timing on dual
> > > core AMD64 machines

> does it get better if you boot with idle=poll? [that could work around 
> the rdtsc drifting problem] Calling gettimeofday() from within the 
> tracer is close to impossible - way too many opportunities for 
> recursion. It's also pretty slow that way.

That seemed to solve the drifting problem, but I still get some weird
behavior.  The max reported trace in dmesg still does not
match /proc/latency_trace:

( posix_cpu_timer-3    |#0): new 38 us maximum-latency wakeup.


preemption latency trace v1.1.5 on 2.6.17-rt1-smp-latency-trace
--------------------------------------------------------------------
 latency: 19 us, #74/74, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)
    -----------------
    | task: posix_cpu_timer-3 (uid:0 nice:0 policy:1 rt_prio:99)
    -----------------

Lee

