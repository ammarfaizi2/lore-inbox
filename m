Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWFRHfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWFRHfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWFRHfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:35:11 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:5290 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932147AbWFRHfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:35:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][24/29] mm-idleprio_prio.patch
Date: Sun, 18 Jun 2006 17:34:57 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1260
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181734.57431.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the effective priority of idleprio tasks to that of nice 19 tasks when
modifying vm reclaim behaviour.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 mm/vmscan.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-ck-dev/mm/vmscan.c
===================================================================
--- linux-ck-dev.orig/mm/vmscan.c	2006-06-18 15:25:07.000000000 +1000
+++ linux-ck-dev/mm/vmscan.c	2006-06-18 15:25:09.000000000 +1000
@@ -911,6 +911,8 @@ static int effective_sc_prio(struct task
 	if (likely(p->mm)) {
 		if (rt_task(p))
 			return -20;
+		if (idleprio_task(p))
+			return 19;
 		return task_nice(p);
 	}
 	return 0;

-- 
-ck
