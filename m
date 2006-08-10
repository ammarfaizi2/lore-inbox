Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWHJUT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWHJUT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWHJUPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:49 -0400
Received: from ns2.suse.de ([195.135.220.15]:24811 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932468AbWHJTfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:52 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [37/145] x86_64: Support patchable lock prefix for pure assembly files
Message-Id: <20060810193551.28F3613B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:51 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Signed-off-by: Andi Kleen <ak@suse.de>

---
 include/asm-x86_64/alternative-asm.i |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

Index: linux/include/asm-x86_64/alternative-asm.i
===================================================================
--- /dev/null
+++ linux/include/asm-x86_64/alternative-asm.i
@@ -0,0 +1,14 @@
+#include <linux/config.h>
+
+#ifdef CONFIG_SMP
+	.macro LOCK_PREFIX
+1:	lock
+	.section .smp_locks,"a"
+	.align 8
+	.quad 1b
+	.previous
+	.endm
+#else
+	.macro LOCK_PREFIX
+	.endm
+#endif
