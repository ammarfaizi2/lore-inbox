Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752093AbWCNCWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbWCNCWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 21:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbWCNCWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 21:22:31 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:46501 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1752093AbWCNCWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 21:22:30 -0500
Subject: Re: 2.6.16-rc6-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060312220218.GA3469@elte.hu>
References: <20060312220218.GA3469@elte.hu>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 21:22:10 -0500
Message-Id: <1142302930.27125.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I noticed that if I have latency tracing on and don't have early_printk,
it also won't compile.  Here's a patch to solve that too.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rc6-rt2/kernel/latency.c
===================================================================
--- linux-2.6.16-rc6-rt2.orig/kernel/latency.c	2006-03-13 10:25:30.000000000 -0500
+++ linux-2.6.16-rc6-rt2/kernel/latency.c	2006-03-13 19:59:55.000000000 -0500
@@ -495,6 +495,7 @@
 
 #endif
 
+#ifdef CONFIG_EARLY_PRINTK
 static void notrace early_printk_name(unsigned long eip)
 {
 	char namebuf[KSYM_NAME_LEN+1];
@@ -556,7 +557,9 @@
 	}
 	spin_unlock(&early_print_lock);
 }
-
+#else
+#  define early_print_entry(x) do { } while(0)
+#endif
 
 static void notrace
 ____trace(int cpu, enum trace_type type, struct cpu_trace *tr,


