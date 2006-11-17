Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756046AbWKQX7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046AbWKQX7p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756047AbWKQX7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:59:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37126 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756046AbWKQX7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:59:43 -0500
Date: Sat, 18 Nov 2006 00:59:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] make kernel/signal.c:kill_proc_info()
Message-ID: <20061117235942.GP31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global kill_proc_info() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/sched.h |    1 -
 kernel/signal.c       |    3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.19-rc5-mm2/include/linux/sched.h.old	2006-11-17 19:05:35.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/linux/sched.h	2006-11-17 19:05:43.000000000 +0100
@@ -1343,7 +1343,6 @@
 extern int kill_pid(struct pid *pid, int sig, int priv);
 extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
 extern int kill_pg_info(int, struct siginfo *, pid_t);
-extern int kill_proc_info(int, struct siginfo *, pid_t);
 extern void do_notify_parent(struct task_struct *, int);
 extern void force_sig(int, struct task_struct *);
 extern void force_sig_specific(int, struct task_struct *);
--- linux-2.6.19-rc5-mm2/kernel/signal.c.old	2006-11-17 19:05:51.000000000 +0100
+++ linux-2.6.19-rc5-mm2/kernel/signal.c	2006-11-17 19:06:03.000000000 +0100
@@ -1261,8 +1261,7 @@
 	return error;
 }
 
-int
-kill_proc_info(int sig, struct siginfo *info, pid_t pid)
+static int kill_proc_info(int sig, struct siginfo *info, pid_t pid)
 {
 	int error;
 	rcu_read_lock();

