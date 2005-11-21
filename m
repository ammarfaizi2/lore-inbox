Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVKUSnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVKUSnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKUSnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:43:49 -0500
Received: from www.swissdisk.com ([216.144.233.50]:17812 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S932418AbVKUSns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:43:48 -0500
Date: Mon, 21 Nov 2005 09:35:32 -0800
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.15-rc2] Unchecked alloc_percpu() return in __create_workqueue()
Message-ID: <20051121173532.GA14962@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[UBUNTU:kernel/workqueue] __create_workqueue() not checking return of alloc_percpu()
    
NULL dereference was possible.
    
Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
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
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
