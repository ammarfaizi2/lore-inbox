Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273630AbRIVGKP>; Sat, 22 Sep 2001 02:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274014AbRIVGKF>; Sat, 22 Sep 2001 02:10:05 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:10047 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S273630AbRIVGJx>; Sat, 22 Sep 2001 02:09:53 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Andre Pang <ozone@algorithm.com.au>
Cc: linux-kernel@vger.kernel.org, safemode@speakeasy.net,
        Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl, ilsensine@inwind.it,
        george@mvista.com
In-Reply-To: <1001131036.557760.4340.nullmailer@bozar.algorithm.com.au>
In-Reply-To: <1000939458.3853.17.camel@phantasy> 
	<1001131036.557760.4340.nullmailer@bozar.algorithm.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.20.15.42 (Preview Release)
Date: 22 Sep 2001 02:10:18 -0400
Message-Id: <1001139027.1245.28.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-21 at 23:57, Andre Pang wrote:
> hi Robert, thanks for producing the stats patches!

no problem, but note that the original work was by MontaVista.  They
have contributed a lot to lowering latency in the Linux kernel.

I just spruced the patch up and updated it for the current kernels.

> i did a test of it on linux-2.4.10-pre13 with Benno Senoner's
> lowlatency program, which i hacked up a bit to output
> /proc/latencytimes after each of the graphs.  test results are at
> 
>     http://www.algorithm.com.au/hacking/linux-lowlatency/2.4.10-pre13-pes/
> 
> and since i stared at the results in disbelief, i won't even try
> to guess what's going on :).  maybe you can make some sense of
> it?

Well, its not hard to decipher...and really, its actually fairly good.
the latency test program is giving you a max latency of around 12ms in
each test, which is OK.

the preemption-test patch is showing _MAX_ latencies of 0.8ms through
12ms.  this is fine, too.

> i'm prety sure his latencytest program runs at real-time
> priority, but i'll run another test just with the getrt and rt
> programs just posted to the list to make sure.  that's the only
> reason i can think why the graph is so bizarre compared to the
> /proc/latencytimes results.

well, latencytest is showing you the end result of a certain set of
operations, with a final latency of 12ms.  the /proc interface is a bit
more specific, in that it shows you latencies over individual locks.

the latencies over the specific locks held during latencytest, plus the
time to execute the instructions outside of locks, is equal to 12ms. 
the correlation between max lock and latencytest is not 1-to-1.

in an ideal world, you want latencytest to show you 10ms or less, which
we are pretty close to by your results, and you want most of your locks
under 1ms, which we also achieve since of your top 20 locks out of 20k+,
we see many still around 1ms.

thank you for these data points...

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

