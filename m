Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbVLMW4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbVLMW4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbVLMWz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:55:28 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:60119 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030338AbVLMWzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:55:01 -0500
Subject: [PATCH -mm 5/9] unshare system call: system call registration for
	x86_64
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134514115.11972.195.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 17:54:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
[PATCH -mm 5/9] unshare system call: system call registration for x86_64

Registers system call for the x86_64 architecture.

Changes since the first submission of this patch on 12/12/05:
	None.
 
Signed-off-by: Janak Desai <janak@us.ibm.com>
 
---
 
 arch/x86_64/ia32/ia32entry.S     |    1 +
 include/asm-x86_64/ia32_unistd.h |    3 ++-
 include/asm-x86_64/unistd.h      |    4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)
 
diff -Naurp 2.6.15-rc5-mm2/arch/x86_64/ia32/ia32entry.S 2.6.15-rc5-mm2+x86_64/arch/x86_64/ia32/ia32entry.S
--- 2.6.15-rc5-mm2/arch/x86_64/ia32/ia32entry.S	2005-12-12 03:05:40.000000000 +0000
+++ 2.6.15-rc5-mm2+x86_64/arch/x86_64/ia32/ia32entry.S	2005-12-12 20:33:22.000000000 +0000
@@ -666,6 +666,7 @@ ia32_sys_call_table:
 	.quad sys_inotify_init
 	.quad sys_inotify_add_watch
 	.quad sys_inotify_rm_watch
+	.quad sys_unshare
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
 		.quad ni_syscall
diff -Naurp 2.6.15-rc5-mm2/include/asm-x86_64/ia32_unistd.h 2.6.15-rc5-mm2+x86_64/include/asm-x86_64/ia32_unistd.h
--- 2.6.15-rc5-mm2/include/asm-x86_64/ia32_unistd.h	2005-10-28 00:02:08.000000000 +0000
+++ 2.6.15-rc5-mm2+x86_64/include/asm-x86_64/ia32_unistd.h	2005-12-12 20:35:35.000000000 +0000
@@ -299,7 +299,8 @@
 #define __NR_ia32_inotify_init		291
 #define __NR_ia32_inotify_add_watch	292
 #define __NR_ia32_inotify_rm_watch	293
+#define __NR_ia32_unshare		294
 
-#define IA32_NR_syscalls 294	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 295	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
diff -Naurp 2.6.15-rc5-mm2/include/asm-x86_64/unistd.h 2.6.15-rc5-mm2+x86_64/include/asm-x86_64/unistd.h
--- 2.6.15-rc5-mm2/include/asm-x86_64/unistd.h	2005-12-12 03:05:58.000000000 +0000
+++ 2.6.15-rc5-mm2+x86_64/include/asm-x86_64/unistd.h	2005-12-12 20:38:12.000000000 +0000
@@ -573,8 +573,10 @@ __SYSCALL(__NR_inotify_add_watch, sys_in
 __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
 #define __NR_migrate_pages	256
 __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
+#define __NR_unshare		257
+__SYSCALL(__NR_unshare, sys_unshare)
 
-#define __NR_syscall_max __NR_migrate_pages
+#define __NR_syscall_max __NR_unshare
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */


