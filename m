Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUEWJCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUEWJCx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUEWJCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:02:53 -0400
Received: from marvin.harmless.hu ([195.70.51.173]:9378 "EHLO
	marvin.harmless.hu") by vger.kernel.org with ESMTP id S262450AbUEWJCc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:02:32 -0400
Date: Sun, 23 May 2004 11:03:45 +0200 (CEST)
From: Gergely Czuczy <phoemix@harmless.hu>
X-X-Sender: phoemix@localhost
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 VS 2.6 fork VS thread creation time test
In-Reply-To: <40B066EC.1010107@yahoo.com.au>
Message-ID: <Pine.LNX.4.60.0405231058530.25386@localhost>
References: <Pine.LNX.4.60.0405230914330.15840@localhost> <40B066EC.1010107@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HD-Virus-Scanned: by amavisd-new-20030616-p7 at harmless.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2004, Nick Piggin wrote:

> Gergely Czuczy wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Hello everyone,
> >
> > Today morning I've made a test about the thead and child process
> > creation(fork) time on both 2.4 and 2.6 kernels.
> >
> > The test systems
> > ================
> >
> > Box A:
> >  - kernel: Linux 2.4.22-xfs
> >  - CPU: Intel P3-700 MHz (slot1)
> >  - Ram: 384MB SDR SDRAM
> >
> > Box B:
> >  - kernel: Linux 2.6.6-mm5
> >  - CPU: Intel P4-2.6Ghz
> >  - Ram: 512 DDR SDRAM
> >
> > Box B is a lot better, but it doesn't metter according to the test,
> > because the aim was to get the ratio of the two times with different
> > sample rates.
> >
>
> Even so, you really should be using the same system if you want
> comparable results. The pentium 4 in particular can do worse at
> specific things in microbenchmarks.
It doesn't matter. That's why you should look at the "ratio" at the end
and not on the pure numbers, they are just bonus "information"

>
> Your problem with not being able large numbers of threads and
ohh wait, i don't have problems, i've just noticed the things!

> processes could be ulimits or sysctl limits. Look at ulimit
> and /proc/sys/kernel/threads-max and pid_max.
threads-max is about 8179. this is why I don't see why it is limited to
255 threads.


>
> [ snip numbers ]
>
> > Conlusion
> > =========
> >
> > It's easy to notice that in case of 2.4 the ratios of the creation times
> > are converges to 1, so it depends on the load, while in case of a 2.6
> > kernel the ratios are mostly fix, about 9. This means that creating a new
> > child process takes much more time than creating a new thread.
> >
>
> I tried your code on a P3-1000. 2.4.23 is not 100% comparable because it
> was built with an old compiler and possibly different options.
>
> Anyway, results with 256 samples were as follows:
> processes			256
> 2.4.23:
> Total fork time: 		48.224 msecs
> Total thread time: 		30.180 msecs
> Total fork/thread ratio: 	 1.598
>
> 2.6.6-mm5:
> Total fork time: 		40.795 msecs
> Total thread time: 		17.615 msecs
> Total fork/thread ratio: 	 2.316
>
> 2.6.6-mm5+child-runs-last:
> Total fork time: 		16.080 msecs
> Total thread time: 		 8.600 msecs
> Total fork/thread ratio: 	 1.870
This is very nice, but notice the difference between the total and the
avarage time. Total time includes all the time that taken by the test, and
The avarage/relative time reflect he time taken by the successive calls,
eg it not includes failed pthread_create()s and fork()s, which ones makes
the test false. After posting the test I've realized that the measurement
of the realitve time is not good, so I will patch this problem.


 >
> 2.6 introduced an optimisation called child-runs-first. Apparently
> it is nice for many common things, but it also causes a context
> switch at every fork(), so sucks for these microbenchmarks. Child-
> runs-last simply reverts that. Patch is attached if anyone is
> interested.
>


Bye,

Gergely Czuczy
mailto: phoemix@harmless.hu
PGP: http://phoemix.harmless.hu/phoemix.pgp

"Wish a god, a star, to believe in,
With the realm of king of fantasy..."
