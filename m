Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285972AbSALMs0>; Sat, 12 Jan 2002 07:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286188AbSALMsR>; Sat, 12 Jan 2002 07:48:17 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:61713 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S285972AbSALMsL>;
	Sat, 12 Jan 2002 07:48:11 -0500
Date: Sat, 12 Jan 2002 05:45:35 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: Rob Landley <landley@trommello.org>, yodaiken@fsmlabs.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112054535.B3734@hq.fsmlabs.com>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <1010815300.2011.16.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1010815300.2011.16.camel@phantasy>; from rml@tech9.net on Sat, Jan 12, 2002 at 01:01:39AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 01:01:39AM -0500, Robert Love wrote:
> could even be merged.  Daniel Phillips suggested a passive tool on IRC. 
> Preempt-stats works like this.  It is off-by-default and, when enabled,
> measures time between lock and unlock, reporting the top 20 worst-cases.

I think one of the problems with this entire debate is lack of meaningful
numbers. Not for the first time, I propose that you test with something
that tests application benefits instead of internal numbers that may not
mean anything. For example, there is a simple test
		/* user code */
		get time.
		count = 200*3600; /* one hour */
		while(count--){
			read cycle timer
			clock_nanosleep(5 milliseconds)
			read cycle timer
			compute actual delay and difference from 5 milliseconds
			store the worst case
			}
		get time.
		printf("After one hour the worst deviation is %d clock ticks\n",worst);
		printf("This was supposed to take one hour and it took %d", compute_elapsed());

		

> 
> Begin working on the worst-case locks.  Solutions like Andrew's
> low-latency and my lock-break are a start.  Better (at least in general)
> solutions are to analyze the locks.  Localize them; make them finer
> grained.  Analyze the algorithms.  Find the big problems.  Anyone look

The theory that "fine grained = better" is not proved. It's obvious that
"fine grained = more time spent in the overhead of locking and unlocking locks and
		potentially more time spent in lock contention
		and lots more opportunities of cache ping-pong in real smp
		and much harder to debug"
But the performance gain that is supposed to balance that is often elusive.



> at the tty layer lately?  Ugh.  Using the preemptive kernel as a base
> and the analysis of the locks as a list of culprits, clean this cruft
> up.  This would benefit SMP, too.  Perhaps a better locking construct is
> useful.
> 
> The immediate result is good; the future is better.

Removing synchronization by removing contention 
is better engineering than fiddling about with synchronization
primitives, but it is much harder.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

