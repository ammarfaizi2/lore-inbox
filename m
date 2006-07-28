Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWG1DGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWG1DGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWG1DGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:06:46 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:55018 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932107AbWG1DGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:06:44 -0400
Message-Id: <200607280306.k6S36NFb007936@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Frank van Maarseveen <frankvm@frankvm.com>
Subject: [PATCH 4/7] UML - Fix stack alignment
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Jul 2006 23:06:23 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stack randomization needs to be conditional on the personality allowing it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/process_kern.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/process_kern.c	2006-07-13 15:05:02.000000000 -0400
@@ -23,6 +23,7 @@
 #include "linux/proc_fs.h"
 #include "linux/ptrace.h"
 #include "linux/random.h"
+#include "linux/personality.h"
 #include "asm/unistd.h"
 #include "asm/mman.h"
 #include "asm/segment.h"
@@ -476,7 +477,7 @@ int singlestepping(void * t)
 #ifndef arch_align_stack
 unsigned long arch_align_stack(unsigned long sp)
 {
-	if (randomize_va_space)
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }

