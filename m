Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbSJHTOy>; Tue, 8 Oct 2002 15:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbSJHTN6>; Tue, 8 Oct 2002 15:13:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29200 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261421AbSJHTKa>; Tue, 8 Oct 2002 15:10:30 -0400
Subject: PATCH: tidy for the max_thread stuff from the kernel list
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:07:40 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzhk-0004vR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/kernel/fork.c linux.2.5.41-ac1/kernel/fork.c
--- linux.2.5.41/kernel/fork.c	2002-10-07 22:12:28.000000000 +0100
+++ linux.2.5.41-ac1/kernel/fork.c	2002-10-07 23:17:19.000000000 +0100
@@ -165,12 +165,14 @@
 	 * of memory.
 	 */
 	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
-
 	/*
-	 * we need to allow at least 10 threads to boot a system
+	 * we need to allow at least 20 threads to boot a system
 	 */
-	init_task.rlim[RLIMIT_NPROC].rlim_cur = max(10, max_threads/2);
-	init_task.rlim[RLIMIT_NPROC].rlim_max = max(10, max_threads/2);
+	if(max_threads < 20)
+		max_threads = 20;
+
+	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
+	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
