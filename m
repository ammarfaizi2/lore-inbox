Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVGVBRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVGVBRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 21:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVGVBRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 21:17:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52631 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261963AbVGVBRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 21:17:51 -0400
Date: Fri, 22 Jul 2005 03:17:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, alexn@telia.com
Subject: [patch] fix u32 vs. pm_message_t confusion in mesh.c
Message-ID: <20050722011752.GA8388@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Nyberg <alexn@telia.com>

Fix u32 vs. pm_message_t confusion in drivers/scsi/mesh.c.

Signed-off-by: Alexander Nyberg <alexn@telia.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 3bd0270be587b87ec14f1fdc50bd8c9e3f1142dc
tree 01e19108833246642422af3371b0ca996ade1893
parent b3ace94a1a465a2084bed642021aa8c8ddd912d1
author <pavel@amd.(none)> Fri, 22 Jul 2005 03:14:24 +0200
committer <pavel@amd.(none)> Fri, 22 Jul 2005 03:14:24 +0200

 drivers/scsi/mesh.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -1766,7 +1766,7 @@ static int mesh_suspend(struct macio_dev
 	struct mesh_state *ms = (struct mesh_state *)macio_get_drvdata(mdev);
 	unsigned long flags;
 
-	if (state == mdev->ofdev.dev.power.power_state || state < 2)
+	if (state.event == mdev->ofdev.dev.power.power_state.event || state.event < 2)
 		return 0;
 
 	scsi_block_requests(ms->host);
@@ -1791,7 +1791,7 @@ static int mesh_resume(struct macio_dev 
 	struct mesh_state *ms = (struct mesh_state *)macio_get_drvdata(mdev);
 	unsigned long flags;
 
-	if (mdev->ofdev.dev.power.power_state == 0)
+	if (mdev->ofdev.dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	set_mesh_power(ms, 1);
@@ -1802,7 +1802,7 @@ static int mesh_resume(struct macio_dev 
 	enable_irq(ms->meshintr);
 	scsi_unblock_requests(ms->host);
 
-	mdev->ofdev.dev.power.power_state = 0;
+	mdev->ofdev.dev.power.power_state.event = PM_EVENT_ON;
 
 	return 0;
 }

-- 
teflon -- maybe it is a trademark, but it should not be.
