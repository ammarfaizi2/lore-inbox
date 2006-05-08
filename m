Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWEHOHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWEHOHq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWEHOHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:07:46 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:19635 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751118AbWEHOHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:07:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] mm: swap prefetch sched batch
Date: Tue, 9 May 2006 00:07:35 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605090007.35787.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kprefetchd is a latency insensitive ultra low priority task. Set it to
SCHED_BATCH to obtain the benefit of this scheduling policy hint.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 mm/swap_prefetch.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.17-rc3-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc3-mm1.orig/mm/swap_prefetch.c	2006-05-08 23:56:17.000000000 +1000
+++ linux-2.6.17-rc3-mm1/mm/swap_prefetch.c	2006-05-09 00:00:21.000000000 +1000
@@ -504,6 +504,9 @@ static enum trickle_return trickle_swap(
 
 static int kprefetchd(void *__unused)
 {
+	struct sched_param param = { .sched_priority = 0 };
+
+	sched_setscheduler(current, SCHED_BATCH, &param);
 	set_user_nice(current, 19);
 	/* Set ioprio to lowest if supported by i/o scheduler */
 	sys_ioprio_set(IOPRIO_WHO_PROCESS, 0, IOPRIO_CLASS_IDLE);

-- 
-ck
