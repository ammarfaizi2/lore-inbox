Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267958AbUIWBS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUIWBS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267940AbUIWBS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:18:56 -0400
Received: from [12.177.129.25] ([12.177.129.25]:2500 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267958AbUIWBSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:18:02 -0400
Message-Id: <200409230223.i8N2NEiF004280@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH] UML - Implement current_text_addr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Sep 2004 22:23:14 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9-rc2-mm1-orig/include/asm-um/processor-generic.h
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/include/asm-um/processor-generic.h	2004-09-22 19:51:02.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/include/asm-um/processor-generic.h	2004-09-22 20:29:01.000000000 -0400
@@ -16,8 +16,6 @@
 
 struct mm_struct;
 
-#define current_text_addr() ((void *) 0)
-
 #define cpu_relax()   barrier()
 
 struct thread_struct {
Index: linux-2.6.9-rc2-mm1-orig/include/asm-um/processor-i386.h
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/include/asm-um/processor-i386.h	2004-09-22 19:51:02.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/include/asm-um/processor-i386.h	2004-09-22 20:29:01.000000000 -0400
@@ -19,6 +19,13 @@
 
 #include "asm/arch/user.h"
 
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter"). Stolen
+ * from asm-i386/processor.h
+ */
+#define current_text_addr() ({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
+
 #include "asm/processor-generic.h"
 
 #endif

