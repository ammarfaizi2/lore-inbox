Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWGLQlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWGLQlG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWGLQk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:40:28 -0400
Received: from [198.99.130.12] ([198.99.130.12]:7063 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751353AbWGLQj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:39:58 -0400
Message-Id: <200607121640.k6CGe1Nf021231@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 3/5] UML - Tidy biarch gcc support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jul 2006 12:40:01 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of the previous biarch changes for UML, this makes the
preprocessor changes a bit cleaner. Specify the 64-bit build in CPPFLAGS
on the x86_64 SUBARCH, rather than #undef'ing i386. Compile-tested with
i386 and x86_64 SUBARCHs.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/Makefile-x86_64
===================================================================
--- linux-2.6.17.orig/arch/um/Makefile-x86_64	2006-07-12 11:26:41.000000000 -0400
+++ linux-2.6.17/arch/um/Makefile-x86_64	2006-07-12 11:32:52.000000000 -0400
@@ -11,6 +11,7 @@ USER_CFLAGS += -fno-builtin -m64
 CHECKFLAGS  += -m64
 AFLAGS += -m64
 LDFLAGS += -m elf_x86_64
+CPPFLAGS += -m64
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
Index: linux-2.6.17/arch/um/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/vmlinux.lds.S	2006-07-12 11:26:41.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/vmlinux.lds.S	2006-07-12 11:32:52.000000000 -0400
@@ -1,5 +1,3 @@
-/* in case the preprocessor is a 32bit one */
-#undef i386
 #ifdef CONFIG_LD_SCRIPT_STATIC
 #include "uml.lds.S"
 #else

