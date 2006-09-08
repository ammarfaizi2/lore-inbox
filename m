Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751734AbWIHGfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbWIHGfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 02:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWIHGfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 02:35:18 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:34575 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1751734AbWIHGfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 02:35:15 -0400
Subject: Re: Re: [patch 6/6] process filtering for fault-injection
	capabilities
From: Don Mullis <dwm@meer.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Akinobu Mita <mita@miraclelinux.com>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 23:29:57 -0700
Message-Id: <1157696997.9460.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested changes, implemented by patch below:

1) Reorder kernel command line args alphabetically -- lets
output of `ls /debug/failslab` serve as a handy reminder
of the arg bindings.

2) Rename a variable to agree with the /debug file name.

---
 lib/should_fail.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: linux-2.6.17/lib/should_fail.c
===================================================================
--- linux-2.6.17.orig/lib/should_fail.c
+++ linux-2.6.17/lib/should_fail.c
@@ -13,18 +13,20 @@ int setup_should_fail(struct should_fail
 	unsigned long interval;
 	int times;
 	int space;
-	unsigned long filter;
+	unsigned long process_filter;
 
-	/* "<probability>,<interval>,<times>,<space>,<process-filter>" */
-	if (sscanf(str, "%lu,%lu,%d,%d,%lu", &probability, &interval, &times,
-		   &space, &filter) < 5)
-		return 0;
+	/* "<interval>,<probability>,<process-filter>,<space>,<times>" */
+	if (sscanf(str, "%lu,%lu,%lu,%d,%d", &interval,
+		   &probability, &process_filter, &space, &times) < 5) {
+		printk( "SHOULD_FAIL: failed to parse arguments\n");
+  		return 0;
+	}
 
 	data->probability = probability;
 	data->interval = interval;
 	atomic_set(&data->times, times);
 	atomic_set(&data->space, space);
-	data->process_filter = filter;
+	data->process_filter = process_filter;
 
 	return 1;
 }


