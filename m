Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbTI1Q3J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTI1Q3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:29:09 -0400
Received: from front3.chartermi.net ([24.213.60.109]:25009 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id S262606AbTI1Q3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:29:06 -0400
Message-ID: <3F770C4F.5020407@quark.didntduck.org>
Date: Sun, 28 Sep 2003 12:29:03 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 do_machine_check() is redundant.
Content-Type: multipart/mixed;
 boundary="------------060906000004080904070500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060906000004080904070500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Use machine_check_vector in the entry code instead.

--
				Brian Gerst

--------------060906000004080904070500
Content-Type: text/plain;
 name="mce-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mce-1"

diff -urN linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/mce.c linux/arch/i386/kernel/cpu/mcheck/mce.c
--- linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/mce.c	2003-07-27 13:06:29.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/mce.c	2003-09-28 12:23:16.267949368 -0400
@@ -26,11 +26,6 @@
 /* Call the installed machine check handler for this CPU setup. */
 void (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
 
-asmlinkage void do_machine_check(struct pt_regs * regs, long error_code)
-{
-	machine_check_vector(regs, error_code);
-}
-
 /* This has to be run for each processor */
 void __init mcheck_init(struct cpuinfo_x86 *c)
 {
diff -urN linux-2.6.0-test6/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.6.0-test6/arch/i386/kernel/entry.S	2003-09-28 10:20:13.981227536 -0400
+++ linux/arch/i386/kernel/entry.S	2003-09-28 12:23:16.268949216 -0400
@@ -595,7 +595,7 @@
 #ifdef CONFIG_X86_MCE
 ENTRY(machine_check)
 	pushl $0
-	pushl $do_machine_check
+	pushl machine_check_vector
 	jmp error_code
 #endif
 

--------------060906000004080904070500--

