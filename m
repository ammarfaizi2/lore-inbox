Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbWBELmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbWBELmn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbWBELmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:42:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34278 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751714AbWBELmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:42:42 -0500
Date: Sun, 5 Feb 2006 12:42:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] small cleanups
Message-ID: <20060205114229.GA3110@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While hacking system stopping, I ran around few trivial places that
could be cleaned up... No code changes.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/kernel/signal.c b/kernel/signal.c
index b373fc2..50eb4f5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -314,7 +314,7 @@ flush_signals(struct task_struct *t)
 	unsigned long flags;
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
-	clear_tsk_thread_flag(t,TIF_SIGPENDING);
+	clear_tsk_thread_flag(t, TIF_SIGPENDING);
 	flush_sigqueue(&t->pending);
 	flush_sigqueue(&t->signal->shared_pending);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
@@ -403,7 +403,7 @@ void __exit_signal(struct task_struct *t
 		sig = NULL;	/* Marker for below.  */
 	}
 	rcu_read_unlock();
-	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
+	clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
 	flush_sigqueue(&tsk->pending);
 	if (sig) {
 		/*
@@ -572,9 +572,9 @@ int dequeue_signal(struct task_struct *t
  		if (!(tsk->signal->flags & SIGNAL_GROUP_EXIT))
  			tsk->signal->flags |= SIGNAL_STOP_DEQUEUED;
  	}
-	if ( signr &&
+	if (signr &&
 	     ((info->si_code & __SI_MASK) == __SI_TIMER) &&
-	     info->si_sys_private){
+	     info->si_sys_private) {
 		/*
 		 * Release the siglock to ensure proper locking order
 		 * of timer locks outside of siglocks.  Note, we leave
diff --git a/mm/pdflush.c b/mm/pdflush.c
index c4b6d0a..6f740ab 100644
--- a/mm/pdflush.c
+++ b/mm/pdflush.c
@@ -17,8 +17,8 @@
 #include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/fs.h>		// Needed by writeback.h
-#include <linux/writeback.h>	// Prototypes pdflush_operation()
+#include <linux/fs.h>		/* Needed by writeback.h	  */
+#include <linux/writeback.h>	/* Prototypes pdflush_operation() */
 #include <linux/kthread.h>
 #include <linux/cpuset.h>
 
@@ -202,8 +202,7 @@ int pdflush_operation(void (*fn)(unsigne
 	unsigned long flags;
 	int ret = 0;
 
-	if (fn == NULL)
-		BUG();		/* Hard to diagnose if it's deferred */
+	BUG_ON(!fn);		/* Hard to diagnose if it's deferred */
 
 	spin_lock_irqsave(&pdflush_lock, flags);
 	if (list_empty(&pdflush_list)) {

-- 
Thanks, Sharp!
