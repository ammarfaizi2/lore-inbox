Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbSKLCW0>; Mon, 11 Nov 2002 21:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbSKLCQK>; Mon, 11 Nov 2002 21:16:10 -0500
Received: from holomorphy.com ([66.224.33.161]:46008 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266120AbSKLCQB>;
	Mon, 11 Nov 2002 21:16:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [8/9] remove __has_stopped_jobs()
Message-Id: <E18BQf6-00041M-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 11 Nov 2002 18:20:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes has_stopped_jobs(), which is unused.

 exit.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)


diff -urpN 06_alloc_virtual/kernel/exit.c 07_has_stopped_jobs/kernel/exit.c
--- 06_alloc_virtual/kernel/exit.c	2002-11-10 19:28:30.000000000 -0800
+++ 07_has_stopped_jobs/kernel/exit.c	2002-11-11 17:31:21.000000000 -0800
@@ -190,7 +190,7 @@ int is_orphaned_pgrp(int pgrp)
 	return will_become_orphaned_pgrp(pgrp, 0);
 }
 
-static inline int __has_stopped_jobs(int pgrp)
+static inline int has_stopped_jobs(int pgrp)
 {
 	int retval = 0;
 	struct task_struct *p;
@@ -206,17 +206,6 @@ static inline int __has_stopped_jobs(int
 	return retval;
 }
 
-static inline int has_stopped_jobs(int pgrp)
-{
-	int retval;
-
-	read_lock(&tasklist_lock);
-	retval = __has_stopped_jobs(pgrp);
-	read_unlock(&tasklist_lock);
-
-	return retval;
-}
-
 /**
  * reparent_to_init() - Reparent the calling kernel thread to the init task.
  *
@@ -504,7 +493,7 @@ static inline void reparent_thread(task_
 	    (p->session == father->session)) {
 		int pgrp = p->pgrp;
 
-		if (__will_become_orphaned_pgrp(pgrp, 0) && __has_stopped_jobs(pgrp)) {
+		if (__will_become_orphaned_pgrp(pgrp, 0) && has_stopped_jobs(pgrp)) {
 			__kill_pg_info(SIGHUP, (void *)1, pgrp);
 			__kill_pg_info(SIGCONT, (void *)1, pgrp);
 		}
@@ -589,7 +578,7 @@ static void exit_notify(void)
 	if ((t->pgrp != current->pgrp) &&
 	    (t->session == current->session) &&
 	    __will_become_orphaned_pgrp(current->pgrp, current) &&
-	    __has_stopped_jobs(current->pgrp)) {
+	    has_stopped_jobs(current->pgrp)) {
 		__kill_pg_info(SIGHUP, (void *)1, current->pgrp);
 		__kill_pg_info(SIGCONT, (void *)1, current->pgrp);
 	}
