Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbSJFR0I>; Sun, 6 Oct 2002 13:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262084AbSJFRZY>; Sun, 6 Oct 2002 13:25:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59908 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261955AbSJFRYp>; Sun, 6 Oct 2002 13:24:45 -0400
Subject: PATCH: 2.5.40 sane minimum proc count
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:21:43 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yF67-0001tn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again from UCLinux merge but relevant on its own for any embedded tiny box

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/kernel/fork.c linux.2.5.40-ac5/kernel/fork.c
--- linux.2.5.40/kernel/fork.c	2002-10-02 21:34:06.000000000 +0100
+++ linux.2.5.40-ac5/kernel/fork.c	2002-10-05 23:51:20.000000000 +0100
@@ -166,8 +166,11 @@
 	 */
 	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
 
-	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
-	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
+	/*
+	 * we need to allow at least 10 threads to boot a system
+	 */
+	init_task.rlim[RLIMIT_NPROC].rlim_cur = max(10, max_threads/2);
+	init_task.rlim[RLIMIT_NPROC].rlim_max = max(10, max_threads/2);
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
