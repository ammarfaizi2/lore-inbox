Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbUKDCG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbUKDCG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbUKDCGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:06:08 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:7572
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262060AbUKDB4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:56:09 -0500
Subject: [patch 13/20] Uml: revert compile-only changes for other ones
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:44 +0100
Message-Id: <20041103231744.CFFC355C81@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm reverting the compile-time fixes to replace them with a bigger change,
which also happens to fix the compilation problem. The change is in next
patches.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c |   13 -------------
 1 files changed, 13 deletions(-)

diff -puN arch/um/kernel/process.c~uml-revert-wrong-build-fix arch/um/kernel/process.c
--- vanilla-linux-2.6.9/arch/um/kernel/process.c~uml-revert-wrong-build-fix	2004-11-03 23:45:15.493083424 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c	2004-11-03 23:45:15.496082968 +0100
@@ -202,11 +202,6 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 		"    To make it working, you need a kernel patch for your host, too.\n"
 		"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further information.\n");
 
-/* Ugly hack for now... --cw */
-#ifndef PTRACE_SYSEMU
-#define PTRACE_SYSEMU 31
-#endif
-
 static void __init check_sysemu(void)
 {
 	void *stack;
@@ -216,9 +211,7 @@ static void __init check_sysemu(void)
 		return;
 
 	printk("Checking syscall emulation patch for ptrace...");
-#ifdef CONFIG_MODE_SKAS
 	sysemu_supported = 0;
-#endif /* CONFIG_MODE_SKAS */
 	pid = start_ptraced_child(&stack);
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
 		struct user_regs_struct regs;
@@ -240,23 +233,17 @@ static void __init check_sysemu(void)
 
 		stop_ptraced_child(pid, stack, 0);
 
-#ifdef CONFIG_MODE_SKAS
 		sysemu_supported = 1;
-#endif /* CONFIG_MODE_SKAS */
 		printk("found\n");
 	}
 	else
 	{
 		stop_ptraced_child(pid, stack, 1);
-#ifdef CONFIG_MODE_SKAS
 		sysemu_supported = 0;
-#endif /* CONFIG_MODE_SKAS */
 		printk("missing\n");
 	}
 
-#ifdef CONFIG_MODE_SKAS
 	set_using_sysemu(!force_sysemu_disabled);
-#endif
 }
 
 void __init check_ptrace(void)
_
