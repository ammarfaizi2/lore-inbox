Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWBPQlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWBPQlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWBPQlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:41:36 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:9070 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932328AbWBPQlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:41:35 -0500
Date: Thu, 16 Feb 2006 17:41:33 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [patch 2/3] s390: fix assignment instead of check in ccw_device_set_online()
Message-ID: <20060216164133.GI9241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Fix assignment instead of check in ccw_device_set_online().
Also remove unneeded assignment in ccw_device_do_sense().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/device.c        |    2 +-
 drivers/s390/cio/device_status.c |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-02-16 17:10:40.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-02-16 17:11:00.000000000 +0100
@@ -359,7 +359,7 @@ ccw_device_set_online(struct ccw_device 
 	else 
 		pr_debug("ccw_device_offline returned %d, device %s\n",
 			 ret, cdev->dev.bus_id);
-	return (ret = 0) ? -ENODEV : ret;
+	return (ret == 0) ? -ENODEV : ret;
 }
 
 static ssize_t
diff -urpN linux-2.6/drivers/s390/cio/device_status.c linux-2.6-patched/drivers/s390/cio/device_status.c
--- linux-2.6/drivers/s390/cio/device_status.c	2006-02-16 17:10:40.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_status.c	2006-02-16 17:11:00.000000000 +0100
@@ -317,7 +317,6 @@ ccw_device_do_sense(struct ccw_device *c
 	/*
 	 * We have ending status but no sense information. Do a basic sense.
 	 */
-	sch = to_subchannel(cdev->dev.parent);
 	sch->sense_ccw.cmd_code = CCW_CMD_BASIC_SENSE;
 	sch->sense_ccw.cda = (__u32) __pa(cdev->private->irb.ecw);
 	sch->sense_ccw.count = SENSE_MAX_COUNT;
