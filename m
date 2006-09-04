Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWIDJYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWIDJYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWIDJYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:24:40 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:10614 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751170AbWIDJYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:24:38 -0400
Date: Mon, 4 Sep 2006 11:24:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Missing initialization in common i/o layer.
Message-ID: <20060904092435.GB9215@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Missing initialization in common i/o layer.

Previous patch that was intended to reduce stack usage within common
i/o layer didn't consider implicit memset(..., 0, ...) used with the
initializations used before.
Add these missing memsets wherever it's not obvious that the
concerned memory region is zeroed. This should give the same semantics
as before.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-09-04 11:08:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-09-04 11:08:59.000000000 +0200
@@ -267,6 +267,7 @@ ccw_device_recog_done(struct ccw_device 
 			notify = 1;
 		}
 		/* fill out sense information */
+		memset(&cdev->id, 0, sizeof(cdev->id));
 		cdev->id.cu_type   = cdev->private->senseid.cu_type;
 		cdev->id.cu_model  = cdev->private->senseid.cu_model;
 		cdev->id.dev_type  = cdev->private->senseid.dev_type;

-- 
VGER BF report: U 0.495386
