Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVFUBqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVFUBqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVFUBoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 21:44:08 -0400
Received: from [151.97.230.9] ([151.97.230.9]:16838 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261782AbVFUBlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 21:41:40 -0400
Subject: [patch 1/1] uml: add profile_pc for i386
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 21 Jun 2005 03:35:21 +0200
Message-Id: <20050621013522.678D355FCD@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cope with a conditional i386 definition, which is wrong for UML. Before we
just used that one, but it wasn't defined for CONFIG_SMP, so in that case we
got link errors.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-um/ptrace-i386.h |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN include/asm-um/ptrace-i386.h~uml-add-profile-pc-i386 include/asm-um/ptrace-i386.h
--- linux-2.6.git/include/asm-um/ptrace-i386.h~uml-add-profile-pc-i386	2005-06-07 18:57:00.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/ptrace-i386.h	2005-06-07 18:59:26.000000000 +0200
@@ -32,6 +32,10 @@
 #define PT_REGS_SYSCALL_RET(r) PT_REGS_EAX(r)
 #define PT_FIX_EXEC_STACK(sp) do ; while(0)
 
+/* Cope with a conditional i386 definition. */
+#undef profile_pc
+#define profile_pc(regs) PT_REGS_IP(regs)
+
 #define user_mode(r) UPT_IS_USER(&(r)->regs)
 
 #endif
_
