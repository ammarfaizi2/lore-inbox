Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbUL2X56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUL2X56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 18:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUL2X55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 18:57:57 -0500
Received: from fmr24.intel.com ([143.183.121.16]:38844 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261449AbUL2X5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 18:57:55 -0500
Date: Wed, 29 Dec 2004 15:57:54 -0800
Message-Id: <200412292357.iBTNvs521605@unix-os.sc.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: len.brown@intel.com
cc: linux-kernel@vger.kernel.org
Subject: 3 warnings from drivers/acpi/processor_idle.c
Reply-to: tony.luck@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling on ia64 I see:
drivers/acpi/processor_idle.c:846: warning: int format, different type arg (arg 3)
drivers/acpi/processor_idle.c:877: warning: int format, different type arg (arg 3)
drivers/acpi/processor_idle.c:884: warning: int format, different type arg (arg 3)

This is the result of using "%d" to print the difference between two pointers.

Use "%zd" instead.

Signed-off-by: Tony Luck <tony.luck@intel.com>

===== drivers/acpi/processor_idle.c 1.15 vs edited =====
--- 1.15/drivers/acpi/processor_idle.c	2004-12-23 05:39:58 -08:00
+++ edited/drivers/acpi/processor_idle.c	2004-12-29 15:45:49 -08:00
@@ -838,7 +838,7 @@
 	if (!pr)
 		goto end;
 
-	seq_printf(seq, "active state:            C%d\n"
+	seq_printf(seq, "active state:            C%zd\n"
 			"max_cstate:              C%d\n"
 			"bus master activity:     %08x\n",
 			pr->power.state ? pr->power.state - pr->power.states : 0,
@@ -872,14 +872,14 @@
 		}
 
 		if (pr->power.states[i].promotion.state)
-			seq_printf(seq, "promotion[C%d] ",
+			seq_printf(seq, "promotion[C%zd] ",
 				(pr->power.states[i].promotion.state -
 				 pr->power.states));
 		else
 			seq_puts(seq, "promotion[--] ");
 
 		if (pr->power.states[i].demotion.state)
-			seq_printf(seq, "demotion[C%d] ",
+			seq_printf(seq, "demotion[C%zd] ",
 				(pr->power.states[i].demotion.state -
 				 pr->power.states));
 		else
