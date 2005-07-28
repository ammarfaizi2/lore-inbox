Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVG1RM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVG1RM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVG1QhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:37:01 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:49677 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261174AbVG1Qez
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:34:55 -0400
Message-Id: <200507281626.j6SGQkie009481@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/7] UML - Fix redundant assignment
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jul 2005 12:26:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By this point, .is_user has already been set, so this assignment is useless.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/skas/trap_user.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/trap_user.c	2005-07-27 17:00:34.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/trap_user.c	2005-07-27 17:01:58.000000000 -0400
@@ -58,7 +58,6 @@
         int segv = ((sig == SIGFPE) || (sig == SIGSEGV) || (sig == SIGBUS) ||
                     (sig == SIGILL) || (sig == SIGTRAP));
 
-	regs->skas.is_user = 1;
 	if (segv)
 		get_skas_faultinfo(pid, &regs->skas.faultinfo);
 	info = &sig_info[sig];

