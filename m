Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWAIDTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWAIDTS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWAIDTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:19:01 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:44997 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751052AbWAIDSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:18:55 -0500
Message-Id: <200601090411.k094B90A001202@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/6] UML - Fix debug output on x86_64
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Jan 2006 23:11:09 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The debug-stub patch was broken on x86_64 because it thinks the
frame size there is 168 words.  In reality, it is 168 bytes, and
using HOST_FRAME_SIZE, which is expressed in consistent units across
architectures, fixes this.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/process.c	2006-01-05 16:19:59.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/process.c	2006-01-05 17:44:53.000000000 -0500
@@ -68,7 +68,7 @@ void wait_stub_done(int pid, int sig, ch
 
         if((n < 0) || !WIFSTOPPED(status) ||
            (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
-		unsigned long regs[FRAME_SIZE];
+		unsigned long regs[HOST_FRAME_SIZE];
 		if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
 			printk("Failed to get registers from stub, "
 			       "errno = %d\n", errno);
@@ -76,7 +76,7 @@ void wait_stub_done(int pid, int sig, ch
 			int i;
 
 			printk("Stub registers -\n");
-			for(i = 0; i < FRAME_SIZE; i++)
+			for(i = 0; i < HOST_FRAME_SIZE; i++)
 				printk("\t%d - %lx\n", i, regs[i]);
 		}
                 panic("%s : failed to wait for SIGUSR1/SIGTRAP, "

