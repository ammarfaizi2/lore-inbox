Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWE3RRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWE3RRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWE3RRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:17:05 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:42183 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932349AbWE3RRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:17:04 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: Mel Gorman <mel@csn.ul.ie>, mingo@elte.hu, arjan@linux.intel.com,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
Message-Id: <20060530171702.27305.73485.sendpatchset@skynet>
In-Reply-To: <20060530171642.27305.38862.sendpatchset@skynet>
References: <20060530171642.27305.38862.sendpatchset@skynet>
Subject: [PATCH 1/2] 2.6.17-rc5-mm1 compile-fix on ia64 for TRACE_IRQFLAGS
Date: Tue, 30 May 2006 18:17:02 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patches lock-validator-irqtrace-* intoduce a file
include/linux/trace_irqflags.h that includes asm/irqflags.h unconditionally.
Not all arches have this flag and ia64 is one of them so it fails to compile.
The following patch conditionally includes asm/irqflags if
CONFIG_TRACE_IRQFLAGS is set.


 trace_irqflags.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc5-mm1-clean/include/linux/trace_irqflags.h linux-2.6.17-rc5-mm1-irqflags/include/linux/trace_irqflags.h
--- linux-2.6.17-rc5-mm1-clean/include/linux/trace_irqflags.h	2006-05-30 14:41:22.000000000 +0100
+++ linux-2.6.17-rc5-mm1-irqflags/include/linux/trace_irqflags.h	2006-05-30 16:00:23.000000000 +0100
@@ -11,13 +11,13 @@
 #ifndef _LINUX_TRACE_IRQFLAGS_H
 #define _LINUX_TRACE_IRQFLAGS_H
 
-#include <asm/irqflags.h>
-
 /*
  * The local_irq_*() APIs are equal to the raw_local_irq*()
  * if !TRACE_IRQFLAGS.
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
+#include <asm/irqflags.h>
+
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
   extern void trace_softirqs_on(unsigned long ip);
