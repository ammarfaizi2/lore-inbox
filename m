Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWJEVJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWJEVJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWJEVJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:09:28 -0400
Received: from host253-106-dynamic.55-82-r.retail.telecomitalia.it ([82.55.106.253]:12764
	"EHLO memento.home.lan") by vger.kernel.org with ESMTP
	id S932199AbWJEVJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:09:26 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: stable@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: uml: allow using again x86/x86_64 crypto code
Date: Thu,  5 Oct 2006 21:34:28 +0200
Message-Id: <11600768683307-git-send-email-blaisorblade@yahoo.it>
X-Mailer: git-send-email 1.4.2.3.g99b7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Enable compilation of x86_64 crypto code;, and add the needed constant to make
the code compile again (that macro was added to i386 asm-offsets between 2.6.17
and 2.6.18, in 6c2bb98bc33ae33c7a33a133a4cd5a06395fece5).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/um/Makefile-x86_64
===================================================================
--- linux-2.6.git.orig/arch/um/Makefile-x86_64
+++ linux-2.6.git/arch/um/Makefile-x86_64
@@ -1,7 +1,7 @@
 # Copyright 2003 - 2004 Pathscale, Inc
 # Released under the GPL
 
-core-y += arch/um/sys-x86_64/
+core-y += arch/um/sys-x86_64/ arch/x86_64/crypto/
 START := 0x60000000
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
Index: linux-2.6.git/arch/um/include/common-offsets.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/common-offsets.h
+++ linux-2.6.git/arch/um/include/common-offsets.h
@@ -15,3 +15,4 @@ DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
 DEFINE(UM_ELF_CLASS, ELF_CLASS);
 DEFINE(UM_ELFCLASS32, ELFCLASS32);
 DEFINE(UM_ELFCLASS64, ELFCLASS64);
+DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
Index: linux-2.6.git/arch/um/include/sysdep-i386/kernel-offsets.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/sysdep-i386/kernel-offsets.h
+++ linux-2.6.git/arch/um/include/sysdep-i386/kernel-offsets.h
@@ -1,6 +1,7 @@
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/mman.h>
 
 #define DEFINE(sym, val) \
Index: linux-2.6.git/arch/um/include/sysdep-x86_64/kernel-offsets.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/sysdep-x86_64/kernel-offsets.h
+++ linux-2.6.git/arch/um/include/sysdep-x86_64/kernel-offsets.h
@@ -2,6 +2,7 @@
 #include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/page.h>
 #include <asm/mman.h>
 
