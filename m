Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262613AbSJHBsF>; Mon, 7 Oct 2002 21:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262614AbSJHBsF>; Mon, 7 Oct 2002 21:48:05 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:1802
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262613AbSJHBsE> convert rfc822-to-8bit; Mon, 7 Oct 2002 21:48:04 -0400
Subject: [PATCH] getpid() comment typo
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 21:53:42 -0400
Message-Id: <1034042022.29467.282.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Comment above getpid() is wrong.

This patch fixes it, and expands the comment to explain why on earth we
have getpid() returning ->tgid and not ->pid.

Patch is against 2.5.41, por favor, mi mejor pingüino, se aplica.

	Robert Love

diff -urN linux-2.5.41/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.41/kernel/timer.c	2002-10-07 14:24:00.000000000 -0400
+++ linux/kernel/timer.c	2002-10-07 21:37:28.000000000 -0400
@@ -798,10 +798,18 @@
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
 



