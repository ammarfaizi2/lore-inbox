Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSAEWlY>; Sat, 5 Jan 2002 17:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286314AbSAEWlO>; Sat, 5 Jan 2002 17:41:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62354 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286311AbSAEWlF>;
	Sat, 5 Jan 2002 17:41:05 -0500
Date: Sun, 6 Jan 2002 01:38:30 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] O(1) scheduler, 2.4.17-B0, 2.5.2-pre8-B0.
Message-ID: <Pine.LNX.4.33.0201060128250.1250-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is the next, bugfix release of the O(1) scheduler:

	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-B0.patch
	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-B0.patch

This release could fix the lockups and crashes reported by some people.

Changes:

 - remove the likely/unlikely define from sched.h and include compiler.h.
   (Adrian Bunk)

 - export sys_sched_yield, reported by Pawel Kot.

 - turn off 'child runs first' temporarily, to see the effect.

 - export nr_context_switches() as well, needed by ReiserFS.

 - define resched_task() in the correct order to avoid compiler warnings
   on UP.

 - maximize the frequency of timer-tick driven load-balancing to 100 per
   sec.

 - clear ->need_resched in the RT scheduler path as well.

 - simplify yield() support, remove TASK_YIELDED and __schedule_tail().

Comments, bug reports, suggestions are welcome,

	Ingo

