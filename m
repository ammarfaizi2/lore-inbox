Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWHJUQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWHJUQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWHJUQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:16:17 -0400
Received: from mail.suse.de ([195.135.220.2]:7568 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932241AbWHJTfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:24 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [11/145] x86_64: Add ppoll/pselect syscalls
Message-Id: <20060810193523.9734713C1F@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:23 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Needed TIF_RESTORE_SIGMASK first

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/ia32/ia32entry.S |    4 ++--
 include/asm-x86_64/unistd.h  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux/arch/x86_64/ia32/ia32entry.S
===================================================================
--- linux.orig/arch/x86_64/ia32/ia32entry.S
+++ linux/arch/x86_64/ia32/ia32entry.S
@@ -703,8 +703,8 @@ ia32_sys_call_table:
 	.quad sys_readlinkat		/* 305 */
 	.quad sys_fchmodat
 	.quad sys_faccessat
-	.quad quiet_ni_syscall		/* pselect6 for now */
-	.quad quiet_ni_syscall		/* ppoll for now */
+	.quad compat_sys_pselect6
+	.quad compat_sys_ppoll
 	.quad sys_unshare		/* 310 */
 	.quad compat_sys_set_robust_list
 	.quad compat_sys_get_robust_list
Index: linux/include/asm-x86_64/unistd.h
===================================================================
--- linux.orig/include/asm-x86_64/unistd.h
+++ linux/include/asm-x86_64/unistd.h
@@ -600,9 +600,9 @@ __SYSCALL(__NR_fchmodat, sys_fchmodat)
 #define __NR_faccessat		269
 __SYSCALL(__NR_faccessat, sys_faccessat)
 #define __NR_pselect6		270
-__SYSCALL(__NR_pselect6, sys_ni_syscall)	/* for now */
+__SYSCALL(__NR_pselect6, sys_pselect6)
 #define __NR_ppoll		271
-__SYSCALL(__NR_ppoll,	sys_ni_syscall)		/* for now */
+__SYSCALL(__NR_ppoll,	sys_ppoll)
 #define __NR_unshare		272
 __SYSCALL(__NR_unshare,	sys_unshare)
 #define __NR_set_robust_list	273
