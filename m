Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWDCRX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWDCRX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWDCRXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:23:55 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:63182 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751778AbWDCRXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:23:52 -0400
Date: Mon, 3 Apr 2006 19:23:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 9/9] s390: minor tape fixes.
Message-ID: <20060403172351.GI11049@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[patch 9/9] s390: minor tape fixes.

Cleanup of minor bugs found by a source code checker.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape_block.c |    4 ++--
 drivers/s390/char/tape_core.c  |   10 +++-------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/tape_block.c linux-2.6-patched/drivers/s390/char/tape_block.c
--- linux-2.6/drivers/s390/char/tape_block.c	2006-04-03 18:46:20.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_block.c	2006-04-03 18:46:42.000000000 +0200
@@ -432,8 +432,8 @@ tapeblock_ioctl(
 ) {
 	int rc;
 	int minor;
-	struct gendisk *disk = inode->i_bdev->bd_disk;
-	struct tape_device *device = disk->private_data;
+	struct gendisk *disk;
+	struct tape_device *device;
 
 	rc     = 0;
 	disk   = inode->i_bdev->bd_disk;
diff -urpN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-patched/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	2006-04-03 18:46:20.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_core.c	2006-04-03 18:46:42.000000000 +0200
@@ -210,18 +210,14 @@ tape_state_set(struct tape_device *devic
 		return;
 	}
 	DBF_EVENT(4, "ts. dev:	%x\n", device->first_minor);
-	if (device->tape_state < TO_SIZE && device->tape_state >= 0)
-		str = tape_state_verbose[device->tape_state];
-	else
-		str = "UNKNOWN TS";
-	DBF_EVENT(4, "old ts:	%s\n", str);
-	if (device->tape_state < TO_SIZE && device->tape_state >=0 )
+	DBF_EVENT(4, "old ts:\t\n");
+	if (device->tape_state < TS_SIZE && device->tape_state >=0 )
 		str = tape_state_verbose[device->tape_state];
 	else
 		str = "UNKNOWN TS";
 	DBF_EVENT(4, "%s\n", str);
 	DBF_EVENT(4, "new ts:\t\n");
-	if (newstate < TO_SIZE && newstate >= 0)
+	if (newstate < TS_SIZE && newstate >= 0)
 		str = tape_state_verbose[newstate];
 	else
 		str = "UNKNOWN TS";
