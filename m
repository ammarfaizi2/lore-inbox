Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbTBVCVc>; Fri, 21 Feb 2003 21:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbTBVCVc>; Fri, 21 Feb 2003 21:21:32 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:49034 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267771AbTBVCVb>; Fri, 21 Feb 2003 21:21:31 -0500
Message-ID: <3E56E0F5.6080304@quark.didntduck.org>
Date: Fri, 21 Feb 2003 21:31:17 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove old double fault handler
Content-Type: multipart/mixed;
 boundary="------------070401060608060008010202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070401060608060008010202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Removes the now unused trap handler for double faults.  Also removes the 
never used handler for fpu not available.

--
				Brian Gerst

--------------070401060608060008010202
Content-Type: text/plain;
 name="doublefault-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="doublefault-1"

diff -urN linux-2.5.62-bk7/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.62-bk7/arch/i386/kernel/entry.S	2003-02-21 14:48:27.000000000 -0500
+++ linux/arch/i386/kernel/entry.S	2003-02-21 20:43:13.000000000 -0500
@@ -500,10 +500,6 @@
 	pushl $do_coprocessor_segment_overrun
 	jmp error_code
 
-ENTRY(double_fault)
-	pushl $do_double_fault
-	jmp error_code
-
 ENTRY(invalid_TSS)
 	pushl $do_invalid_TSS
 	jmp error_code
diff -urN linux-2.5.62-bk7/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux-2.5.62-bk7/arch/i386/kernel/traps.c	2003-02-21 14:48:27.000000000 -0500
+++ linux/arch/i386/kernel/traps.c	2003-02-21 20:44:10.000000000 -0500
@@ -73,7 +73,6 @@
 asmlinkage void bounds(void);
 asmlinkage void invalid_op(void);
 asmlinkage void device_not_available(void);
-asmlinkage void double_fault(void);
 asmlinkage void coprocessor_segment_overrun(void);
 asmlinkage void invalid_TSS(void);
 asmlinkage void segment_not_present(void);
@@ -349,8 +348,6 @@
 DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
 DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
 DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->eip)
-DO_VM86_ERROR( 7, SIGSEGV, "device not available", device_not_available)
-DO_ERROR( 8, SIGSEGV, "double fault", double_fault)
 DO_ERROR( 9, SIGFPE,  "coprocessor segment overrun", coprocessor_segment_overrun)
 DO_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
 DO_ERROR(11, SIGBUS,  "segment not present", segment_not_present)

--------------070401060608060008010202--

