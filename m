Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290651AbSAYMdt>; Fri, 25 Jan 2002 07:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290655AbSAYMc5>; Fri, 25 Jan 2002 07:32:57 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51097 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290651AbSAYMcT>;
	Fri, 25 Jan 2002 07:32:19 -0500
Date: Fri, 25 Jan 2002 15:29:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] unlock_task_rq() cleanup, 2.5.3-pre3
Message-ID: <Pine.LNX.4.33.0201251526410.7457-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch implements a cleanup suggested by Robert Love, it
removes an unused parameter from unlock_task_rq().

	Ingo

--- linux/kernel/sched.c.orig	Fri Jan 25 10:44:18 2002
+++ linux/kernel/sched.c	Fri Jan 25 12:06:36 2002
@@ -70,8 +70,7 @@
 	return __rq;
 }

-static inline void unlock_task_rq(runqueue_t *rq, task_t *p,
-							unsigned long *flags)
+static inline void unlock_task_rq(runqueue_t *rq, unsigned long *flags)
 {
 	spin_unlock_irqrestore(&rq->lock, *flags);
 }
@@ -202,10 +220,10 @@
 	}
 	rq = lock_task_rq(p, &flags);
 	if (unlikely(rq->curr == p)) {
-		unlock_task_rq(rq, p, &flags);
+		unlock_task_rq(rq, &flags);
 		goto repeat;
 	}
-	unlock_task_rq(rq, p, &flags);
+	unlock_task_rq(rq, &flags);
 }

 /*
@@ -260,7 +278,7 @@
 			resched_task(rq->curr);
 		success = 1;
 	}
-	unlock_task_rq(rq, p, &flags);
+	unlock_task_rq(rq, &flags);
 	return success;
 }

@@ -846,7 +880,7 @@
 			resched_task(rq->curr);
 	}
 out_unlock:
-	unlock_task_rq(rq, p, &flags);
+	unlock_task_rq(rq, &flags);
 }

 #ifndef __alpha__
@@ -966,7 +1000,7 @@
 		activate_task(p, task_rq(p));

 out_unlock:
-	unlock_task_rq(rq, p, &flags);
+	unlock_task_rq(rq, &flags);
 out_unlock_tasklist:
 	read_unlock_irq(&tasklist_lock);



