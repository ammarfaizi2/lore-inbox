Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbTCYCrR>; Mon, 24 Mar 2003 21:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbTCYCrQ>; Mon, 24 Mar 2003 21:47:16 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:58565 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261372AbTCYCqJ>; Mon, 24 Mar 2003 21:46:09 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Rename the (v850-specific) macro PT_SYSCALL to PT_CUR_SYSCALL
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030325025657.1B1443700@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 25 Mar 2003 11:56:57 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids a conflict with the more generic definition of PT_SYSCALL.

diff -ruN -X../cludes linux-2.5.66-moo.orig/arch/v850/kernel/entry.S linux-2.5.66-moo/arch/v850/kernel/entry.S
--- linux-2.5.66-moo.orig/arch/v850/kernel/entry.S	2003-02-25 10:44:59.000000000 +0900
+++ linux-2.5.66-moo/arch/v850/kernel/entry.S	2003-03-25 10:37:52.000000000 +0900
@@ -231,7 +231,7 @@
 	st.b	r19, KM;						      \
 	GET_CURRENT_TASK(CURRENT_TASK);	/* Fetch the current task pointer. */ \
 	/* Save away the syscall number.  */				      \
-	sst.w	syscall_num, PTO+PT_SYSCALL[ep]
+	sst.w	syscall_num, PTO+PT_CUR_SYSCALL[ep]
 
 
 /* Save register state not normally saved by PUSH_STATE for TYPE.  */
diff -ruN -X../cludes linux-2.5.66-moo.orig/include/asm-v850/ptrace.h linux-2.5.66-moo/include/asm-v850/ptrace.h
--- linux-2.5.66-moo.orig/include/asm-v850/ptrace.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.66-moo/include/asm-v850/ptrace.h	2003-03-25 10:37:52.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/ptrace.h -- Access to CPU registers
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -102,7 +102,9 @@
 #define PT_CTBP		((NUM_GPRS + 4) * _PT_REG_SIZE)
 #define PT_KERNEL_MODE	((NUM_GPRS + 5) * _PT_REG_SIZE)
 
-#define PT_SYSCALL	PT_GPR(0)
+/* Where the current syscall number is stashed; obviously only valid in
+   the kernel!  */
+#define PT_CUR_SYSCALL	PT_GPR(0)
 
 /* Size of struct pt_regs, including alignment.  */
 #define PT_SIZE		((NUM_GPRS + 6) * _PT_REG_SIZE)
