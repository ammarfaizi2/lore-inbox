Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVGUTVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVGUTVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 15:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVGUTVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 15:21:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62088 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261847AbVGUTVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 15:21:45 -0400
Date: Thu, 21 Jul 2005 21:21:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>, xschmi00@stud.feec.vutbr.cz,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] no disk yoyo for -mm
Message-ID: <20050721192143.GA5917@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

The attached patch stops the disks from spinning down and up on
suspend.  The patch applies to 2.6.13-rc3-mm1 (depends on
pm_message_t being struct).

Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

---
commit 3d1f9a53dcf4a73934daeb878493ed512fd78407
tree 53c0d3101fa18fbfeae3dd0a4214428319dace99
parent c21641336d5c83a41d15cdb34f18413f2b8217fd
author <pavel@amd.(none)> Thu, 21 Jul 2005 21:20:05 +0200
committer <pavel@amd.(none)> Thu, 21 Jul 2005 21:20:05 +0200

 drivers/ide/ide-io.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -150,7 +150,7 @@ static void ide_complete_power_step(ide_
 
 	switch (rq->pm->pm_step) {
 	case ide_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
-		if (rq->pm->pm_state == 4)
+		if (rq->pm->pm_state == PM_EVENT_FREEZE)
 			rq->pm->pm_step = ide_pm_state_completed;
 		else
 			rq->pm->pm_step = idedisk_pm_standby;

-- 
teflon -- maybe it is a trademark, but it should not be.
