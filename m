Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311237AbSCSNwu>; Tue, 19 Mar 2002 08:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311236AbSCSNwl>; Tue, 19 Mar 2002 08:52:41 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:42784 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S311234AbSCSNwb>; Tue, 19 Mar 2002 08:52:31 -0500
Message-ID: <61DB42B180EAB34E9D28346C11535A78062D69@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'davem@redhat.com'" <davem@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Trivial patches for sparc64 in 2.5.7
Date: Tue, 19 Mar 2002 08:52:19 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't imagine that you don't have these already, but here's some fixes to
/arch/sparc64 stuff to replace the p_pptr with parent on sparc64 that got
changed in 2.5.7

On a side note, I don't get to do to much with the kernel, so I hope my
little fixes and e-mails to you don't bug you too much.  I like the sparc,
because it doesn't get as much traffic, and there's more room for finding
things like this as I teach myself more about the kernel internals.  

Bruce H.


--- ./arch/sparc64/kernel/ptrace.c.old	Tue Mar 19 08:28:18 2002
+++ ./arch/sparc64/kernel/ptrace.c	Tue Mar 19 08:29:36 2002
@@ -194,7 +194,7 @@
 			goto out_tsk;
 		}
 	}
-	if (child->p_pptr != current) {
+	if (child->parent != current) {
 		pt_error_return(regs, ESRCH);
 		goto out_tsk;

 	
--- ./arch/sparc64/kernel/signal.c.old	Tue Mar 19 08:36:08 2002
+++ ./arch/sparc64/kernel/signal.c	Tue Mar 19 08:37:44 2002
@@ -729,8 +729,8 @@
 				info.si_signo = signr;
 				info.si_errno = 0;
 				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
+				info.si_pid = current->parent->pid;
+				info.si_uid = current->parent->uid;
 			}
 
 			/* If the (new) signal is now blocked, requeue it.
*/
@@ -772,7 +772,7 @@
 				struct signal_struct *sig;
 
 				current->exit_code = signr;
-				sig = current->p_pptr->sig;
+				sig = current->parent->sig;
 				preempt_disable();
 				current->state = TASK_STOPPED;
 				if (sig &&
!(sig->action[SIGCHLD-1].sa.sa_flags &


--- ./arch/sparc64/kernel/signal32.c.old	Tue Mar 19 08:40:10 2002
+++ ./arch/sparc64/kernel/signal32.c	Tue Mar 19 08:40:54 2002
@@ -1403,8 +1403,8 @@
 				info.si_signo = signr;
 				info.si_errno = 0;
 				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
+				info.si_pid = current->parent->pid;
+				info.si_uid = current->parent->uid;
 			}
 
 			/* If the (new) signal is now blocked, requeue it.
*/
@@ -1446,7 +1446,7 @@
 				struct signal_struct *sig;
 
 				current->exit_code = signr;
-				sig = current->p_pptr->sig;
+				sig = current->parent->sig;
 				preempt_disable();
 				current->state = TASK_STOPPED;
 				if (sig &&
!(sig->action[SIGCHLD-1].sa.sa_flags &


