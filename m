Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbSITHvS>; Fri, 20 Sep 2002 03:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSITHvS>; Fri, 20 Sep 2002 03:51:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:21976 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261397AbSITHvQ>;
	Fri, 20 Sep 2002 03:51:16 -0400
Date: Fri, 20 Sep 2002 10:02:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <amedkb$20g$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209200954220.27825-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Sep 2002, Linus Torvalds wrote:

> They did not have them all running at the same time. I think the
> original post said something like "up to 50 at a time".

actually, that was Ulrich's other test, which tests the serial starting of 
100,000 threads.

the test i did started up 100,000 concurrent threads which shot up the
load-average to a couple of thousands. [the default timeslice the parent
has is enough to start more than 50,000 parallel threads a pop or so.]

> Basically, the benchmark was how _fast_ thread creation is, not now many
> you can run at the same time. 100k threads at once is crazy, but you can
> do it now on 64-bit architectures if you really want to.

we did both, and on the dual-P4 testbox i have started and stopped 100,000
*parallel* threads in less than 2 seconds. Ie. starting up 100,000 threads
without any throttling, waiting for all of them to start up, then killing
them all. It needs roughly 1 GB of RAM to do this test on the default x86
kernel, it need roughly 500 MB of RAM to do this test with the IRQ-stacks
patch applied.

with 2.5.31 this test would have taken roughly 15 minutes, on the same
box, provided the NMI watchdog is turned off.

with 100,000 threads started up and idling silently the system is
completely usable - all the critical for_each_task loops have been fixed.  
Obviously with 100,000 threads running at once there's some shortage in
CPU power :-) [ I will perhaps try that once, at SCHED_BATCH priority,
just for kicks. Not that it makes much sense - they will get a 3 seconds
worth of timeslice every 3 days. ]

	Ingo

