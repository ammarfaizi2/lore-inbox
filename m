Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVDLLFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVDLLFx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVDLLEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:04:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:30410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262258AbVDLKdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:15 -0400
Message-Id: <200504121033.j3CAX1Pm005748@shell0.pdx.osdl.net>
Subject: [patch 150/198] reparent_to_init cleanup
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, coywolf@lovecn.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Coywolf Qi Hunt" <coywolf@lovecn.org>

This patch hides reparent_to_init().  reparent_to_init() should only be
called by daemonize().

Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/mach-voyager/voyager_thread.c |    1 -
 25-akpm/include/linux/sched.h                   |    1 -
 25-akpm/kernel/exit.c                           |    2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/i386/mach-voyager/voyager_thread.c~reparent_to_init-cleanup arch/i386/mach-voyager/voyager_thread.c
--- 25/arch/i386/mach-voyager/voyager_thread.c~reparent_to_init-cleanup	2005-04-12 03:21:39.578120112 -0700
+++ 25-akpm/arch/i386/mach-voyager/voyager_thread.c	2005-04-12 03:21:39.583119352 -0700
@@ -126,7 +126,6 @@ thread(void *unused)
 
 	kvoyagerd_running = 1;
 
-	reparent_to_init();
 	daemonize(THREAD_NAME);
 
 	set_timeout = 0;
diff -puN include/linux/sched.h~reparent_to_init-cleanup include/linux/sched.h
--- 25/include/linux/sched.h~reparent_to_init-cleanup	2005-04-12 03:21:39.579119960 -0700
+++ 25-akpm/include/linux/sched.h	2005-04-12 03:21:39.585119048 -0700
@@ -1021,7 +1021,6 @@ extern void exit_itimers(struct signal_s
 
 extern NORET_TYPE void do_group_exit(int);
 
-extern void reparent_to_init(void);
 extern void daemonize(const char *, ...);
 extern int allow_signal(int);
 extern int disallow_signal(int);
diff -puN kernel/exit.c~reparent_to_init-cleanup kernel/exit.c
--- 25/kernel/exit.c~reparent_to_init-cleanup	2005-04-12 03:21:39.581119656 -0700
+++ 25-akpm/kernel/exit.c	2005-04-12 03:21:39.586118896 -0700
@@ -220,7 +220,7 @@ static inline int has_stopped_jobs(int p
  *
  * NOTE that reparent_to_init() gives the caller full capabilities.
  */
-void reparent_to_init(void)
+static inline void reparent_to_init(void)
 {
 	write_lock_irq(&tasklist_lock);
 
_
