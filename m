Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVCBWbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVCBWbd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVCBW3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:29:40 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:46818 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262507AbVCBWZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:25:07 -0500
Date: Thu, 3 Mar 2005 07:24:54 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc5-mm1] mips: fixed do_syscall_trace
Message-Id: <20050303072454.45e08d9c.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had fixed an argument of audit_syscall_entry.
This patch is only for 2.6.11-rc5-mm1.

  CC      arch/mips/kernel/ptrace.o
arch/mips/kernel/ptrace.c: In function 'do_syscall_trace':
arch/mips/kernel/ptrace.c:310: warning: implicit declaration of function 'audit_syscall_entry'
arch/mips/kernel/ptrace.c:310: error: 'struct pt_regs' has no member named 'orig_eax'
arch/mips/kernel/ptrace.c:314: warning: implicit declaration of function 'audit_syscall_exit'
make[1]: *** [arch/mips/kernel/ptrace.o] Error 1
make: *** [arch/mips/kernel] Error 2

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff b-orig/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
--- b-orig/arch/mips/kernel/ptrace.c	Fri Feb 25 01:40:47 2005
+++ b/arch/mips/kernel/ptrace.c	Thu Mar  3 06:47:36 2005
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
+#include <linux/audit.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/user.h>
@@ -307,7 +308,7 @@
 {
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
-			audit_syscall_entry(current, regs->orig_eax,
+			audit_syscall_entry(current, regs->regs[2],
 			                    regs->regs[4], regs->regs[5],
 			                    regs->regs[6], regs->regs[7]);
 		else

