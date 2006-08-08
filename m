Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWHHU6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWHHU6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWHHU6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:58:43 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:17618 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964983AbWHHU6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:58:42 -0400
Message-Id: <200608082058.k78KwJpx006536@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Rob Landley <rob@landley.net>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: [PATCH 2/2] UML - use ptrace-abi.h instead of ptrace.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Aug 2006 16:58:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Include the host architecture's ptrace-abi.h instead of ptrace.h.

There was some cpp mangling of names around the ptrace.h include to
avoid symbol clashes between UML and the host architecture.  Most of
these can go away.  The exception is struct pt_regs, which is
convenient to have in userspace, but must be renamed in order that UML
can define its own.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/include/asm-um/ptrace-generic.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/ptrace-generic.h	2006-08-06 14:51:28.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/ptrace-generic.h	2006-08-06 20:35:20.000000000 -0400
@@ -8,18 +8,9 @@
 
 #ifndef __ASSEMBLY__
 
-
 #define pt_regs pt_regs_subarch
-#define show_regs show_regs_subarch
-#define send_sigtrap send_sigtrap_subarch
-
-#include "asm/arch/ptrace.h"
-
+#include "asm/arch/ptrace-abi.h"
 #undef pt_regs
-#undef show_regs
-#undef send_sigtrap
-#undef user_mode
-#undef instruction_pointer
 
 #include "sysdep/ptrace.h"
 

