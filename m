Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVHOSTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVHOSTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVHOSTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:19:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:48793 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964884AbVHOSTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:19:45 -0400
Date: Mon, 15 Aug 2005 11:19:43 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm PATCH 19/32] drivers/dlm: fix-up schedule_timeout() usage
Message-ID: <20050815181943.GV2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Use schedule_timeout_interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 drivers/dlm/lockspace.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -urpN 2.6.13-rc5-mm1/drivers/dlm/lockspace.c 2.6.13-rc5-mm1-dev/drivers/dlm/lockspace.c
--- 2.6.13-rc5-mm1/drivers/dlm/lockspace.c	2005-08-07 10:05:20.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/dlm/lockspace.c	2005-08-08 14:34:39.000000000 -0700
@@ -54,8 +54,7 @@ static int dlm_scand(void *data)
 	while (!kthread_should_stop()) {
 		list_for_each_entry(ls, &lslist, ls_list)
 			dlm_scan_rsbs(ls);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(dlm_config.scan_secs * HZ);
+		schedule_timeout_interruptible(dlm_config.scan_secs * HZ);
 	}
 	return 0;
 }
