Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWHJUWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWHJUWb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWHJUPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:35 -0400
Received: from mx1.suse.de ([195.135.220.2]:29840 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932542AbWHJTf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:57 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [42/145] i386: add alternative-asm.h to allow LOCK_PREFIX replacement in .S files
Message-Id: <20060810193556.6FE1413B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:56 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

LOCK_PREFIX is replaced by nops on UP systems, so it has to be a special
macro.  Previously this was only possible from C. Allow it for pure 
assembly files too. Similar to earlier x86-64 patch.
Signed-off-by: Andi Kleen <ak@suse.de>

---
 include/asm-i386/alternative-asm.i |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

Index: linux/include/asm-i386/alternative-asm.i
===================================================================
--- /dev/null
+++ linux/include/asm-i386/alternative-asm.i
@@ -0,0 +1,14 @@
+#include <linux/config.h>
+
+#ifdef CONFIG_SMP
+	.macro LOCK_PREFIX
+1:	lock
+	.section .smp_locks,"a"
+	.align 4
+	.long 1b
+	.previous
+	.endm
+#else
+	.macro LOCK_PREFIX
+	.endm
+#endif
