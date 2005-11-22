Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbVKVVHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVKVVHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbVKVVHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:07:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9886 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965187AbVKVVGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:06:53 -0500
Date: Tue, 22 Nov 2005 13:06:07 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: [patch 02/23] [PATCH] Dont auto-reap traced children
Message-ID: <20051122210607.GC28140@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ptrace-auto-reap-fix.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

If a task is being traced we never auto-reap it even if it might look
like its parent doesn't care. The tracer obviously _does_ care.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 kernel/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.2.orig/kernel/signal.c
+++ linux-2.6.14.2/kernel/signal.c
@@ -1524,7 +1524,7 @@ void do_notify_parent(struct task_struct
 
 	psig = tsk->parent->sighand;
 	spin_lock_irqsave(&psig->siglock, flags);
-	if (sig == SIGCHLD &&
+	if (!tsk->ptrace && sig == SIGCHLD &&
 	    (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
 	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
 		/*

--
