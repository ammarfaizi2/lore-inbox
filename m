Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbTDSVLP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 17:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTDSVLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 17:11:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12275 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263470AbTDSVLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 17:11:14 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 19 Apr 2003 23:23:12 +0200 (MEST)
Message-Id: <UTC200304192123.h3JLNCK21665.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] correct error message for failed clone ns
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If copy_namespace() returns -EPERM, copy_process() will
return a confusing -ENOMEM. This fixes that.

Andries

----------------------------------------------------------------
diff -u --recursive --new-file -X /linux/dontdiff a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Sat Apr 19 18:27:16 2003
+++ b/kernel/fork.c	Sat Apr 19 18:27:07 2003
@@ -873,7 +873,8 @@
 		goto bad_fork_cleanup_sighand;
 	if (copy_mm(clone_flags, p))
 		goto bad_fork_cleanup_signal;
-	if (copy_namespace(clone_flags, p))
+	retval = copy_namespace(clone_flags, p);
+	if (retval)
 		goto bad_fork_cleanup_mm;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
