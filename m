Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269474AbUJLGP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269474AbUJLGP0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269477AbUJLGP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:15:26 -0400
Received: from mail.renesas.com ([202.234.163.13]:55193 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S269474AbUJLGPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:15:13 -0400
Date: Tue, 12 Oct 2004 15:14:58 +0900 (JST)
Message-Id: <20041012.151458.964926692.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc4] [m32r] Fix syscall table
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the system call table for m32r.

The latest kernel cannot be linked for m32r, because the following 
experimental syscalls doesn't exist in the prepatch kernel of bk-tree.

Please apply to the bk-tree, not -mm tree.

	* include/asm-m32r/unistd.h:
	- Remove syscalls from #285(perfctr_info) to #293(keyctl).

	* arch/m32r/kernel/entry.S: ditto.

Regards,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/entry.S  |    9 ---------
 include/asm-m32r/unistd.h |   15 +++------------
 2 files changed, 3 insertions(+), 21 deletions(-)


diff -ruNp a/arch/m32r/kernel/entry.S b/arch/m32r/kernel/entry.S
--- a/arch/m32r/kernel/entry.S	2004-10-12 09:34:39.000000000 +0900
+++ b/arch/m32r/kernel/entry.S	2004-10-12 10:24:07.000000000 +0900
@@ -993,15 +993,6 @@ ENTRY(sys_call_table)
         .long sys_mq_getsetattr
         .long sys_ni_syscall            /* reserved for kexec */
 	.long sys_waitid
-	.long sys_perfctr_info
-	.long sys_vperfctr_open
-	.long sys_vperfctr_control
-	.long sys_vperfctr_unlink
-	.long sys_vperfctr_iresume
-	.long sys_vperfctr_read		/* 290 */
-	.long sys_add_key
-	.long sys_request_key
-	.long sys_keyctl
 
 syscall_table_size=(.-sys_call_table)
 
diff -ruNp a/include/asm-m32r/unistd.h b/include/asm-m32r/unistd.h
--- a/include/asm-m32r/unistd.h	2004-10-12 09:35:17.000000000 +0900
+++ b/include/asm-m32r/unistd.h	2004-10-12 10:37:24.000000000 +0900
@@ -294,25 +294,16 @@
 #define __NR_mq_getsetattr      (__NR_mq_open+5)
 #define __NR_sys_kexec_load    283
 #define __NR_waitid            284
-#define __NR_perfctr_info      285
-#define __NR_vperfctr_open     (__NR_perfctr_info+1)
-#define __NR_vperfctr_control  (__NR_perfctr_info+2)
-#define __NR_vperfctr_unlink   (__NR_perfctr_info+3)
-#define __NR_vperfctr_iresume  (__NR_perfctr_info+4)
-#define __NR_vperfctr_read     (__NR_perfctr_info+5)
-#define __NR_add_key           291
-#define __NR_request_key       292
-#define __NR_keyctl            293
 
-#define NR_syscalls 294
+#define NR_syscalls 285
 
-/* user-visible error numbers are in the range -1 - -128: see
+/* user-visible error numbers are in the range -1 - -124: see
  * <asm-m32r/errno.h>
  */
 
 #define __syscall_return(type, res) \
 do { \
-	if ((unsigned long)(res) >= (unsigned long)(-(128 + 1))) { \
+	if ((unsigned long)(res) >= (unsigned long)(-(124 + 1))) { \
 	/* Avoid using "res" which is declared to be in register r0; \
 	   errno might expand to a function call and clobber it.  */ \
 		int __err = -(res); \
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

