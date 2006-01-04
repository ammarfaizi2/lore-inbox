Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWADWCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWADWCh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWADWCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:02:05 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:11255 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S932144AbWADWCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:02:00 -0500
Date: Wed, 04 Jan 2006 17:01:39 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 14/15] workqueue: Check return of alloc_percpu().
To: linux-kernel@vger.kernel.org
Message-id: <0ISL00ER69776A@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 kernel/workqueue.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

7d2b5b2a0fd4293aa49326b9bf03ca11610f9030
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2bd5aee..a5e3e8a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -315,6 +315,11 @@ struct workqueue_struct *__create_workqu
 		return NULL;
 
 	wq->cpu_wq = alloc_percpu(struct cpu_workqueue_struct);
+	if (!wq->cpu_wq) {
+		kfree(wq);
+		return NULL;
+	}
+
 	wq->name = name;
 	/* We don't need the distraction of CPUs appearing and vanishing. */
 	lock_cpu_hotplug();
-- 
1.0.5
