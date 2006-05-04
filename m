Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWEDLS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWEDLS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 07:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWEDLS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 07:18:27 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:32970 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750924AbWEDLS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 07:18:26 -0400
Date: Thu, 4 May 2006 13:18:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [patch] s390: add vmsplice system call.
Message-ID: <20060504111835.GA8168@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch] s390: add vmsplice system call.

Add new vmsplice system call and add missing __NR_xxx defines for
sys_set_robust_list, sys_get_robust_list, sys_splice, sys_sync_file_range
and sys_tee.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/compat_wrapper.S |    8 ++++++++
 arch/s390/kernel/syscalls.S       |    1 +
 include/asm-s390/unistd.h         |    8 +++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-patched/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2006-05-04 13:09:34.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_wrapper.S	2006-05-04 13:09:50.000000000 +0200
@@ -1650,3 +1650,11 @@ sys_tee_wrapper:
 	llgfr	%r4,%r4			# size_t
 	llgfr	%r5,%r5			# unsigned int
 	jg	sys_tee
+
+	.globl compat_sys_vmsplice_wrapper
+compat_sys_vmsplice_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# compat_iovec *
+	llgfr	%r4,%r4			# unsigned int
+	llgfr	%r5,%r5			# unsigned int
+	jg	compat_sys_vmsplice
diff -urpN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-patched/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	2006-05-04 13:09:34.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/syscalls.S	2006-05-04 13:09:50.000000000 +0200
@@ -317,3 +317,4 @@ SYSCALL(sys_get_robust_list,sys_get_robu
 SYSCALL(sys_splice,sys_splice,sys_splice_wrapper)
 SYSCALL(sys_sync_file_range,sys_sync_file_range,sys_sync_file_range_wrapper)
 SYSCALL(sys_tee,sys_tee,sys_tee_wrapper)
+SYSCALL(sys_vmsplice,sys_vmsplice,compat_sys_vmsplice_wrapper)
diff -urpN linux-2.6/include/asm-s390/unistd.h linux-2.6-patched/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/unistd.h	2006-05-04 13:09:50.000000000 +0200
@@ -296,8 +296,14 @@
 #define __NR_pselect6		301
 #define __NR_ppoll		302
 #define __NR_unshare		303
+#define __NR_set_robust_list	304
+#define __NR_get_robust_list	305
+#define __NR_splice		306
+#define __NR_sync_file_range	307
+#define __NR_tee		308
+#define __NR_vmsplice		309
 
-#define NR_syscalls 304
+#define NR_syscalls 310
 
 /* 
  * There are some system calls that are not present on 64 bit, some
