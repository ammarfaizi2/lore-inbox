Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbUKDCCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUKDCCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUKDCAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:00:00 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:60307
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262045AbUKDBzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:18 -0500
Subject: [patch 03/20] uml: fix syscall auditing
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:21 +0100
Message-Id: <20041103231721.59164363A6@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct the entry_exit parameter for syscall_trace when tracing syscalls. It
was the reverse of the needed value. (i.e.  it was 1 on entry and 0 on exit).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/syscall_user.c |    4 ++--
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/syscall_user.c   |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/um/kernel/skas/syscall_user.c~uml-fix-syscall-auditing arch/um/kernel/skas/syscall_user.c
--- vanilla-linux-2.6.9/arch/um/kernel/skas/syscall_user.c~uml-fix-syscall-auditing	2004-11-03 23:44:57.311847392 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/syscall_user.c	2004-11-03 23:44:57.315846784 +0100
@@ -22,7 +22,7 @@ void handle_syscall(union uml_pt_regs *r
 
 	index = record_syscall_start(UPT_SYSCALL_NR(regs));
 
-	syscall_trace(regs, 1);
+	syscall_trace(regs, 0);
 	result = execute_syscall(regs);
 
 	REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);
@@ -30,7 +30,7 @@ void handle_syscall(union uml_pt_regs *r
 	   (result == -ERESTARTNOINTR))
 		do_signal(result);
 
-	syscall_trace(regs, 0);
+	syscall_trace(regs, 1);
 	record_syscall_end(index, result);
 }
 
diff -puN arch/um/kernel/tt/syscall_user.c~uml-fix-syscall-auditing arch/um/kernel/tt/syscall_user.c
--- vanilla-linux-2.6.9/arch/um/kernel/tt/syscall_user.c~uml-fix-syscall-auditing	2004-11-03 23:44:57.313847088 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/syscall_user.c	2004-11-03 23:44:57.316846632 +0100
@@ -33,7 +33,7 @@ void syscall_handler_tt(int sig, union u
 	SC_START_SYSCALL(sc);
 
 	index = record_syscall_start(syscall);
-	syscall_trace(regs, 1);
+	syscall_trace(regs, 0);
 	result = execute_syscall(regs);
 
 	/* regs->sc may have changed while the system call ran (there may
@@ -46,7 +46,7 @@ void syscall_handler_tt(int sig, union u
 	   (result == -ERESTARTNOINTR))
 		do_signal(result);
 
-	syscall_trace(regs, 0);
+	syscall_trace(regs, 1);
 	record_syscall_end(index, result);
 }
 
_
