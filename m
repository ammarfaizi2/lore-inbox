Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSGVS0W>; Mon, 22 Jul 2002 14:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317863AbSGVS0V>; Mon, 22 Jul 2002 14:26:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10633 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317862AbSGVS0R>;
	Mon, 22 Jul 2002 14:26:17 -0400
Date: Mon, 22 Jul 2002 20:28:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] scheduler bits for 2.5.27, -C0
Message-ID: <Pine.LNX.4.44.0207222023550.20455-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


updated scheduler changes/fixes, against 2.5.27-BK + cli-sti-cleanup-B2 +
remove-irqlock-E0:

   http://redhat.com/~mingo/O(1)-scheduler/sched-2.5.27-C0

Bugfixes:

 - introduce new type of context-switch locking, this is a must-have for
   ia64 and sparc64.

 - load_balance() bug noticed by Scott Rhine and myself: scan the
   whole list to find imbalance number of tasks, not just the tail
   of the list.

 - sched_yield() fix: use current->array not rq->active.

Features:

 - SCHED_BATCH feature.

 - ->first_time_slice to limit the number of timeslices 'won' via child
   exit - this is the logical equivalent of the child-timeslice
   distribution change in Andrea's tree.

 - sched_yield() cleanup and simplification: yielding puts the task
   into the expired queue. This eliminates spurious yields in which
   the same task repeatedly calls into yield() without achieving
   anything. It's also the most logical thing to do - the yielder
   has asked for other tasks to be scheduled first.

Cleanups, smaller changes:

 - simpler locking in schedule_tail().

 - load_balance() cleanup: split up into find_busiest_queue(),
   pull_task() and load_balance() functions.

 - idle_tick() cleanups: use a parameter already existing in the
   calling function.

 - scheduler_tick() cleanups: use more intuitive variable names.

 - remove obsolete comments.

 - clear ->first_time_slice when a new timeslice is calculated.

 - move the sched initialization code to the end of sched.c.

 - no need for nr_uninterruptible to be signed.

	Ingo

