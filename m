Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVHPPoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVHPPoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbVHPPoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:44:23 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:19132 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030195AbVHPPoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:44:22 -0400
Subject: Re: 2.6.13-rc6-rt5
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124206316.5764.14.camel@localhost.localdomain>
References: <20050816121843.GA24308@elte.hu>
	 <1124206316.5764.14.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 16 Aug 2005 11:44:06 -0400
Message-Id: <1124207046.5764.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ouch, what was I thinking for that initializing flags to zero:

Sorry, lets try that again:

Signed-off-by: Steven Rostedt


Index: linux_realtime_ernie/kernel/latency.c
===================================================================
--- linux_realtime_ernie/kernel/latency.c	(revision 293)
+++ linux_realtime_ernie/kernel/latency.c	(working copy)
@@ -1307,12 +1307,13 @@
 	T1 = cycles();
 	delta = T1-T0;
 
+	raw_local_save_flags(flags);
+
 #ifndef CONFIG_CRITICAL_LATENCY_HIST
 	if (!report_latency(delta))
 		goto out;
 #endif
 
-	raw_local_save_flags(flags);
 	____trace(cpu, TRACE_FN, tr, CALLER_ADDR0, parent_eip, 0, 0, 0, flags);
 	/*
 	 * Update the timestamp, because the trace entry above
@@ -1441,7 +1442,7 @@
 	_trace_cmdline(cpu, tr);
 
 	raw_local_save_flags(flags);
-	____trace(cpu, TRACE_FN, tr, eip, parent_eip, 0, 0, 0);
+	____trace(cpu, TRACE_FN, tr, eip, parent_eip, 0, 0, 0, flags);
 
 	atomic_dec(&tr->disabled);
 }
@@ -1459,7 +1460,7 @@
 
 	atomic_inc(&tr->disabled);
 	raw_local_save_flags(flags);
-	____trace(cpu, TRACE_FN, tr, eip, parent_eip, 0, 0, 0);
+	____trace(cpu, TRACE_FN, tr, eip, parent_eip, 0, 0, 0, flags);
 	check_critical_timing(cpu, tr, eip);
 	tr->critical_start = 0;
 	atomic_dec(&tr->disabled);


