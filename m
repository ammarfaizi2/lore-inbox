Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313737AbSDJUkh>; Wed, 10 Apr 2002 16:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313805AbSDJUkg>; Wed, 10 Apr 2002 16:40:36 -0400
Received: from zero.tech9.net ([209.61.188.187]:30482 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313737AbSDJUkg>;
	Wed, 10 Apr 2002 16:40:36 -0400
Subject: [PATCH] 2.4: reserve syscalls from 2.5
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Apr 2002 16:40:22 -0400
Message-Id: <1018471223.6524.83.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

The following patch reserves syscall numbers 239 through 242 which are
the calls to date added to 2.5.  I just set them to sys_ni_syscall and
note which 2.5 function they correspond to.

Patch is against 2.5.19-pre6, please apply.

	Robert Love

diff -urN linux-2.4.19-pre6/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.4.19-pre6/arch/i386/kernel/entry.S	Fri Apr  5 14:53:39 2002
+++ linux/arch/i386/kernel/entry.S	Wed Apr 10 16:28:17 2002
@@ -635,6 +635,10 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for lremovexattr */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fremovexattr */
  	.long SYMBOL_NAME(sys_tkill)
+	.long SYMBOL_NAME(sys_ni_syscalls)	/* reserved for sendfile64 */
+	.long SYMBOL_NAME(sys_ni_syscalls)	/* 240 reserved for futex */
+	.long SYMBOL_NAME(sys_ni_syscalls)	/* reserved for sched_setaffinity */
+	.long SYMBOL_NAME(sys_ni_syscalls)	/* reserved for sched_getaffinity */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN linux-2.4.19-pre6/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.4.19-pre6/include/asm-i386/unistd.h	Fri Apr  5 14:53:56 2002
+++ linux/include/asm-i386/unistd.h	Wed Apr 10 16:21:00 2002
@@ -242,8 +242,11 @@
 #define __NR_removexattr	235
 #define __NR_lremovexattr	236
 #define __NR_fremovexattr	237
-
 #define __NR_tkill		238
+#define __NR_sendfile64		239
+#define __NR_futex		240
+#define __NR_sched_setaffinity	241
+#define __NR_sched_getaffinity	242
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 





