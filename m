Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWCMIIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWCMIIT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 03:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWCMIIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 03:08:19 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:28034 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932345AbWCMIIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 03:08:18 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [PATCH][3/4] sched: add above background load function
Date: Mon, 13 Mar 2006 19:07:59 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2055
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200603131908.00161.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an above_background_load() function which can be used by other subsystems
to detect if there is anything besides niced tasks running. Place it in
sched.h to allow it to be compiled out if not used.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 include/linux/sched.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)

Index: linux-2.6.16-rc6-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/linux/sched.h	2006-03-13 17:05:14.000000000 +1100
+++ linux-2.6.16-rc6-mm1/include/linux/sched.h	2006-03-13 17:24:18.000000000 +1100
@@ -638,6 +638,22 @@ extern unsigned int max_cache_size;
 
 #endif	/* CONFIG_SMP */
 
+/*
+ * A runqueue laden with a single nice 0 task scores a weighted_cpuload of
+ * SCHED_LOAD_SCALE. This function returns 1 if any cpu is laden with a
+ * task of nice 0 or enough lower priority tasks to bring up the
+ * weighted_cpuload
+ */
+static inline int above_background_load(void)
+{
+	unsigned long cpu;
+
+	for_each_online_cpu(cpu) {
+		if (weighted_cpuload(cpu) >= SCHED_LOAD_SCALE)
+			return 1;
+	}
+	return 0;
+}
 
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
