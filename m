Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262156AbSJFTjY>; Sun, 6 Oct 2002 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbSJFTjY>; Sun, 6 Oct 2002 15:39:24 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:65285
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262156AbSJFTjW>; Sun, 6 Oct 2002 15:39:22 -0400
Subject: [PATCH] 2.4: get_pid() typo fix
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 15:44:59 -0400
Message-Id: <1033933500.11402.4466.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnificent Marcelo,

Fix a typo in the comment of getpid() - we return current->tgid these
days, not current->pid.  Additionally, add some new comments explaining
exactly why we return the tgid and how this works.

Patch is against 2.4.20-pre9, please apply.

	Robert Love

diff -urN linux-2.4.20-pre9/kernel/timer.c linux/kernel/timer.c
--- linux-2.4.20-pre9/kernel/timer.c	2002-10-06 14:57:20.000000000 -0400
+++ linux/kernel/timer.c	2002-10-06 15:03:31.000000000 -0400
@@ -740,10 +740,18 @@
  * The Alpha uses getxpid, getxuid, and getxgid instead.  Maybe this
  * should be moved into arch/i386 instead?
  */
- 
+
+/**
+ * sys_getpid - return the thread group id of the current process
+ *
+ * Note, despite the name, this returns the tgid not the pid.  The tgid and
+ * the pid are identical unless CLONE_THREAD was specified on clone() in
+ * which case the tgid is the same in all threads of the same group.
+ *
+ * This is SMP safe as current->tgid does not change.
+ */
 asmlinkage long sys_getpid(void)
 {
-	/* This is SMP safe - current->pid doesn't change */
 	return current->tgid;
 }
 



