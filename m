Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbUKXAJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbUKXAJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUKXAIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 19:08:11 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:51978 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261369AbUKXAE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 19:04:56 -0500
Subject: [patch 1/1] uml: fix some ptrace functions returns values
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade_spam@yahoo.it, jdike@addtoit.com
From: blaisorblade_spam@yahoo.it
Date: Wed, 24 Nov 2004 01:07:13 +0100
Message-Id: <20041124000715.E3A2FAB24@zion.localdomain>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.18; VDF: 6.28.0.88; host: ssc.unict.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Dike <jdike@addtoit.com>

This patch adds ptrace_setfpregs and makes these functions return -errno on
failure.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/sys-i386/ptrace_user.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff -puN arch/um/sys-i386/ptrace_user.c~uml-fix-ptrace-interfaces arch/um/sys-i386/ptrace_user.c
--- linux-2.6.10-rc/arch/um/sys-i386/ptrace_user.c~uml-fix-ptrace-interfaces	2004-11-24 01:06:35.525806848 +0100
+++ linux-2.6.10-rc-paolo/arch/um/sys-i386/ptrace_user.c	2004-11-24 01:06:35.528806392 +0100
@@ -17,17 +17,30 @@
 
 int ptrace_getregs(long pid, unsigned long *regs_out)
 {
-	return(ptrace(PTRACE_GETREGS, pid, 0, regs_out));
+	if(ptrace(PTRACE_GETREGS, pid, 0, regs_out) < 0)
+		return(-errno);
+	return(0);
 }
 
 int ptrace_setregs(long pid, unsigned long *regs)
 {
-	return(ptrace(PTRACE_SETREGS, pid, 0, regs));
+	if(ptrace(PTRACE_SETREGS, pid, 0, regs) < 0)
+		return(-errno);
+	return(0);
 }
 
 int ptrace_getfpregs(long pid, unsigned long *regs)
 {
-	return(ptrace(PTRACE_GETFPREGS, pid, 0, regs));
+	if(ptrace(PTRACE_GETFPREGS, pid, 0, regs) < 0)
+		return(-errno);
+	return(0);
+}
+
+int ptrace_setfpregs(long pid, unsigned long *regs)
+{
+	if(ptrace(PTRACE_SETFPREGS, pid, 0, regs) < 0)
+		return(-errno);
+	return(0);
 }
 
 static void write_debugregs(int pid, unsigned long *regs)
_
