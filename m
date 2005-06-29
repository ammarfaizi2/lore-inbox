Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVF2UBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVF2UBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVF2UBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:01:51 -0400
Received: from mail.dif.dk ([193.138.115.101]:50863 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262536AbVF2UBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:01:48 -0400
Date: Wed, 29 Jun 2005 22:07:49 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Chris Zankel <chris@zankel.net>, Scott Foehner <sfoehner@yahoo.com>,
       Marc Gauthier <marc@tensilica.com>, Joe Taylor <joe@tensilica.com>,
       Marc Gauthier <marc@alumni.uwaterloo.ca>,
       Joe Taylor <joetylr@yahoo.com>
Subject: [PATCH] make xtensa use valid_signal()
Message-ID: <Pine.LNX.4.62.0506292202340.2998@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xtensa should use valid_signal() instead of testing _NSIG directly like 
everyone else.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 arch/xtensa/kernel/ptrace.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.13-rc1-orig/arch/xtensa/kernel/ptrace.c	2005-06-29 21:44:49.000000000 +0200
+++ linux-2.6.13-rc1/arch/xtensa/kernel/ptrace.c	2005-06-29 22:00:34.000000000 +0200
@@ -22,6 +22,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -239,7 +240,7 @@ int sys_ptrace(long request, long pid, l
 	case PTRACE_CONT: /* restart after signal. */
 	{
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -269,7 +270,7 @@ int sys_ptrace(long request, long pid, l
 
 	case PTRACE_SINGLESTEP:
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->ptrace |= PT_SINGLESTEP;


