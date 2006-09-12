Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWILPyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWILPyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWILPyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:54:39 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:17616 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751450AbWILPyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:54:20 -0400
Message-Id: <200609121552.k8CFqDcJ008012@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       76306.1226@compuserve.com, ak@muc.de, jeremy@xensource.com,
       rusty@rustcorp.com.au, zach@vmware.com
Subject: [PATCH 2/2] Make UML use ptrace-abi.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Sep 2006 11:52:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Include the host architecture's ptrace-abi.h instead of ptrace.h.

There was some cpp mangling of names around the ptrace.h include to
avoid symbol clashes between UML and the host architecture.  Most of
these can go away.  The exception is struct pt_regs, which is
convenient to have in userspace, but must be renamed in order that UML
can define its own.

ptrace-x86_64.h needed to have some now-obsolete cpp cruft and a declaration
removed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/include/asm-um/ptrace-generic.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/ptrace-generic.h	2006-09-12 11:09:26.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/ptrace-generic.h	2006-09-12 11:17:23.000000000 -0400
@@ -8,19 +8,7 @@
 
 #ifndef __ASSEMBLY__
 
-
-#define pt_regs pt_regs_subarch
-#define show_regs show_regs_subarch
-#define send_sigtrap send_sigtrap_subarch
-
-#include "asm/arch/ptrace.h"
-
-#undef pt_regs
-#undef show_regs
-#undef send_sigtrap
-#undef user_mode
-#undef instruction_pointer
-
+#include "asm/arch/ptrace-abi.h"
 #include "sysdep/ptrace.h"
 
 struct pt_regs {
Index: linux-2.6.18-mm/include/asm-um/ptrace-x86_64.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/ptrace-x86_64.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/ptrace-x86_64.h	2006-09-12 11:43:41.000000000 -0400
@@ -11,15 +11,11 @@
 #include "asm/errno.h"
 #include "asm/host_ldt.h"
 
-#define signal_fault signal_fault_x86_64
 #define __FRAME_OFFSETS /* Needed to get the R* macros */
 #include "asm/ptrace-generic.h"
-#undef signal_fault
 
 #define HOST_AUDIT_ARCH AUDIT_ARCH_X86_64
 
-void signal_fault(struct pt_regs_subarch *regs, void *frame, char *where);
-
 #define FS_BASE (21 * sizeof(unsigned long))
 #define GS_BASE (22 * sizeof(unsigned long))
 #define DS (23 * sizeof(unsigned long))

