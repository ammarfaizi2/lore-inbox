Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269164AbUING1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269164AbUING1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269156AbUINGZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:25:38 -0400
Received: from [12.177.129.25] ([12.177.129.25]:30147 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269163AbUINGYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:24:07 -0400
Message-Id: <200409140727.i8E7RsL7005658@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Enable the timer *after* the timer handler
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 03:27:54 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, we'll sometimes get timer interrupts that we can't handle.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/kernel/skas/process_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/skas/process_kern.c	2004-09-14 02:03:57.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/skas/process_kern.c	2004-09-14 02:04:00.000000000 -0400
@@ -224,9 +224,9 @@
 {
 	start_userspace(0);
 	capture_signal_stack();
-	uml_idle_timer();
 
 	init_new_thread_signals(1);
+	uml_idle_timer();
 
 	init_task.thread.request.u.thread.proc = start_kernel_proc;
 	init_task.thread.request.u.thread.arg = NULL;
More recent patches modify files in timer.

