Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVAMPbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVAMPbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVAMPbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:31:13 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:53764 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261651AbVAMPbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:31:01 -0500
Subject: [patch 3/8] uml: Commentary addition to recent SYSEMU fix.
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 06:13:29 +0100
Message-Id: <20050113051330.097A36324D@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Add some comments about the "uml-sysemu-fixes" patch of 2.6.10-mm1 (merged in 2.6.11-rc1).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/tt/tracer.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

diff -puN arch/um/kernel/tt/tracer.c~uml-comment-fix-sysemu-tt arch/um/kernel/tt/tracer.c
--- linux-2.6.11/arch/um/kernel/tt/tracer.c~uml-comment-fix-sysemu-tt	2005-01-13 01:56:56.494835760 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/tt/tracer.c	2005-01-13 01:56:56.498835152 +0100
@@ -313,6 +313,15 @@ int tracer(int (*init_proc)(void *), voi
 				sig = 0;
 				op = do_proc_op(task, proc_id);
 				switch(op){
+				/*
+				 * This is called when entering user mode; after
+				 * this, we start intercepting syscalls.
+				 *
+				 * In fact, a process is started in kernel mode,
+				 * so with is_tracing() == 0 (and that is reset
+				 * when executing syscalls, since UML kernel has
+				 * the right to do syscalls);
+				 */
 				case OP_TRACE_ON:
 					arch_leave_kernel(task, pid);
 					tracing = 1;
@@ -347,6 +356,11 @@ int tracer(int (*init_proc)(void *), voi
 					continue;
 				}
 				tracing = 0;
+				/* local_using_sysemu has been already set
+				 * below, since if we are here, is_tracing() on
+				 * the traced task was 1, i.e. the process had
+				 * already run through one iteration of the
+				 * loop which executed a OP_TRACE_ON request.*/
 				do_syscall(task, pid, local_using_sysemu);
 				sig = SIGUSR2;
 				break;
_
