Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWA0SvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWA0SvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWA0SvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:51:23 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:9857 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751522AbWA0SvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:51:22 -0500
Message-Id: <200601271730.k0RHUlB3006281@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [PATCH 1/1] UML - compilation fix when MODE_SKAS disabled
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Jan 2006 12:30:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.16 material.

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch fixes the following compilation error when CONFIG_SKAS is disabled:

  CC      arch/um/sys-i386/ldt.o
arch/um/sys-i386/ldt.c:19:21: proc_mm.h: No such file or directory
make[1]: *** [arch/um/sys-i386/ldt.o] Error 1

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/sys-i386/ldt.c	2006-01-26 17:01:15.000000000 -0500
+++ linux-2.6.15-mm/arch/um/sys-i386/ldt.c	2006-01-26 19:48:23.000000000 -0500
@@ -16,7 +16,6 @@
 #include "choose-mode.h"
 #include "kern.h"
 #include "mode_kern.h"
-#include "proc_mm.h"
 #include "os.h"
 
 extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
@@ -90,6 +89,7 @@ out:
 #include "skas.h"
 #include "skas_ptrace.h"
 #include "asm/mmu_context.h"
+#include "proc_mm.h"
 
 long write_ldt_entry(struct mm_id * mm_idp, int func, struct user_desc * desc,
 		     void **addr, int done)

