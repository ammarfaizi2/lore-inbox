Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTBONqG>; Sat, 15 Feb 2003 08:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTBONqG>; Sat, 15 Feb 2003 08:46:06 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:12266 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262492AbTBONqC>;
	Sat, 15 Feb 2003 08:46:02 -0500
Date: Sun, 16 Feb 2003 00:55:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Mosberger <davidm@hpl.hp.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_futex 2/3 ia64
Message-Id: <20030216005544.19dd157b.sfr@canb.auug.org.au>
In-Reply-To: <20030216005159.16557e36.sfr@canb.auug.org.au>
References: <20030212154716.7c101942.sfr@canb.auug.org.au>
	<20030216005159.16557e36.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

ia 64 part of the patch.  This gives you a 32 bit version of sys_futex
(hopefully).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.61-32bit.1/arch/ia64/ia32/ia32_entry.S 2.5.61-32bit.2/arch/ia64/ia32/ia32_entry.S
--- 2.5.61-32bit.1/arch/ia64/ia32/ia32_entry.S	2003-02-11 09:39:10.000000000 +1100
+++ 2.5.61-32bit.2/arch/ia64/ia32/ia32_entry.S	2003-02-15 23:39:48.000000000 +1100
@@ -428,6 +428,26 @@
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
+	data8 sys_ni_syscall	/* 230 */
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall	/* 235 */
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 compat_sys_futex	/* 240 */
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall	/* 245 */
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
 	/*
 	 *  CAUTION: If any system calls are added beyond this point
 	 *	then the check in `arch/ia64/kernel/ivt.S' will have
diff -ruN 2.5.61-32bit.1/arch/ia64/kernel/ivt.S 2.5.61-32bit.2/arch/ia64/kernel/ivt.S
--- 2.5.61-32bit.1/arch/ia64/kernel/ivt.S	2003-02-11 09:39:11.000000000 +1100
+++ 2.5.61-32bit.2/arch/ia64/kernel/ivt.S	2003-02-15 23:39:48.000000000 +1100
@@ -848,7 +848,7 @@
 	alloc r15=ar.pfs,0,0,6,0	// must first in an insn group
 	;;
 	ld4 r8=[r14],8		// r8 == eax (syscall number)
-	mov r15=230		// number of entries in ia32 system call table
+	mov r15=250		// number of entries in ia32 system call table
 	;;
 	cmp.ltu.unc p6,p7=r8,r15
 	ld4 out1=[r14],8	// r9 == ecx
