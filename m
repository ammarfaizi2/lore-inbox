Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVHAPa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVHAPa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVHAPa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:30:29 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:58240 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262086AbVHAP3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:29:30 -0400
Date: Mon, 1 Aug 2005 17:29:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] s390: ioprio & inotify system calls.
Message-ID: <20050801152931.GA6025@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add system calls for io priorities and inotify.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/compat_wrapper.S |   26 ++++++++++++++++++++++++++
 arch/s390/kernel/syscalls.S       |    5 +++++
 include/asm-s390/unistd.h         |    7 ++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-patched/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2005-08-01 16:59:04.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_wrapper.S	2005-08-01 16:59:21.000000000 +0200
@@ -1449,3 +1449,29 @@ compat_sys_kexec_load_wrapper:
 	llgtr	%r4,%r4			# struct kexec_segment *
 	llgfr	%r5,%r5			# unsigned long
 	jg	compat_sys_kexec_load
+
+	.globl	sys_ioprio_set_wrapper
+sys_ioprio_set_wrapper:
+	lgfr	%r2,%r2			# int
+	lgfr	%r3,%r3			# int
+	lgfr	%r4,%r4			# int
+	jg	sys_ioprio_set
+
+	.globl	sys_ioprio_get_wrapper
+sys_ioprio_get_wrapper:
+	lgfr	%r2,%r2			# int
+	lgfr	%r3,%r3			# int
+	jg	sys_ioprio_get
+
+	.globl	sys_inotify_add_watch_wrapper
+sys_inotify_add_watch_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	llgfr	%r4,%r4			# u32
+	jg	sys_inotify_add_watch
+
+	.globl	sys_inotify_rm_watch_wrapper
+sys_inotify_rm_watch_wrapper:
+	lgfr	%r2,%r2			# int
+	llgfr	%r3,%r3			# u32
+	jg	sys_inotify_rm_watch
diff -urpN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-patched/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	2005-08-01 16:59:04.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/syscalls.S	2005-08-01 16:59:21.000000000 +0200
@@ -290,3 +290,8 @@ SYSCALL(sys_add_key,sys_add_key,compat_s
 SYSCALL(sys_request_key,sys_request_key,compat_sys_request_key_wrapper)
 SYSCALL(sys_keyctl,sys_keyctl,compat_sys_keyctl)		/* 280 */
 SYSCALL(sys_waitid,sys_waitid,compat_sys_waitid_wrapper)
+SYSCALL(sys_ioprio_set,sys_ioprio_set,sys_ioprio_set_wrapper)
+SYSCALL(sys_ioprio_get,sys_ioprio_get,sys_ioprio_get_wrapper)
+SYSCALL(sys_inotify_init,sys_inotify_init,sys_inotify_init)
+SYSCALL(sys_inotify_add_watch,sys_inotify_add_watch,sys_inotify_add_watch_wrapper)
+SYSCALL(sys_inotify_rm_watch,sys_inotify_rm_watch,sys_inotify_rm_watch_wrapper)
diff -urpN linux-2.6/include/asm-s390/unistd.h linux-2.6-patched/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2005-08-01 16:59:12.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/unistd.h	2005-08-01 16:59:21.000000000 +0200
@@ -274,8 +274,13 @@
 #define __NR_request_key	279
 #define __NR_keyctl		280
 #define __NR_waitid		281
+#define __NR_ioprio_set		282
+#define __NR_ioprio_get		283
+#define __NR_inotify_init	284
+#define __NR_inotify_add_watch	285
+#define __NR_inotify_rm_watch	286
 
-#define NR_syscalls 282
+#define NR_syscalls 287
 
 /* 
  * There are some system calls that are not present on 64 bit, some
