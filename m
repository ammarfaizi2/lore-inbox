Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbULTAs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbULTAs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 19:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbULTAs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 19:48:58 -0500
Received: from fsmlabs.com ([168.103.115.128]:36267 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261369AbULTAst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 19:48:49 -0500
Date: Sun, 19 Dec 2004 17:48:51 -0700 (MST)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Boottime allocated GDTs and doublefault handler
Message-ID: <Pine.LNX.4.61.0412191730330.18272@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GDTs on SMP tend to be above the current ptr_ok limits since they are 
boottime allocated. How does the following new arbitrary limit look?

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.10-rc3-mm1/arch/i386/kernel/doublefault.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc3-mm1/arch/i386/kernel/doublefault.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 doublefault.c
--- linux-2.6.10-rc3-mm1/arch/i386/kernel/doublefault.c	13 Dec 2004 14:26:45 -0000	1.1.1.1
+++ linux-2.6.10-rc3-mm1/arch/i386/kernel/doublefault.c	20 Dec 2004 00:21:31 -0000
@@ -13,7 +13,7 @@
 static unsigned long doublefault_stack[DOUBLEFAULT_STACKSIZE];
 #define STACK_START (unsigned long)(doublefault_stack+DOUBLEFAULT_STACKSIZE)
 
-#define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + 0x1000000)
+#define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + 0x2000000)
 
 static void doublefault_fn(void)
 {
