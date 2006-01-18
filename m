Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWARQxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWARQxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWARQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:53:20 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:56481 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932501AbWARQxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:53:18 -0500
Date: Wed, 18 Jan 2006 17:52:54 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Jan Glauber <jan.glauber@de.ibm.com>
Subject: [PATCH 3/7] s390: monotonic_clock interface.
Message-ID: <20060118165254.GC29266@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

Add monotonic_clock interface, used by the hangcheck-timer.
On s390 this is the same as sched_clock().

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/time.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -urpN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2006-01-18 17:25:50.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/time.c	2006-01-18 17:25:50.000000000 +0100
@@ -64,6 +64,15 @@ unsigned long long sched_clock(void)
 	return ((get_clock() - jiffies_timer_cc) * 125) >> 9;
 }
 
+/*
+ * Monotonic_clock - returns # of nanoseconds passed since time_init()
+ */
+unsigned long long monotonic_clock(void)
+{
+	return sched_clock();
+}
+EXPORT_SYMBOL(monotonic_clock);
+
 void tod_to_timeval(__u64 todval, struct timespec *xtime)
 {
 	unsigned long long sec;
