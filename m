Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263536AbVCEEfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263536AbVCEEfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 23:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbVCDXUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:20:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:56730 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263235AbVCDVRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:17:23 -0500
Message-Id: <200503042117.j24LHI7l017973@shell0.pdx.osdl.net>
Subject: [patch 4/5] audit mips fix
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, yuasa@hh.iij4u.or.jp
From: akpm@osdl.org
Date: Fri, 04 Mar 2005 13:16:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

  CC      arch/mips/kernel/ptrace.o
arch/mips/kernel/ptrace.c: In function 'do_syscall_trace':
arch/mips/kernel/ptrace.c:310: warning: implicit declaration of function 'audit_syscall_entry'
arch/mips/kernel/ptrace.c:310: error: 'struct pt_regs' has no member named 'orig_eax'
arch/mips/kernel/ptrace.c:314: warning: implicit declaration of function 'audit_syscall_exit'

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/mips/kernel/ptrace.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/mips/kernel/ptrace.c~audit-mips-fix arch/mips/kernel/ptrace.c
--- 25/arch/mips/kernel/ptrace.c~audit-mips-fix	2005-03-04 13:16:25.000000000 -0800
+++ 25-akpm/arch/mips/kernel/ptrace.c	2005-03-04 13:16:25.000000000 -0800
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
+#include <linux/audit.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/user.h>
@@ -307,7 +308,7 @@ asmlinkage void do_syscall_trace(struct 
 {
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
-			audit_syscall_entry(current, regs->orig_eax,
+			audit_syscall_entry(current, regs->regs[2],
 			                    regs->regs[4], regs->regs[5],
 			                    regs->regs[6], regs->regs[7]);
 		else
_
