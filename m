Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268351AbUIQEQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268351AbUIQEQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268353AbUIQENw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:13:52 -0400
Received: from [12.177.129.25] ([12.177.129.25]:6340 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268370AbUIQENF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:13:05 -0400
Message-Id: <200409170517.i8H5HM2J005362@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Comment UML's signal handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Sep 2004 01:17:21 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a couple of comments so that people don't get confused into making
misguided fixes, and I don't get confused into applying them.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/kernel/signal_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/signal_user.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/signal_user.c	2004-09-16 22:59:24.000000000 -0400
@@ -80,6 +80,12 @@
 	change_signals(SIG_UNBLOCK);
 }
 
+/* These are the asynchronous signals.  SIGVTALRM and SIGARLM are handled
+ * together under SIGVTALRM_BIT.  SIGPROF is excluded because we want to
+ * be able to profile all of UML, not just the non-critical sections.  If
+ * profiling is not thread-safe, then that is not my problem.  We can disable
+ * profiling when SMP is enabled in that case.
+ */
 #define SIGIO_BIT 0
 #define SIGVTALRM_BIT 1
 
@@ -114,6 +120,11 @@
 		sigaddset(&mask, SIGVTALRM);
 		sigaddset(&mask, SIGALRM);
 	}
+
+	/* This is safe - sigprocmask is guaranteed to copy locally the
+	 * value of new_set, do his work and then, at the end, write to
+	 * old_set.
+	 */
 	if(sigprocmask(SIG_UNBLOCK, &mask, &mask) < 0)
 		panic("Failed to enable signals");
 	ret = enable_mask(&mask);

