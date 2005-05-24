Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVEXQ70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVEXQ70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVEXQ7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:59:25 -0400
Received: from fmr18.intel.com ([134.134.136.17]:43952 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262140AbVEXQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:47:12 -0400
Date: Tue, 24 May 2005 09:47:00 -0700
Message-Id: <200505241647.j4OGl0sK006514@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
To: akpm@osdl.org
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Rusty Lynch <rusty.lynch@intel.com>, Keith Owens <kaos@sgi.com>
Subject: [patch][ia64] Change break 0 notification string 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the point in traps.c where we recieve a break with a zero value, we
can not say if the break was a result of a kprobe or some other debug
facility.

This simple patch changes the informational string to a more correct
"break 0" value, and applies to the 2.6.12-rc2-mm2 tree with all the 
kprobes patches that were just recently included for the next mm cut.

    --rusty

 arch/ia64/kernel/traps.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc4/arch/ia64/kernel/traps.c
===================================================================
--- linux-2.6.12-rc4.orig/arch/ia64/kernel/traps.c
+++ linux-2.6.12-rc4/arch/ia64/kernel/traps.c
@@ -133,7 +133,7 @@ ia64_bad_break (unsigned long break_num,
 
 	switch (break_num) {
 	      case 0: /* unknown error (used by GCC for __builtin_abort()) */
-		if (notify_die(DIE_BREAK, "kprobe", regs, break_num, TRAP_BRKPT, SIGTRAP)
+		if (notify_die(DIE_BREAK, "break 0", regs, break_num, TRAP_BRKPT, SIGTRAP)
 			       	== NOTIFY_STOP) {
 			return;
 		}
