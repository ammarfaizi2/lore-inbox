Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWA3NgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWA3NgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWA3NgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:36:12 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:29652 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932269AbWA3NgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:36:10 -0500
Message-ID: <43DE285C.D05E5748@tv-sign.ru>
Date: Mon, 30 Jan 2006 17:53:16 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] don't touch current->tasks in de_thread()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

switch_exec_pids() already added 'current' to init_task.tasks,
no need to re-add in de_thread().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/fs/exec.c~	2006-01-19 18:13:06.000000000 +0300
+++ RC-1/fs/exec.c	2006-01-30 20:17:20.000000000 +0300
@@ -713,8 +713,6 @@ static int de_thread(struct task_struct 
 			__ptrace_link(current, parent);
 		}
 
-		list_del(&current->tasks);
-		list_add_tail(&current->tasks, &init_task.tasks);
 		current->exit_signal = SIGCHLD;
 
 		BUG_ON(leader->exit_state != EXIT_ZOMBIE);
