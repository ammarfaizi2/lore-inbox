Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVLMNoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVLMNoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVLMNns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:43:48 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:1245 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932224AbVLMNnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:43:22 -0500
Subject: [PATCH -mm 5/9] unshare system call : system call registration for
	x86_64
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134481307.25431.187.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 08:43:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 5/9] unshare system call: System call registration for x86_64
                                                                                
Signed-off-by: Janak Desai
                                                                                

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


