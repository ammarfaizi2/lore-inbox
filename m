Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312413AbSCURV5>; Thu, 21 Mar 2002 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312416AbSCURVo>; Thu, 21 Mar 2002 12:21:44 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:8067 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312404AbSCURVU>; Thu, 21 Mar 2002 12:21:20 -0500
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
cc: linux-alpha@vger.kernel.org
Subject: [PATCH] Needed to get 2.5.7 to compile and link on Alpha [7/10]
Message-Id: <E16o6CB-0005OH-00@lightning.hereintown.net>
Date: Thu, 21 Mar 2002 12:17:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three one liners.  Search and des^H^H^Hreplace.

-Chris


--- linux-2.5.7/arch/alpha/kernel/signal.c~	Mon Mar 18 15:37:14 2002
+++ linux-2.5.7/arch/alpha/kernel/signal.c	Wed Mar 20 09:27:47 2002
@@ -661,8 +661,8 @@
 				info.si_signo = signr;
 				info.si_errno = 0;
 				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
+				info.si_pid = current->parent->pid;
+				info.si_uid = current->parent->uid;
 			}
 
 			/* If the (new) signal is now blocked, requeue it.  */
@@ -701,7 +701,7 @@
 			case SIGSTOP:
 				current->state = TASK_STOPPED;
 				current->exit_code = signr;
-				if (!(current->p_pptr->sig->action[SIGCHLD-1]
+				if (!(current->parent->sig->action[SIGCHLD-1]
 				      .sa.sa_flags & SA_NOCLDSTOP))
 					notify_parent(current, SIGCHLD);
 				schedule();
