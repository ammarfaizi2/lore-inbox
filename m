Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWHJUYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWHJUYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWHJUOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:37355 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932599AbWHJTgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:09 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [51/145] x86_64: Add some comments to entry.S
Message-Id: <20060810193605.EF46E13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:05 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

And remove some old obsolete ones.
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/entry.S |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -22,9 +22,21 @@
  * at the top of the kernel process stack.	
  * - partial stack frame: partially saved registers upto R11.
  * - full stack frame: Like partial stack frame, but all register saved. 
- *	
- * TODO:	 
- * - schedule it carefully for the final hardware.
+ *
+ * Some macro usage:
+ * - CFI macros are used to generate dwarf2 unwind information for better
+ * backtraces. They don't change any code.
+ * - SAVE_ALL/RESTORE_ALL - Save/restore all registers
+ * - SAVE_ARGS/RESTORE_ARGS - Save/restore registers that C functions modify.
+ * There are unfortunately lots of special cases where some registers
+ * not touched. The macro is a big mess that should be cleaned up.
+ * - SAVE_REST/RESTORE_REST - Handle the registers not saved by SAVE_ARGS.
+ * Gives a full stack frame.
+ * - ENTRY/END Define functions in the symbol table.
+ * - FIXUP_TOP_OF_STACK/RESTORE_TOP_OF_STACK - Fix up the hardware stack
+ * frame that is otherwise undefined after a SYSCALL
+ * - TRACE_IRQ_* - Trace hard interrupt state for lock debugging.
+ * - errorentry/paranoidentry/zeroentry - Define exception entry points.
  */
 
 #include <linux/linkage.h>
