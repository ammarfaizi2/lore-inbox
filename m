Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbTHVMxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbTHVMvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:51:20 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:30626 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S263188AbTHVMnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 08:43:02 -0400
Subject: [PATCH] sched: CPU_THRESHOLD
From: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 22 Aug 2003 14:43:01 +0200
Message-Id: <1061556181.3404.31.camel@tom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Next patch provides a CPU_THRESHOLD; makes sense since we also have a NODE_THRESHOLD as tuning knob.


Frank.


 sched.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Aug 22 14:20:23 2003
+++ b/kernel/sched.c	Fri Aug 22 14:20:23 2003
@@ -76,6 +76,7 @@
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
+#define CPU_THRESHOLD		75
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -963,10 +964,9 @@
 	if (likely(!busiest))
 		goto out;
 
-	*imbalance = (max_load - nr_running) / 2;
+	*imbalance = (max_load - nr_running) >> 1;
 
-	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (*imbalance < (max_load + 3)/4)) {
+	if (!idle && (*imbalance*100 < nr_running*CPU_THRESHOLD)) {
 		busiest = NULL;
 		goto out;
 	}



