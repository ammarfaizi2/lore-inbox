Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbSITI5D>; Fri, 20 Sep 2002 04:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbSITI5D>; Fri, 20 Sep 2002 04:57:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52129 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261745AbSITI5C>;
	Fri, 20 Sep 2002 04:57:02 -0400
Date: Fri, 20 Sep 2002 11:09:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: [patch] pidhash-fix-2.5.36-A0
Message-ID: <Pine.LNX.4.44.0209201104300.30613-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) fixes a bug in the new PID allocator,
which bug can cause incorrect hashing of the PID structure which causes
infinite loops in find_pid(). [and potentially other problems.]

	Ingo

--- linux/kernel/pid.c.orig	Fri Sep 20 11:01:52 2002
+++ linux/kernel/pid.c	Fri Sep 20 11:03:05 2002
@@ -161,8 +161,8 @@
 		pid->nr = nr;
 		atomic_set(&pid->count, 1);
 		INIT_LIST_HEAD(&pid->task_list);
-		pid->task = current;
-		get_task_struct(current);
+		pid->task = task;
+		get_task_struct(task);
 		list_add(&pid->hash_chain, &pid_hash[type][pid_hashfn(nr)]);
 	}
 	list_add(&task->pids[type].pid_chain, &pid->task_list);

