Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVCBQsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVCBQsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVCBQpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:45:51 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:61148 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262353AbVCBQpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:45:05 -0500
Date: Wed, 2 Mar 2005 17:45:04 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/9] s390: key management.
Message-ID: <20050302164504.GC27829@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/9] s390: key management.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add key management system calls.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/compat_wrapper.S |   17 +++++++++++++++++
 arch/s390/kernel/syscalls.S       |    3 +++
 include/asm-s390/unistd.h         |    5 ++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff -urN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-patched/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/compat_wrapper.S	2005-03-02 17:00:08.000000000 +0100
@@ -1406,3 +1406,20 @@
 	llgtr	%r3,%r3			# struct compat_mq_attr *
 	llgtr	%r4,%r4			# struct compat_mq_attr *
 	jg	compat_sys_mq_getsetattr
+
+	.globl	compat_sys_add_key
+compat_sys_add_key:
+	llgtr	%r2,%r2			# const char *
+	llgtr	%r3,%r3			# const char *
+	llgtr	%r4,%r4			# const void *
+	llgfr	%r5,%r5			# size_t
+	llgfr	%r6,%r6			# (key_serial_t) u32
+	jg	sys_add_key
+
+	.globl	compat_sys_request_key
+compat_sys_request_key:
+	llgtr	%r2,%r2			# const char *
+	llgtr	%r3,%r3			# const char *
+	llgtr	%r4,%r4			# const void *
+	llgfr	%r5,%r5			# (key_serial_t) u32
+	jg	sys_request_key
diff -urN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-patched/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/syscalls.S	2005-03-02 17:00:10.000000000 +0100
@@ -286,3 +286,6 @@
 SYSCALL(sys_mq_notify,sys_mq_notify,compat_sys_mq_notify_wrapper) /* 275 */
 SYSCALL(sys_mq_getsetattr,sys_mq_getsetattr,compat_sys_mq_getsetattr_wrapper)
 NI_SYSCALL							/* reserved for kexec */
+SYSCALL(sys_add_key,sys_add_key,compat_sys_add_key)
+SYSCALL(sys_request_key,sys_request_key,compat_sys_request_key)
+SYSCALL(sys_keyctl,sys_keyctl,compat_sys_keyctl)		/* 280 */
diff -urN linux-2.6/include/asm-s390/unistd.h linux-2.6-patched/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/unistd.h	2005-03-02 17:00:10.000000000 +0100
@@ -270,8 +270,11 @@
 #define __NR_mq_notify		275
 #define __NR_mq_getsetattr	276
 /* Number 277 is reserved for new sys_kexec_load */
+#define __NR_add_key		278
+#define __NR_request_key	279
+#define __NR_keyctl		280
 
-#define NR_syscalls 278
+#define NR_syscalls 281
 
 /* 
  * There are some system calls that are not present on 64 bit, some
