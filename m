Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWAaKTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWAaKTP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWAaKTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:19:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16610 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750735AbWAaKTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:19:14 -0500
Date: Tue, 31 Jan 2006 10:20:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] whitespace cleanups near signals
Message-ID: <20060131092046.GA2705@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whitespace cleanups in signal handling and journalling. No code
changes.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 4e9fff085d38a7155d0432d9793cb9f9f8baf2e9
tree db11a083fe375c5ac026d12ca7d5bb3f1c31fefa
parent 01d049aacf36961d361cfd382fcbf746afcbb61b
author <pavel@amd.ucw.cz> Tue, 31 Jan 2006 10:19:30 +0100
committer <pavel@amd.ucw.cz> Tue, 31 Jan 2006 10:19:30 +0100

 arch/i386/kernel/signal.c |    4 ++--
 fs/jbd/journal.c          |    3 ---
 kernel/signal.c           |    8 ++++----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
index 5ad8c65..b134d5c 100644
--- a/arch/i386/kernel/signal.c
+++ b/arch/i386/kernel/signal.c
@@ -643,7 +643,7 @@ int fastcall do_signal(struct pt_regs *r
 			regs->eax = regs->orig_eax;
 			regs->eip -= 2;
 		}
-		if (regs->eax == -ERESTART_RESTARTBLOCK){
+		if (regs->eax == -ERESTART_RESTARTBLOCK) {
 			regs->eax = __NR_restart_syscall;
 			regs->eip -= 2;
 		}
@@ -666,7 +666,7 @@ void do_notify_resume(struct pt_regs *re
 	}
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
-		do_signal(regs,oldset);
+		do_signal(regs, oldset);
 	
 	clear_thread_flag(TIF_IRET);
 }
diff --git a/fs/jbd/journal.c b/fs/jbd/journal.c
index 20b5918..42ac6bc 100644
--- a/fs/jbd/journal.c
+++ b/fs/jbd/journal.c
@@ -50,9 +50,6 @@ EXPORT_SYMBOL(journal_dirty_data);
 EXPORT_SYMBOL(journal_dirty_metadata);
 EXPORT_SYMBOL(journal_release_buffer);
 EXPORT_SYMBOL(journal_forget);
-#if 0
-EXPORT_SYMBOL(journal_sync_buffer);
-#endif
 EXPORT_SYMBOL(journal_flush);
 EXPORT_SYMBOL(journal_revoke);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 6ef3c90..883cc61 100644
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

-- 
Thanks, Sharp!
