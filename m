Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVDBI2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVDBI2b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 03:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVDBI2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 03:28:31 -0500
Received: from ozlabs.org ([203.10.76.45]:2456 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261214AbVDBI2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 03:28:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16974.20858.121298.165539@cargo.ozlabs.ibm.com>
Date: Sat, 2 Apr 2005 18:02:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc: add syscall6 definition
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have some syscalls with 6 arguments, it's useful to have a
definition of _syscall6 in asm-ppc/unistd.h.  This patch adds a
suitable definition.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/include/asm-ppc/unistd.h pmac-2.5/include/asm-ppc/unistd.h
--- linux-2.5/include/asm-ppc/unistd.h	2005-03-11 08:36:23.000000000 +1100
+++ pmac-2.5/include/asm-ppc/unistd.h	2005-03-14 14:14:08.000000000 +1100
@@ -297,6 +297,7 @@
 		register unsigned long __sc_5  __asm__ ("r5");		\
 		register unsigned long __sc_6  __asm__ ("r6");		\
 		register unsigned long __sc_7  __asm__ ("r7");		\
+		register unsigned long __sc_8  __asm__ ("r8");		\
 									\
 		__sc_loadargs_##nr(name, args);				\
 		__asm__ __volatile__					\
@@ -305,10 +306,10 @@
 			: "=&r" (__sc_0),				\
 			  "=&r" (__sc_3),  "=&r" (__sc_4),		\
 			  "=&r" (__sc_5),  "=&r" (__sc_6),		\
-			  "=&r" (__sc_7)				\
+			  "=&r" (__sc_7),  "=&r" (__sc_8)		\
 			: __sc_asm_input_##nr				\
 			: "cr0", "ctr", "memory",			\
-			  "r8", "r9", "r10","r11", "r12");		\
+			  "r9", "r10","r11", "r12");			\
 		__sc_ret = __sc_3;					\
 		__sc_err = __sc_0;					\
 	}								\
@@ -336,6 +337,9 @@
 #define __sc_loadargs_5(name, arg1, arg2, arg3, arg4, arg5)		\
 	__sc_loadargs_4(name, arg1, arg2, arg3, arg4);			\
 	__sc_7 = (unsigned long) (arg5)
+#define __sc_loadargs_6(name, arg1, arg2, arg3, arg4, arg5, arg6)	\
+	__sc_loadargs_5(name, arg1, arg2, arg3, arg4, arg5);		\
+	__sc_8 = (unsigned long) (arg6)
 
 #define __sc_asm_input_0 "0" (__sc_0)
 #define __sc_asm_input_1 __sc_asm_input_0, "1" (__sc_3)
@@ -343,6 +347,7 @@
 #define __sc_asm_input_3 __sc_asm_input_2, "3" (__sc_5)
 #define __sc_asm_input_4 __sc_asm_input_3, "4" (__sc_6)
 #define __sc_asm_input_5 __sc_asm_input_4, "5" (__sc_7)
+#define __sc_asm_input_6 __sc_asm_input_5, "6" (__sc_8)
 
 #define _syscall0(type,name)						\
 type name(void)								\
@@ -380,6 +385,12 @@
 	__syscall_nr(5, type, name, arg1, arg2, arg3, arg4, arg5);	\
 }
 
+#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5,type6,arg6) \
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5, type6 arg6) \
+{									\
+	__syscall_nr(6, type, name, arg1, arg2, arg3, arg4, arg5, arg6); \
+}
+
 #ifdef __KERNEL__
 
 #define __NR__exit __NR_exit
