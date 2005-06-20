Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVFTS7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVFTS7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVFTS7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:59:08 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:31498 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261491AbVFTS5v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:57:51 -0400
Message-Id: <200506201851.j5KIpBBc008473@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       domen@coderock.org
Subject: [PATCH 1/8] UML - Fix sizeof usage
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Jun 2005 14:51:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>
Subject: [KJ] [patch] um: copy_from_user size fix in signal.c

Size of pointer doesn't seem right, but maybe my solution isn't
either (sig_size maybe?).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.12.orig/arch/um/sys-i386/signal.c	2005-06-20 11:54:53.000000000 -0400
+++ linux-2.6.12/arch/um/sys-i386/signal.c	2005-06-20 11:55:47.000000000 -0400
@@ -312,7 +312,7 @@ long sys_sigreturn(struct pt_regs regs)
 	unsigned long __user *extramask = frame->extramask;
 	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
 
-	if(copy_from_user(&set.sig[0], oldmask, sizeof(&set.sig[0])) ||
+	if(copy_from_user(&set.sig[0], oldmask, sizeof(set.sig[0])) ||
 	   copy_from_user(&set.sig[1], extramask, sig_size))
 		goto segfault;
 

