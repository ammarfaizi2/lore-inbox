Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132853AbRBEF3z>; Mon, 5 Feb 2001 00:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRBEF3o>; Mon, 5 Feb 2001 00:29:44 -0500
Received: from ftoomsh.progsoc.uts.edu.au ([138.25.6.1]:15108 "EHLO ftoomsh")
	by vger.kernel.org with ESMTP id <S132853AbRBEF3b>;
	Mon, 5 Feb 2001 00:29:31 -0500
Date: Mon, 5 Feb 2001 16:29:03 +1100
From: Matt <matt@progsoc.uts.edu.au>
To: aron@zambeel.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: system call sched_yield() doesn't work on Linux 2.2
Message-ID: <20010205162903.A15507@ftoomsh.progsoc.uts.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-OperatingSystem: Linux ftoomsh.progsoc.uts.edu.au 2.2.15-pre13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mohit,
	to expect perfect alternation is not reasonable. the scheduler
(or one of its subsidiary and/or supporting functions) decides what
should run and what shouldn't. the linux scheduler did have problems
in 2.2 (and still does in some places). however last i checked
sched_yield() is at best a hint to the scheduler not a command. the
man page even suggests this. it says that if the process (or thread)
yields and if it is the highest priority task at the time it will be
re-run. so you can not guarantee that it will not re-run. this i think
was the point david was trying to make (albiet with some possibly
misplaced "fervour").

	however i did notice one small change wrt to SCHED_YIELD
semantics from 2.2.18 and 2.4.1-ac1 (one would assume that this change
happened during the schedule() re-writes during 2.3.x).

xref line 119 of kernel/sched.c in 2.2.18

 and

xref line 148 of kernel/sched.c in 2.4.1-ac1

in this case you will see that in 2.2.18 a SCHED_YIELD process will
get a "goodness" value of 0, however in 2.4.1-ac1 you will find that
it gets a value of -1 (and hence a lower scheduling priority). i dont
have a machine handy that is running 2.2.18 that i can patch and
reboot, how ever you may wish to change the return value on line 119
of kernel/sched.c in 2.2.18 to -1 and you may find that it might give
the behaviour you are looking for. it may also cause other
problems. caveat emptor and all that..

	matt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
