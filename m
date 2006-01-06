Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWAFTEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWAFTEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWAFTEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:04:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2213 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932474AbWAFTEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:04:33 -0500
Date: Fri, 6 Jan 2006 14:04:29 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200601061904.k06J4TOs027900@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] updated *at function patch
Cc: akpm@osdl.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index e0eb0c7..cae0248 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -643,6 +643,19 @@ ia32_sys_call_table:
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
+	.quad sys_fchmodat		/* 305 */
+	.quad sys_faccessat
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
 		.quad ni_syscall
diff --git a/include/asm-x86_64/ia32_unistd.h b/include/asm-x86_64/ia32_unistd.h
index d5166ec..6215317 100644
--- a/include/asm-x86_64/ia32_unistd.h
+++ b/include/asm-x86_64/ia32_unistd.h
@@ -299,7 +299,20 @@
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
+#define __NR_ia32_fchmodat		305
+#define __NR_ia32_faccessat		306
 
-#define IA32_NR_syscalls 294	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 307	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index 2c42150..52aeee6 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -571,8 +571,34 @@ __SYSCALL(__NR_inotify_init, sys_inotify
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
+#define __NR_fchmodat		267
+__SYSCALL(__NR_fchmodat, sys_fchmodat)
+#define __NR_faccessat		268
+__SYSCALL(__NR_faccessat, sys_faccessat)
 
-#define __NR_syscall_max __NR_inotify_rm_watch
+#define __NR_syscall_max __NR_faccessat
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
