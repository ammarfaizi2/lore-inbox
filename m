Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263955AbTDIWs6 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263956AbTDIWs6 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:48:58 -0400
Received: from palrel11.hp.com ([156.153.255.246]:26844 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263955AbTDIWs4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:48:56 -0400
Date: Wed, 9 Apr 2003 16:00:35 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304092300.h39N0Zjn011912@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] correct vm_page_prot on stack pages
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below is needed to make it possible to map stack pages
without execution permission (as we do on ia64).

	--david

diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Wed Apr  9 14:49:49 2003
+++ b/fs/exec.c	Wed Apr  9 14:49:49 2003
@@ -407,7 +407,7 @@
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end = STACK_TOP;
 #endif
-		mpnt->vm_page_prot = PAGE_COPY;
+		mpnt->vm_page_prot = protection_map[VM_STACK_FLAGS & 0x7];
 		mpnt->vm_flags = VM_STACK_FLAGS;
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
