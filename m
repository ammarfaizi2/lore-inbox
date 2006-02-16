Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWBPHQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWBPHQM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 02:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWBPHQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 02:16:12 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:20636 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932488AbWBPHQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 02:16:11 -0500
Date: Thu, 16 Feb 2006 08:15:58 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [patch 1/4] s390: ccw device disbanding
Message-ID: <20060216071558.GD9241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

If __ccw_device_disband_start() fails to initiate disbanding, it should finish
with ccw_device_disband_done() (which leaves the device in offline state)
instead of ccw_device_verify_done() (which leaves the device in online state).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/device_pgid.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2006-02-16 07:29:50.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2006-02-16 07:30:05.000000000 +0100
@@ -405,7 +405,7 @@ __ccw_device_disband_start(struct ccw_de
 		cdev->private->iretry = 5;
 		cdev->private->imask >>= 1;
 	}
-	ccw_device_verify_done(cdev, (sch->lpm != 0) ? 0 : -ENODEV);
+	ccw_device_disband_done(cdev, (sch->lpm != 0) ? 0 : -ENODEV);
 }
 
 /*
