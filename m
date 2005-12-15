Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVLOWtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVLOWtl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVLOWtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:49:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751178AbVLOWtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:49:40 -0500
Date: Thu, 15 Dec 2005 17:49:33 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200512152249.jBFMnXU8016756@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] *at syscalls: x64 syscalls
Cc: akpm@osdl.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -durp linux/arch/x86_64/ia32/ia32entry.S linux/arch/x86_64/ia32/ia32entry.S
--- linux/arch/x86_64/ia32/ia32entry.S	2005-09-13 17:07:07.000000000 -0700
+++ linux/arch/x86_64/ia32/ia32entry.S	2005-12-14 23:31:30.000000000 -0800
@@ -643,6 +643,17 @@ ia32_sys_call_table:
 	.quad sys_inotify_init
 	.quad sys_inotify_add_watch
 	.quad sys_inotify_rm_watch
+	.quad compat_sys_openat
+	.quad sys_mkdirat		/* 295 */
+	.quad sys_mknodat
+	.quad sys_fchownat
+	.quad sys_futimesat
+	.quad compat_sys_newfstatat
+	.quad sys_unlinkat		/* 300 */
+	.quad sys_renameat
+	.quad sys_linkat
+	.quad sys_symlinkat
+	.quad sys_readlinkat
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
 		.quad ni_syscall
diff -durp linux/include/asm-x86_64/ia32_unistd.h linux/include/asm-x86_64/ia32_unistd.h
--- linux/include/asm-x86_64/ia32_unistd.h	2005-09-10 16:18:23.000000000 -0700
+++ linux/include/asm-x86_64/ia32_unistd.h	2005-12-14 23:30:31.000000000 -0800
@@ -299,7 +299,18 @@
 #define __NR_ia32_inotify_init		291
 #define __NR_ia32_inotify_add_watch	292
 #define __NR_ia32_inotify_rm_watch	293
+#define __NR_ia32_opanat		294
+#define __NR_ia32_mkdirat		295
+#define __NR_ia32_mknodat		296
+#define __NR_ia32_fchownat		297
+#define __NR_ia32_futimesat		298
+#define __NR_ia32_newfstatat		299
+#define __NR_ia32_unlinkat		300
+#define __NR_ia32_renameat		301
+#define __NR_ia32_linkat		302
+#define __NR_ia32_symlinkat		303
+#define __NR_ia32_readlinkat		304
 
-#define IA32_NR_syscalls 294	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 305	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
diff -durp linux/include/asm-x86_64/unistd.h linux/include/asm-x86_64/unistd.h
--- linux/include/asm-x86_64/unistd.h	2005-11-17 18:30:51.000000000 -0800
+++ linux/include/asm-x86_64/unistd.h	2005-12-14 23:28:59.000000000 -0800
@@ -571,8 +571,30 @@ __SYSCALL(__NR_inotify_init, sys_inotify
 __SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
 #define __NR_inotify_rm_watch	255
 __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
+#define __NR_openat		256
+__SYSCALL(__NR_openat, sys_openat)
+#define __NR_mkdirat		257
+__SYSCALL(__NR_mkdirat, sys_mkdirat)
+#define __NR_mknodat		258
+__SYSCALL(__NR_mknodat, sys_mknodat)
+#define __NR_fchownat		259
+__SYSCALL(__NR_fchownat, sys_fchownat)
+#define __NR_futimesat		260
+__SYSCALL(__NR_futimesat, sys_futimesat)
+#define __NR_newfstatat		261
+__SYSCALL(__NR_newfstatat, sys_newfstatat)
+#define __NR_unlinkat		262
+__SYSCALL(__NR_unlinkat, sys_unlinkat)
+#define __NR_renameat		263
+__SYSCALL(__NR_renameat, sys_renameat)
+#define __NR_linkat		264
+__SYSCALL(__NR_linkat, sys_linkat)
+#define __NR_symlinkat		265
+__SYSCALL(__NR_symlinkat, sys_symlinkat)
+#define __NR_readlinkat		266
+__SYSCALL(__NR_readlinkat, sys_readlinkat)
 
-#define __NR_syscall_max __NR_inotify_rm_watch
+#define __NR_syscall_max __NR_readlinkat
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
