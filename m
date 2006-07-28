Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWG1Rzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWG1Rzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161206AbWG1Rzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:55:55 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:59860 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161204AbWG1Rzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:55:54 -0400
Date: Fri, 28 Jul 2006 13:50:42 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 1/2] i386: add CFI macros for stack manipulation
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607281353_MC3-1-C662-536D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add macros to dwarf2.h to simplify pushing and popping stack
variables.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc2-32.orig/include/asm-i386/dwarf2.h
+++ 2.6.18-rc2-32/include/asm-i386/dwarf2.h
@@ -51,4 +51,26 @@
 
 #endif
 
-#endif
+.macro	CFI_pushl val
+	pushl \val
+	CFI_ADJUST_CFA_OFFSET 4
+.endm
+
+.macro	CFI_pushl_reg reg
+	pushl %\reg
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET \reg, 0
+.endm
+
+.macro	CFI_popl val
+	popl \val
+	CFI_ADJUST_CFA_OFFSET -4
+.endm
+
+.macro	CFI_popl_reg reg
+	popl %\reg
+	CFI_ADJUST_CFA_OFFSET -4
+	CFI_RESTORE \reg
+.endm
+
+#endif /* _DWARF2_H */
-- 
Chuck
