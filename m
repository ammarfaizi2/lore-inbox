Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVFTTIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVFTTIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVFTTHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:07:13 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:25610 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261477AbVFTS4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:56:49 -0400
Message-Id: <200506201851.j5KIpKPr008499@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/8] UML - Kill some useless vmalloc tlb flushing
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Jun 2005 14:51:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is absolutely no reason to flush the kernel's VM area during a
tlb_flush_mm.

This results in a noticable performance increase in the kernel build 
benchmark.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/skas/tlb.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/tlb.c	2005-06-20 11:54:56.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/tlb.c	2005-06-20 12:11:00.000000000 -0400
@@ -76,7 +76,6 @@ void flush_tlb_mm_skas(struct mm_struct 
                 return;
 
         fix_range(mm, 0, host_task_size, 0);
-        flush_tlb_kernel_range_common(start_vm, end_vm);
 }
 
 void force_flush_all_skas(void)

