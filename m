Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274658AbRITV3T>; Thu, 20 Sep 2001 17:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274659AbRITV3K>; Thu, 20 Sep 2001 17:29:10 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:32554 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274658AbRITV3A>; Thu, 20 Sep 2001 17:29:00 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Roger Larsson <roger.larsson@norran.net>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200109201742.f8KHgJH04518@maild.telia.com>
In-Reply-To: <1000939458.3853.17.camel@phantasy>
	<20010920084131.C1629@athlon.random>
	<200109200757.JAA60995@blipp.internet5.net> 
	<200109201742.f8KHgJH04518@maild.telia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 17:29:20 -0400
Message-Id: <1001021365.6048.187.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 13:37, Roger Larsson wrote:

> > Worst 20 latency times of 4261 measured in this period.
> >   usec      cause     mask   start line/file      address   end line/file
> >   4617   reacqBKL        0  1375/sched.c         c0114d94  1381/sched.c
>
> This is fantastic! It REALLY is!
> When we started with the low latency work we aimed at 10 ms.
> (in all situations, not only when running dbench... but still)

Yes it really is, especially noting that that 4.6ms lock is the
_longest_ held lock on the system.

I am seeing 90% of the reported locks under 15ms, and this means that
almost all the locks on the system are even less.

However, I am also seeing some stray 20-50ms and even 60-70ms latencies
and those bother me.  I am looking into another solution, perhaps
conditional scheduling for now.

> Lets see - no swap used? - not swapped out
> But with priority altered - it is unlikely that it would not be scheduled
> in for such a long time.
> 
> Might it be that the disk is busy to handle dbench requests. 16 threads ->
> 16 read and several (async) write requests at different disk locations in
> queue - make it 20. Seek time 10 ms => queue length 200 ms... probable???
> Do you have more than one disk? Try to run dbench on one and the player from
> the other.

Good idea.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

