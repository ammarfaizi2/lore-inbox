Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUCOBjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 20:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbUCOBjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 20:39:19 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:54667 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S262182AbUCOBjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 20:39:17 -0500
Date: Mon, 15 Mar 2004 02:40:19 +0100
From: Tim Cambrant <tim@cambrant.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [TRIVIAL] current->state to set_current_state - kernel/signal.c
Message-ID: <20040315014019.GA6660@cambrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, here is a small fix to remove some obsolete usage of assigning
directly to current->state in kernel/signal.c.

       Tim Cambrant



--- linux-2.6.4/kernel/signal.c.orig	2004-03-15 02:27:22.801481976 +0100
+++ linux-2.6.4/kernel/signal.c	2004-03-15 02:29:56.648093736 +0100
@@ -2107,7 +2107,7 @@ sys_rt_sigtimedwait(const sigset_t __use
 			recalc_sigpending();
 			spin_unlock_irq(&current->sighand->siglock);
 
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			timeout = schedule_timeout(timeout);
 
 			spin_lock_irq(&current->sighand->siglock);
@@ -2529,7 +2529,7 @@ sys_signal(int sig, __sighandler_t handl
 asmlinkage long
 sys_pause(void)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule();
 	return -ERESTARTNOHAND;
 }

