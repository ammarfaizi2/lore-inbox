Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVCCRey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVCCRey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVCCRa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:30:59 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:58631 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262210AbVCCRWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:22:43 -0500
Message-Id: <200503031925.j23JPDDS004025@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Chris Wright <chrisw@osdl.org>
cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1 
In-Reply-To: Your message of "Thu, 03 Mar 2005 08:21:14 PST."
             <20050303162114.GP28536@shell0.pdx.osdl.net> 
References: <20050301012741.1d791cd2.akpm@osdl.org> <20050301214916.GJ28536@shell0.pdx.osdl.net> <200503030804.j2384WBY016301@ccure.user-mode-linux.org>  <20050303162114.GP28536@shell0.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Mar 2005 14:25:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chrisw@osdl.org said:
> Thanks, I'll push that with rest of audit changes.

Applies on top of your changes.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.10/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/ptrace.c	2005-03-03 11:41:34.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/ptrace.c	2005-03-03 11:42:41.000000000 -0500
@@ -341,11 +341,15 @@
 
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
-			audit_syscall_entry(current, regs->orig_eax,
-					    regs->ebx, regs->ecx,
-					    regs->edx, regs->esi);
+			audit_syscall_entry(current, 
+					    UPT_SYSCALL_NR(&regs->regs),
+					    UPT_SYSCALL_ARG1(&regs->regs),
+					    UPT_SYSCALL_ARG2(&regs->regs),
+					    UPT_SYSCALL_ARG3(&regs->regs),
+					    UPT_SYSCALL_ARG4(&regs->regs));
 		else
-			audit_syscall_exit(current, regs->eax);
+			audit_syscall_exit(current, 
+					   UPT_SYSCALL_RET(&regs->regs));
 	}
 
 	/* Fake a debug trap */

