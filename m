Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWG2Tm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWG2Tm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWG2Tm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:42:57 -0400
Received: from ns1.suse.de ([195.135.220.2]:22231 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752080AbWG2Tmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:42:54 -0400
Date: Sat, 29 Jul 2006 21:42:52 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.18] [7/8] i386: Fix up backtrace fallback patch
Message-ID: <44cbba3c.i0UP/Ku2zRdY6TMm%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I didn't test all compilation combinations. Shame on me.
And fix a missing option in the boot option following x86-64 (Jan Beulich)
 
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/traps.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6.18-rc2-git7/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.18-rc2-git7.orig/arch/i386/kernel/traps.c
+++ linux-2.6.18-rc2-git7/arch/i386/kernel/traps.c
@@ -190,11 +190,11 @@ static void show_trace_log_lvl(struct ta
 		if (unw_ret > 0 && !arch_unw_user_mode(&info)) {
 #ifdef CONFIG_STACK_UNWIND
 			print_symbol("DWARF2 unwinder stuck at %s\n",
-				     UNW_PC(info.regs));
+				     UNW_PC(&info));
 			if (call_trace == 1) {
 				printk("Leftover inexact backtrace:\n");
-				if (UNW_SP(info.regs))
-					stack = (void *)UNW_SP(info.regs);
+				if (UNW_SP(&info))
+					stack = (void *)UNW_SP(&info);
 			} else if (call_trace > 1)
 				return;
 			else
@@ -1249,8 +1249,10 @@ static int __init call_trace_setup(char 
 		call_trace = -1;
 	else if (strcmp(s, "both") == 0)
 		call_trace = 0;
-	else if (strcmp(s, "new") == 0)
+	else if (strcmp(s, "newfallback") == 0)
 		call_trace = 1;
+	else if (strcmp(s, "new") == 2)
+		call_trace = 2;
 	return 1;
 }
 __setup("call_trace=", call_trace_setup);
