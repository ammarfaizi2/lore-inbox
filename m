Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbULHRx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbULHRx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULHRxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:53:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52943 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261279AbULHRvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:51:39 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make more syscalls available for the FR-V arch
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.2
Date: Wed, 08 Dec 2004 17:51:33 +0000
Message-ID: <7717.1102528293@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes more syscalls available for the FR-V arch.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-syscalls-2610rc2mm3-3.diff 
 arch/frv/kernel/entry.S  |   13 ++++++++++++-
 include/asm-frv/unistd.h |   13 ++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/arch/frv/kernel/entry.S linux-2.6.10-rc2-mm3-shmem/arch/frv/kernel/entry.S
--- linux-2.6.10-rc2-mm3-mmcleanup/arch/frv/kernel/entry.S	2004-11-22 10:53:41.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/arch/frv/kernel/entry.S	2004-12-07 15:31:52.000000000 +0000
@@ -1389,7 +1389,7 @@ sys_call_table:
 	.long sys_epoll_ctl	/* 255 */
 	.long sys_epoll_wait
  	.long __MMU(sys_remap_file_pages)
- 	.long sys_ni_syscall	//sys_set_tid_address
+ 	.long sys_set_tid_address
  	.long sys_timer_create
  	.long sys_timer_settime		/* 260 */
  	.long sys_timer_gettime
@@ -1415,6 +1415,17 @@ sys_call_table:
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* reserved for kexec */
+	.long sys_waitid
+	.long sys_ni_syscall		/* 285 */ /* available */
+	.long sys_add_key
+	.long sys_request_key
+	.long sys_keyctl
+	.long sys_perfctr_info
+	.long sys_vperfctr_open		/* 290 */
+	.long sys_vperfctr_control
+	.long sys_vperfctr_unlink
+	.long sys_vperfctr_iresume
+	.long sys_vperfctr_read
 
 
 syscall_table_size = (. - sys_call_table)
diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/include/asm-frv/unistd.h linux-2.6.10-rc2-mm3-shmem/include/asm-frv/unistd.h
--- linux-2.6.10-rc2-mm3-mmcleanup/include/asm-frv/unistd.h	2004-11-22 10:54:12.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/include/asm-frv/unistd.h	2004-11-24 14:17:06.000000000 +0000
@@ -290,8 +290,19 @@
 #define __NR_mq_notify		(__NR_mq_open+4)
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
 #define __NR_sys_kexec_load	283
+#define __NR_waitid		284
+/* #define __NR_sys_setaltroot	285 */
+#define __NR_add_key		286
+#define __NR_request_key	287
+#define __NR_keyctl		288
+#define __NR_perfctr_info	289
+#define __NR_vperfctr_open	(__NR_perfctr_info+1)
+#define __NR_vperfctr_control	(__NR_perfctr_info+2)
+#define __NR_vperfctr_unlink	(__NR_perfctr_info+3)
+#define __NR_vperfctr_iresume	(__NR_perfctr_info+4)
+#define __NR_vperfctr_read	(__NR_perfctr_info+5)
 
-#define NR_syscalls 284
+#define NR_syscalls 295
 
 /*
  * process the return value of a syscall, consigning it to one of two possible fates
