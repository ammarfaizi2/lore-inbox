Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290652AbSAYM0r>; Fri, 25 Jan 2002 07:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290653AbSAYM02>; Fri, 25 Jan 2002 07:26:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11673 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290651AbSAYM0S>;
	Fri, 25 Jan 2002 07:26:18 -0500
Date: Fri, 25 Jan 2002 15:23:49 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] SCHED_RR fix, 2.5.3-pre5
Message-ID: <Pine.LNX.4.33.0201251514210.7264-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes sys_sched_rr_get_interval(), which returned the
timeslice value based on p->prio values, incorrectly - we calculate
timeslices based on the nice value.

	Ingo

--- linux/kernel/sched.c.orig	Fri Jan 25 10:44:18 2002
+++ linux/kernel/sched.c	Fri Jan 25 12:06:36 2002
@@ -1108,7 +1142,7 @@
 	p = find_process_by_pid(pid);
 	if (p)
 		jiffies_to_timespec(p->policy & SCHED_FIFO ?
-					 0 : NICE_TO_TIMESLICE(p->prio), &t);
+					 0 : NICE_TO_TIMESLICE(p->__nice), &t);
 	read_unlock(&tasklist_lock);
 	if (p)
 		retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;


