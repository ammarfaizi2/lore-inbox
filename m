Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVCDLLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVCDLLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVCDLE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:04:57 -0500
Received: from cncln.online.ln.cn ([218.24.136.48]:32629 "EHLO gcrj.com")
	by vger.kernel.org with ESMTP id S262769AbVCDLCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:02:55 -0500
From: "zwx" <zwx@gcrj.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.11-rc5-mm1 
Date: Fri, 4 Mar 2005 19:01:46 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Thread-Index: AcUgF8kXewM8uYDHQUuYtVPbN0caQAAkb8NA
In-Reply-To: <200503031925.j23JPDDS004025@ccure.user-mode-linux.org>
Message-Id: <200503041858970.SM01164@zwx2c>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jeff Dike
Sent: Friday, March 04, 2005 3:25 AM
To: Chris Wright
Cc: Jeff Dike; Andrew Morton; linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1 

chrisw@osdl.org said:
> Thanks, I'll push that with rest of audit changes.

Applies on top of your changes.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.10/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/ptrace.c	2005-03-03
11:41:34.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/ptrace.c	2005-03-03
11:42:41.000000000 -0500
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

