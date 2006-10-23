Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWJWOZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWJWOZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWJWOZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:25:58 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:61368 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S964882AbWJWOZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:25:58 -0400
Date: Mon, 23 Oct 2006 18:25:54 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] trivial, make set_special_pids() static
Message-ID: <20061023142554.GA2246@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make set_special_pids() static, the only caller is daemonize().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc2-mm2/include/linux/sched.h~ssp	2006-10-22 19:28:17.000000000 +0400
+++ rc2-mm2/include/linux/sched.h	2006-10-23 18:20:04.000000000 +0400
@@ -1280,7 +1280,6 @@ extern struct   mm_struct init_mm;
 
 #define find_task_by_pid(nr)	find_task_by_pid_type(PIDTYPE_PID, nr)
 extern struct task_struct *find_task_by_pid_type(int type, int pid);
-extern void set_special_pids(pid_t session, pid_t pgrp);
 extern void __set_special_pids(pid_t session, pid_t pgrp);
 
 /* per-UID process charging. */
--- rc2-mm2/kernel/exit.c~ssp	2006-10-22 19:28:17.000000000 +0400
+++ rc2-mm2/kernel/exit.c	2006-10-23 18:19:39.000000000 +0400
@@ -314,7 +314,7 @@ void __set_special_pids(pid_t session, p
 	}
 }
 
-void set_special_pids(pid_t session, pid_t pgrp)
+static void set_special_pids(pid_t session, pid_t pgrp)
 {
 	write_lock_irq(&tasklist_lock);
 	__set_special_pids(session, pgrp);

