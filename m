Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbSLKRuI>; Wed, 11 Dec 2002 12:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbSLKRuI>; Wed, 11 Dec 2002 12:50:08 -0500
Received: from air-2.osdl.org ([65.172.181.6]:7647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267242AbSLKRuD>;
	Wed, 11 Dec 2002 12:50:03 -0500
Subject: [TRIVIAL PATCH] remove warnings/errors from
	arch/i386/kernel/suspend_asm.S
From: Andy Pfiffer <andyp@osdl.org>
To: pavel@ucw.cz
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 11 Dec 2002 09:57:55 -0800
Message-Id: <1039629475.30576.109.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some earlier versions of gas (2.10.91 specifically) will error out on
the "movw %eax,%ds" in arch/i386/kernel/suspend_asm.S.  gas 2.11.92
complains but continues.

Here is a trivial patch that eliminates two warnings.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.865   -> 1.866  
#	arch/i386/kernel/suspend_asm.S	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/11	andyp@joe.pdx.osdl.net	1.866
# Correct syntax to remove assembler warnings and errors.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/suspend_asm.S b/arch/i386/kernel/suspend_asm.S
--- a/arch/i386/kernel/suspend_asm.S	Wed Dec 11 09:51:22 2002
+++ b/arch/i386/kernel/suspend_asm.S	Wed Dec 11 09:51:22 2002
@@ -6,7 +6,7 @@
 #include <asm/segment.h>
 #include <asm/page.h>
 
-ENTRY(do_magic):
+ENTRY(do_magic)
 	pushl %ebx
 	cmpl $0,8(%esp)
 	jne .L1450
@@ -66,7 +66,7 @@
 .L1453:
 	movl $104,%eax
 
-	movw %eax, %ds
+	movw %ax, %ds
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
 	movl saved_context_eax, %eax
@@ -88,4 +88,4 @@
 loop2:
        .quad 0
        .previous
-	
\ No newline at end of file
+



