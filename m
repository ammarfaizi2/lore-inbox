Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVACRwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVACRwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVACRvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:51:08 -0500
Received: from holomorphy.com ([207.189.100.168]:40604 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261693AbVACRgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:36:48 -0500
Date: Mon, 3 Jan 2005 09:36:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [5/8] silence numerous size_t warnings in drivers/acpi/processor_idle.c
Message-ID: <20050103173643.GG29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com> <20050103172615.GD29332@holomorphy.com> <20050103172839.GE29332@holomorphy.com> <20050103173406.GF29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103173406.GF29332@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple format -related warnings arise from size_t issues. This
patch peppers the seq_printf()'s with 'z' qualifiers and casts to
silence them all.

Signed-off-by: Wililam Irwin <wli@holomorphy.com>

Index: mm1-2.6.10/drivers/acpi/processor_idle.c
===================================================================
--- mm1-2.6.10.orig/drivers/acpi/processor_idle.c	2005-01-03 06:45:54.000000000 -0800
+++ mm1-2.6.10/drivers/acpi/processor_idle.c	2005-01-03 08:02:46.000000000 -0800
@@ -838,12 +838,12 @@
 	if (!pr)
 		goto end;
 
-	seq_printf(seq, "active state:            C%d\n"
+	seq_printf(seq, "active state:            C%zd\n"
 			"max_cstate:              C%d\n"
 			"bus master activity:     %08x\n",
 			pr->power.state ? pr->power.state - pr->power.states : 0,
 			max_cstate,
-			pr->power.bm_activity);
+			(unsigned)pr->power.bm_activity);
 
 	seq_puts(seq, "states:\n");
 
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
