Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVDHRkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVDHRkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVDHRkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:40:23 -0400
Received: from mx1.accessline.com ([64.28.126.19]:36597 "HELO
	mx1.accessline.com") by vger.kernel.org with SMTP id S262893AbVDHRhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:37:36 -0400
Message-ID: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>
From: jdavis@accessline.com
To: linux-kernel@vger.kernel.org
Subject: Odd Timer behavior in 2.6 vs 2.4  (1 extra tick)
Date: Fri, 8 Apr 2005 10:39:23 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello, 

I've created a pretty straight forward timer using setitimer, and noticed
some odd differences between 2.4 and 2.6, I wonder if I could get a
clarification if this is the way it should work, or if I should continue to
try to "fix" it.

I create a RealTime Thread( SCHED_FIFO, maxPriority-1 ) (also tried
SCHED_RR) ...

that creates a timer ...setitimer( ITIMER_REAL, SIGALRM) with a 10 milli
period. (I've also tried timer_create with CLOCK_REALTIME and SIGRTMIN)

and then the thread does a sem_wait() on a semaphore. 

the signal handler does a sem_post() .


on 2.4.X the (idle) worst case latency is ~40 microseconds, 
on 2.6.X the (idle) latency is about the same plus 1 tick of the scheduler
~1000 micro seconds... Always.. Every time.
So to work around this on 2.6 I simply subtract 1 millisecond from my timer
as a fudge factor and everything works as expected.

I've tried compiling various kernels (2.6.9, 2.6.11) with kernel pre-empting
on, etc..

Is this the correct behavior? If so I'm curious who is using up the extra
Tick?
Does the asynch signal handler use up the whole tick even though it only has
to sem_post()?

I am not subscribed to the list, so I would appreciate a CC.
Thanks,
-JD
