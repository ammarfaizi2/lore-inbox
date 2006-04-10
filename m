Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWDKAge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWDKAge (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 20:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWDKAgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 20:36:15 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:7140 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932215AbWDKAgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 20:36:10 -0400
Message-Id: <200604102337.k3ANb8uX006848@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/3] UML - __user annotations
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Apr 2006 19:37:08 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

bits of uml __user annotations lost in merge

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-mm/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-i386/signal.c	2006-04-08 17:21:35.000000000 -0400
+++ linux-2.6.16-mm/arch/um/sys-i386/signal.c	2006-04-10 14:39:42.000000000 -0400
@@ -57,7 +57,7 @@ static int copy_sc_from_user_skas(struct
 	return(0);
 }
 
-int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate __user *to_fp,
+int copy_sc_to_user_skas(struct sigcontext __user *to, struct _fpstate __user *to_fp,
                          struct pt_regs *regs, unsigned long sp)
 {
   	struct sigcontext sc;
@@ -132,7 +132,7 @@ int copy_sc_from_user_tt(struct sigconte
 	return(err);
 }
 
-int copy_sc_to_user_tt(struct sigcontext *to, struct _fpstate __user *fp,
+int copy_sc_to_user_tt(struct sigcontext __user *to, struct _fpstate __user *fp,
 		       struct sigcontext *from, int fpsize, unsigned long sp)
 {
 	struct _fpstate __user *to_fp;
@@ -167,7 +167,7 @@ static int copy_sc_from_user(struct pt_r
 	return(ret);
 }
 
-static int copy_sc_to_user(struct sigcontext *to, struct _fpstate __user *fp,
+static int copy_sc_to_user(struct sigcontext __user *to, struct _fpstate __user *fp,
 			   struct pt_regs *from, unsigned long sp)
 {
 	return(CHOOSE_MODE(copy_sc_to_user_tt(to, fp, UPT_SC(&from->regs),

