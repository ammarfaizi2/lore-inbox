Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268902AbUISL2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268902AbUISL2j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 07:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269215AbUISL2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 07:28:39 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:50872 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268902AbUISL2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 07:28:35 -0400
Subject: [patch 2/2] Ptrace - SYSEMU: rename PTRACE_SCEMU to PTRACE_SYSEMU, to match the guest patch.
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Sun, 19 Sep 2004 12:06:20 +0200
Message-Id: <20040919100620.B0DF9BABF@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What name do we prefer? I'm using for PTRACE_SYSEMU; if you don't agree, we
must decide and change the guest patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.8.1-paolo/arch/i386/kernel/entry.S  |    2 +-
 vanilla-linux-2.6.8.1-paolo/arch/i386/kernel/ptrace.c |    4 ++--
 vanilla-linux-2.6.8.1-paolo/include/linux/ptrace.h    |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff -puN include/linux/ptrace.h~rename-SCEMU-to-SYSEMU include/linux/ptrace.h
--- vanilla-linux-2.6.8.1/include/linux/ptrace.h~rename-SCEMU-to-SYSEMU	2004-09-19 12:04:48.429167656 +0200
+++ vanilla-linux-2.6.8.1-paolo/include/linux/ptrace.h	2004-09-19 12:04:48.433167048 +0200
@@ -20,7 +20,7 @@
 #define PTRACE_DETACH		0x11
 
 #define PTRACE_SYSCALL		  24
-#define PTRACE_SCEMU		  31
+#define PTRACE_SYSEMU		  31
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
diff -puN arch/i386/kernel/ptrace.c~rename-SCEMU-to-SYSEMU arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.8.1/arch/i386/kernel/ptrace.c~rename-SCEMU-to-SYSEMU	2004-09-19 12:04:48.430167504 +0200
+++ vanilla-linux-2.6.8.1-paolo/arch/i386/kernel/ptrace.c	2004-09-19 12:04:48.434166896 +0200
@@ -358,7 +358,7 @@ asmlinkage int sys_ptrace(long request, 
 		  }
 		  break;
 
-	case PTRACE_SCEMU: /* continue and replace next syscall */
+	case PTRACE_SYSEMU: /* continue and replace next syscall */
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		long tmp;
@@ -366,7 +366,7 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		if (request == PTRACE_SCEMU) {
+		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 		}
 		else {
diff -puN arch/i386/kernel/entry.S~rename-SCEMU-to-SYSEMU arch/i386/kernel/entry.S
--- vanilla-linux-2.6.8.1/arch/i386/kernel/entry.S~rename-SCEMU-to-SYSEMU	2004-09-19 12:04:48.431167352 +0200
+++ vanilla-linux-2.6.8.1-paolo/arch/i386/kernel/entry.S	2004-09-19 12:04:48.434166896 +0200
@@ -341,7 +341,7 @@ syscall_trace_entry:
 	xorl %edx,%edx
 	call do_syscall_trace
 	cmpl $0, %eax
-	jne syscall_exit		# ret != 0 -> running under PTRACE_SCEMU,
+	jne syscall_exit		# ret != 0 -> running under PTRACE_SYSEMU,
 					# so must skip actual syscall
 	movl ORIG_EAX(%esp), %eax
 	cmpl $(nr_syscalls), %eax
_
