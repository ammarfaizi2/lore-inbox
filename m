Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288141AbSAMUp0>; Sun, 13 Jan 2002 15:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288144AbSAMUpQ>; Sun, 13 Jan 2002 15:45:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:58018 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288141AbSAMUpI>;
	Sun, 13 Jan 2002 15:45:08 -0500
Date: Sun, 13 Jan 2002 15:45:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH] SMP kernel deadlocking on UP boxen
Message-ID: <Pine.GSO.4.21.0201131540550.27390-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Still present in -pre11:

diff -urN C2-pre10/kernel/sched.c C2-pre10-resched_task.bork.bork.bork/kernel/sched.c
--- C2-pre10/kernel/sched.c	Mon Jan  7 19:33:06 2002
+++ C2-pre10-resched_task.bork.bork.bork/kernel/sched.c	Sun Jan 13 15:31:10 2002
@@ -219,7 +219,7 @@
 	need_resched = p->need_resched;
 	wmb();
 	p->need_resched = 1;
-	if (!need_resched)
+	if (!need_resched && p->cpu != smp_processor_id())
 		smp_send_reschedule(p->cpu);
 }
 

