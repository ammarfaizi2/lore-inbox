Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263343AbVGOTwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbVGOTwO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263352AbVGOTwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:52:14 -0400
Received: from peabody.ximian.com ([130.57.169.10]:42640 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263343AbVGOTwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:52:08 -0400
Subject: [patch] inotify: add x86-64 syscall numbers
From: Robert Love <rml@novell.com>
To: Andi Kleen <ak@suse.de>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 15:52:05 -0400
Message-Id: <1121457125.830.22.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Attached patch adds the inotify syscall numbers to x86-64.  Also adds
the new ioprio_get() and ioprio_set() calls to the IA32 layer.

	Robert Love


Add the inotify syscalls to x86-64

Signed-off-by: Robert Love <rml@novell.com>

 arch/x86_64/ia32/ia32entry.S     |    8 ++++++--
 include/asm-x86_64/ia32_unistd.h |    7 ++++++-
 include/asm-x86_64/unistd.h      |    8 +++++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff -urN linux-2.6.13-rc3/arch/x86_64/ia32/ia32entry.S linux/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.13-rc3/arch/x86_64/ia32/ia32entry.S	2005-07-13 10:51:10.000000000 -0400
+++ linux/arch/x86_64/ia32/ia32entry.S	2005-07-15 15:47:59.000000000 -0400
@@ -591,11 +591,15 @@
 	.quad compat_sys_mq_getsetattr
 	.quad compat_sys_kexec_load	/* reserved for kexec */
 	.quad compat_sys_waitid
-	.quad quiet_ni_syscall		/* sys_altroot */
+	.quad quiet_ni_syscall		/* 285: sys_altroot */
 	.quad sys_add_key
 	.quad sys_request_key
 	.quad sys_keyctl
-	/* don't forget to change IA32_NR_syscalls */
+	.quad sys_ioprio_set
+	.quad sys_ioprio_get		/* 290 */
+	.quad sys_inotify_init
+	.quad sys_inotify_add_watch
+	.quad sys_inotify_rm_watch
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
 		.quad ni_syscall
diff -urN linux-2.6.13-rc3/include/asm-x86_64/ia32_unistd.h linux/include/asm-x86_64/ia32_unistd.h
--- linux-2.6.13-rc3/include/asm-x86_64/ia32_unistd.h	2005-07-13 10:51:00.000000000 -0400
+++ linux/include/asm-x86_64/ia32_unistd.h	2005-07-15 15:48:50.000000000 -0400
@@ -294,7 +294,12 @@
 #define __NR_ia32_add_key		286
 #define __NR_ia32_request_key	287
 #define __NR_ia32_keyctl		288
+#define __NR_ia32_ioprio_set		289
+#define __NR_ia32_ioprio_get		290
+#define __NR_ia32_inotify_init		291
+#define __NR_ia32_inotify_add_watch	292
+#define __NR_ia32_inotify_rm_watch	293
 
-#define IA32_NR_syscalls 290	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 294	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
diff -urN linux-2.6.13-rc3/include/asm-x86_64/unistd.h linux/include/asm-x86_64/unistd.h
--- linux-2.6.13-rc3/include/asm-x86_64/unistd.h	2005-07-13 10:51:14.000000000 -0400
+++ linux/include/asm-x86_64/unistd.h	2005-07-15 15:49:37.000000000 -0400
@@ -565,8 +565,14 @@
 __SYSCALL(__NR_ioprio_set, sys_ioprio_set)
 #define __NR_ioprio_get		252
 __SYSCALL(__NR_ioprio_get, sys_ioprio_get)
+#define __NR_inotify_init	253
+__SYSCALL(__NR_inotify_init, sys_inotify_init)
+#define __NR_inotify_add_watch	254
+__SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
+#define __NR_inotify_rm_watch	255
+__SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
 
-#define __NR_syscall_max __NR_ioprio_get
+#define __NR_syscall_max __NR_inotify_rm_watch
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */


