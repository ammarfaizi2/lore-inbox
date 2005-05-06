Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVEFW6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVEFW6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 18:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVEFWyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 18:54:50 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:38150 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261313AbVEFWyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:54:00 -0400
Message-Id: <200505062249.j46MnH9l010462@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/12] UML - Eliminate unusable function
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 May 2005 18:49:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the non-inline version of switch_mm, which can't be used, 
considering the inline version in asm/mmu_context.h

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11-mm/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/process_kern.c	2005-04-30 12:57:43.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/process_kern.c	2005-04-30 13:13:04.000000000 -0400
@@ -116,16 +116,6 @@
 	return(pid);
 }
 
-void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
-	       struct task_struct *tsk)
-{
-	int cpu = smp_processor_id();
-
-	if (prev != next) 
-		cpu_clear(cpu, prev->cpu_vm_mask);
-	cpu_set(cpu, next->cpu_vm_mask);
-}
-
 void set_current(void *t)
 {
 	struct task_struct *task = t;

