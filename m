Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWIBRWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWIBRWR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 13:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWIBRWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 13:22:17 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:23766 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751220AbWIBRWR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 13:22:17 -0400
Date: Sat, 2 Sep 2006 21:22:16 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Hobein <ah2@delair.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
Subject: [PATCH] eligible_child: remove an obsolete ->tgid check
Message-ID: <20060902172216.GA456@oleg>
References: <200608312305.47515.ah2@delair.de> <200609010936.39015.ah2@delair.de> <20060901004920.7643a40e.akpm@osdl.org> <Pine.LNX.4.64.0609011117440.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609011117440.27779@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is not possible to find a sub-thread in ->children/->ptrace_children
lists, ptrace_attach() does not allow to attach to sub-threads.

Even if it was possible to ptrace the task from the same thread group,
we can't allow to release ->group_leader while there are others (ptracer)
threads in the same group.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/kernel/exit.c~	2006-09-02 21:08:59.000000000 +0400
+++ 2.6.18-rc4/kernel/exit.c	2006-09-02 21:09:12.000000000 +0400
@@ -1051,7 +1051,7 @@ static int eligible_child(pid_t pid, int
 	 * Do not consider thread group leaders that are
 	 * in a non-empty thread group:
 	 */
-	if (current->tgid != p->tgid && delay_group_leader(p))
+	if (delay_group_leader(p))
 		return 2;
 
 	if (security_task_wait(p))


-- 
VGER BF report: U 0.499788
