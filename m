Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbULNQTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbULNQTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULNQTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:19:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42183 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261544AbULNQRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:17:52 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV perfctr_info syscall
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Tue, 14 Dec 2004 16:17:47 +0000
Message-ID: <9457.1103041067@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch gets rid of the perfctr_info syscall from the FRV arch now
that its implementation has gone and it has been removed from the i386 arch
and the i386 syscalls have been renumbered.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-perf-syscall-2610rc3.diff 
 arch/frv/kernel/entry.S  |    6 +++---
 include/asm-frv/unistd.h |   13 ++++++-------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff -uNr linux-2.6.10-rc3-mm1-mmcleanup/arch/frv/kernel/entry.S linux-2.6.10-rc3-mm1-misc/arch/frv/kernel/entry.S
--- linux-2.6.10-rc3-mm1-mmcleanup/arch/frv/kernel/entry.S	2004-12-13 17:33:50.000000000 +0000
+++ linux-2.6.10-rc3-mm1-misc/arch/frv/kernel/entry.S	2004-12-14 14:31:51.000000000 +0000
@@ -1031,6 +1031,7 @@
 # perform work that needs to be done immediately before resumption
 #
 ###############################################################################
+	.globl		__entry_return_from_user_exception
 	.balign		L1_CACHE_BYTES
 __entry_return_from_user_exception:
 	LEDS		0x6501
@@ -1420,9 +1421,8 @@
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
-	.long sys_perfctr_info
-	.long sys_vperfctr_open		/* 290 */
-	.long sys_vperfctr_control
+	.long sys_vperfctr_open
+	.long sys_vperfctr_control	/* 290 */
 	.long sys_vperfctr_unlink
 	.long sys_vperfctr_iresume
 	.long sys_vperfctr_read
diff -uNr linux-2.6.10-rc3-mm1-mmcleanup/include/asm-frv/unistd.h linux-2.6.10-rc3-mm1-misc/include/asm-frv/unistd.h
--- linux-2.6.10-rc3-mm1-mmcleanup/include/asm-frv/unistd.h	2004-12-13 17:34:21.000000000 +0000
+++ linux-2.6.10-rc3-mm1-misc/include/asm-frv/unistd.h	2004-12-14 16:16:26.762754662 +0000
@@ -295,14 +295,13 @@
 #define __NR_add_key		286
 #define __NR_request_key	287
 #define __NR_keyctl		288
-#define __NR_perfctr_info	289
-#define __NR_vperfctr_open	(__NR_perfctr_info+1)
-#define __NR_vperfctr_control	(__NR_perfctr_info+2)
-#define __NR_vperfctr_unlink	(__NR_perfctr_info+3)
-#define __NR_vperfctr_iresume	(__NR_perfctr_info+4)
-#define __NR_vperfctr_read	(__NR_perfctr_info+5)
+#define __NR_vperfctr_open	289
+#define __NR_vperfctr_control	(__NR_perfctr_info+1)
+#define __NR_vperfctr_unlink	(__NR_perfctr_info+2)
+#define __NR_vperfctr_iresume	(__NR_perfctr_info+3)
+#define __NR_vperfctr_read	(__NR_perfctr_info+4)
 
-#define NR_syscalls 295
+#define NR_syscalls 294
 
 /*
  * process the return value of a syscall, consigning it to one of two possible fates
