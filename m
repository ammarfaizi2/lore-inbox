Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422759AbWJZJDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbWJZJDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbWJZJDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:03:16 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:18589 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422759AbWJZJDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:03:13 -0400
Date: Thu, 26 Oct 2006 11:03:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: Make ccw_device_register() static.
Message-ID: <20061026090311.GE16270@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: Make ccw_device_register() static.

ccw_device_register() is only called from io_subchannel_register()
and io_subchannel_probe() and will never be called for possible
non-io subchannels.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |    3 +--
 drivers/s390/cio/device.h |    1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-10-26 10:43:46.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-10-26 10:44:06.000000000 +0200
@@ -532,8 +532,7 @@ device_remove_files(struct device *dev)
 
 /* this is a simple abstraction for device_register that sets the
  * correct bus type and adds the bus specific files */
-int
-ccw_device_register(struct ccw_device *cdev)
+static int ccw_device_register(struct ccw_device *cdev)
 {
 	struct device *dev = &cdev->dev;
 	int ret;
diff -urpN linux-2.6/drivers/s390/cio/device.h linux-2.6-patched/drivers/s390/cio/device.h
--- linux-2.6/drivers/s390/cio/device.h	2006-10-26 10:43:46.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.h	2006-10-26 10:44:06.000000000 +0200
@@ -78,7 +78,6 @@ void io_subchannel_recog_done(struct ccw
 
 int ccw_device_cancel_halt_clear(struct ccw_device *);
 
-int ccw_device_register(struct ccw_device *);
 void ccw_device_do_unreg_rereg(void *);
 void ccw_device_call_sch_unregister(void *);
 
