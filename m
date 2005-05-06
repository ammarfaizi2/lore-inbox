Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVEFCJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVEFCJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 22:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVEFCJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 22:09:32 -0400
Received: from ozlabs.org ([203.10.76.45]:52436 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262128AbVEFCJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 22:09:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17018.53756.948706.526038@cargo.ozlabs.ibm.com>
Date: Fri, 6 May 2005 12:10:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
CC: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/ppc64: Replace custom MIN macro
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Tobias Klauser.

Replace a custom MIN() macro with the min() macro from kernel.h
This patch removes 4 lines of redundant code.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -urpN linux-2.6.12-rc2.orig/arch/ppc64/kernel/signal.c linux-2.6.12-rc2/arch/ppc64/kernel/signal.c
--- linux-2.6.12-rc2.orig/arch/ppc64/kernel/signal.c	2005-04-07 16:18:30.287667016 +0200
+++ linux-2.6.12-rc2/arch/ppc64/kernel/signal.c	2005-04-07 16:19:14.159997408 +0200
@@ -42,11 +42,7 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-#ifndef MIN
-#define MIN(a,b) (((a) < (b)) ? (a) : (b))
-#endif
-
-#define GP_REGS_SIZE	MIN(sizeof(elf_gregset_t), sizeof(struct pt_regs))
+#define GP_REGS_SIZE	min(sizeof(elf_gregset_t), sizeof(struct pt_regs))
 #define FP_REGS_SIZE	sizeof(elf_fpregset_t)
 
 #define TRAMP_TRACEBACK	3
