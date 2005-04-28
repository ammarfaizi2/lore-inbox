Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVD1VcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVD1VcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 17:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVD1VcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 17:32:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262222AbVD1VcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 17:32:22 -0400
Date: Thu, 28 Apr 2005 14:32:14 -0700
Message-Id: <200504282132.j3SLWECn022030@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix error recovery path for arch_setup_additional_pages
Emacs: more boundary conditions than the Middle East.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If arch_setup_additional_pages fails, the error path will do some double-frees.
This fixes it.

Signed-off-by: Roland McGrath <roland@redhat.com>

Index: fs/binfmt_elf.c
===================================================================
--- 3608de2fc88b062070a9d197eda9cac1fb9635d3/fs/binfmt_elf.c  (mode:100644 sha1:6ae62cbf7c2e5ccd083aaea4648c47a04acb9059)
+++ 299f7099d9c0c249573c37eb6c1200277c966a47/fs/binfmt_elf.c  (mode:100644 sha1:4f34e6b2ff6612b6ed59eab7e042852a3f958897)
@@ -945,7 +945,7 @@
 	retval = arch_setup_additional_pages(bprm, executable_stack);
 	if (retval < 0) {
 		send_sig(SIGKILL, current, 0);
-		goto out_free_dentry;
+		goto out;
 	}
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
