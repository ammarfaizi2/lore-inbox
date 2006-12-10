Return-Path: <linux-kernel-owner+w=401wt.eu-S1761271AbWLJPmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761271AbWLJPmO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 10:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761276AbWLJPmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 10:42:14 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:3470 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761271AbWLJPmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 10:42:14 -0500
Message-Id: <20061210154047.314107000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sun, 10 Dec 2006 07:40:47 -0800
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] compile error on interrupt off timing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a compile error with lockdep off, and interrupt off timing on. 
Fixed below, and I also fixed the ifdef comments.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 kernel/latency_trace.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6.19/kernel/latency_trace.c
===================================================================
--- linux-2.6.19.orig/kernel/latency_trace.c
+++ linux-2.6.19/kernel/latency_trace.c
@@ -1886,7 +1886,7 @@ void notrace time_hardirqs_off(unsigned 
 		__start_critical_timing(a0, a1, INTERRUPT_LATENCY);
 }
 
-#else /* !CONFIG_TRACE_IRQFLAGS */
+#else /* !CONFIG_LOCKDEP */
 
 /*
  * Dummy:
@@ -1908,6 +1908,10 @@ void trace_softirqs_off(unsigned long ip
 {
 }
 
+inline void print_irqtrace_events(struct task_struct *curr)
+{
+}
+
 /*
  * We are only interested in hardirq on/off events:
  */
@@ -1935,7 +1939,7 @@ void notrace trace_hardirqs_off(void)
 
 EXPORT_SYMBOL(trace_hardirqs_off);
 
-#endif /* CONFIG_TRACE_IRQFLAGS */
+#endif /* !CONFIG_LOCKDEP */
 
 #endif /* CONFIG_CRITICAL_IRQSOFF_TIMING */
 
--
