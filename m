Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbULZJgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbULZJgk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 04:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbULZJgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 04:36:40 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:3262 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261479AbULZJgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 04:36:37 -0500
Message-ID: <41CE94D8.10E0E025@tv-sign.ru>
Date: Sun, 26 Dec 2004 13:39:20 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] trivial, uninline/kill __exit_mm()
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

__exit_mm() is an inlined version of exit_mm().
This patch unifies them.

Saves 356 byte in exit.o.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10/kernel/exit.c~	2004-12-26 11:09:43.000000000 +0300
+++ 2.6.10/kernel/exit.c	2004-12-26 11:11:59.000000000 +0300
@@ -470,7 +470,7 @@ EXPORT_SYMBOL_GPL(exit_fs);
  * Turn us into a lazy TLB process if we
  * aren't already..
  */
-static inline void __exit_mm(struct task_struct * tsk)
+void exit_mm(struct task_struct * tsk)
 {
 	struct mm_struct *mm = tsk->mm;
 
@@ -506,11 +506,6 @@ static inline void __exit_mm(struct task
 	mmput(mm);
 }
 
-void exit_mm(struct task_struct *tsk)
-{
-	__exit_mm(tsk);
-}
-
 static inline void choose_new_parent(task_t *p, task_t *reaper, task_t *child_reaper)
 {
 	/*
@@ -809,7 +804,7 @@ fastcall NORET_TYPE void do_exit(long co
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead)
 		acct_process(code);
-	__exit_mm(tsk);
+	exit_mm(tsk);
 
 	exit_sem(tsk);
 	__exit_files(tsk);
