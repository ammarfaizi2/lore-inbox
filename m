Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWFRHeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWFRHeH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFRHdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:33:39 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:21148 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932145AbWFRHdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:33:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][16/29] sched-add-above-background-load-function.patch
Date: Sun, 18 Jun 2006 17:33:16 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2018
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181733.16477.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Con Kolivas <kernel@kolivas.org>

Add an above_background_load() function which can be used by other
subsystems to detect if there is anything besides niced tasks running. 
Place it in sched.h to allow it to be compiled out if not used.

Signed-off-by: Con Kolivas <kernel@kolivas.org>
Acked-by: Ingo Molnar <mingo@elte.hu>
Cc: Peter Williams <pwil3058@bigpond.net.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/sched.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)

Index: linux-ck-dev/include/linux/sched.h
===================================================================
--- linux-ck-dev.orig/include/linux/sched.h	2006-06-18 15:23:46.000000000 +1000
+++ linux-ck-dev/include/linux/sched.h	2006-06-18 15:24:45.000000000 +1000
@@ -653,6 +653,22 @@ extern unsigned int max_cache_size;
 
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

-- 
-ck
