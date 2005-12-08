Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVLHWPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVLHWPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVLHWPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:15:16 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:1750 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751241AbVLHWPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:15:14 -0500
Subject: [PATCH -mm 5/5] New system call, unshare (x86_64)
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: chrisw@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.org, janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134080115.5476.20.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 08 Dec 2005 17:15:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 5/5] unshare system call: System call registration for x86_64

Signed-off-by: Janak Desai


 arch/x86_64/ia32/ia32entry.S     |    1 +
 include/asm-x86_64/ia32_unistd.h |    3 ++-
 include/asm-x86_64/unistd.h      |    4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)


diff -Naurp 2.6.15-rc5-mm1/arch/x86_64/ia32/ia32entry.S
2.6.15-rc5-mm1+unshare-x86_64/arch/x86_64/ia32/ia32entry.S
--- 2.6.15-rc5-mm1/arch/x86_64/ia32/ia32entry.S	2005-10-28
00:02:08.000000000 +0000
+++
2.6.15-rc5-mm1+unshare-x86_64/arch/x86_64/ia32/ia32entry.S	2005-12-08
18:19:14.000000000 +0000
@@ -643,6 +643,7 @@ ia32_sys_call_table:
 	.quad sys_inotify_init
 	.quad sys_inotify_add_watch
 	.quad sys_inotify_rm_watch
+	.quad sys_unshare
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
 		.quad ni_syscall
diff -Naurp 2.6.15-rc5-mm1/include/asm-x86_64/ia32_unistd.h
2.6.15-rc5-mm1+unshare-x86_64/include/asm-x86_64/ia32_unistd.h
--- 2.6.15-rc5-mm1/include/asm-x86_64/ia32_unistd.h	2005-10-28
00:02:08.000000000 +0000
+++
2.6.15-rc5-mm1+unshare-x86_64/include/asm-x86_64/ia32_unistd.h	2005-12-08 18:14:28.000000000 +0000
@@ -299,7 +299,8 @@
 #define __NR_ia32_inotify_init		291
 #define __NR_ia32_inotify_add_watch	292
 #define __NR_ia32_inotify_rm_watch	293
+#define __NR_ia32_unshare		294
 
-#define IA32_NR_syscalls 294	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 295	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
diff -Naurp 2.6.15-rc5-mm1/include/asm-x86_64/unistd.h
2.6.15-rc5-mm1+unshare-x86_64/include/asm-x86_64/unistd.h
--- 2.6.15-rc5-mm1/include/asm-x86_64/unistd.h	2005-12-06
21:06:20.000000000 +0000
+++ 2.6.15-rc5-mm1+unshare-x86_64/include/asm-x86_64/unistd.h	2005-12-08
18:15:48.000000000 +0000
@@ -571,8 +571,10 @@ __SYSCALL(__NR_inotify_init, sys_inotify
 __SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
 #define __NR_inotify_rm_watch	255
 __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
+#define __NR_unshare		256
+__SYSCALL(__NR_unshare, sys_unshare)
 
-#define __NR_syscall_max __NR_inotify_rm_watch
+#define __NR_syscall_max __NR_unshare
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */


