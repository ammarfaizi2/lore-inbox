Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbTH2ROR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbTH2RNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:13:13 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:3536 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261528AbTH2RK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:10:59 -0400
Date: Fri, 29 Aug 2003 19:10:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (6/8): dasd driver.
Message-ID: <20030829171030.GG1242@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove initialization of device.name.
- Export some functions.

diffstat:
 drivers/s390/block/dasd.c       |   13 ++++++++-----
 drivers/s390/block/dasd_ioctl.c |    3 +--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff -urN linux-2.6/drivers/s390/block/dasd.c linux-2.6-s390/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	Sat Aug 23 01:55:31 2003
+++ linux-2.6-s390/drivers/s390/block/dasd.c	Fri Aug 29 18:55:10 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.101 $
+ * $Revision: 1.107 $
  */
 
 #include <linux/config.h>
@@ -411,7 +411,7 @@
 		target = DASD_STATE_ACCEPT;
 	if (device->target != target) {
                 if (device->state == target)
-                        wake_up(&dasd_init_waitq);
+			wake_up(&dasd_init_waitq);
 		device->target = target;
 	}
 	if (device->state != device->target)
@@ -1752,9 +1752,6 @@
 	int devno;
 	int ret = 0;
 
-	snprintf(cdev->dev.name, DEVICE_NAME_SIZE,
-		 "Direct Access Storage Device");
-
 	devno = _ccw_device_get_device_number(cdev);
 	if (dasd_autodetect
 	    && (ret = dasd_add_range(devno, devno, DASD_FEATURE_DEFAULT))) {
@@ -2083,6 +2080,12 @@
 EXPORT_SYMBOL(dasd_start_IO);
 EXPORT_SYMBOL(dasd_term_IO);
 
+EXPORT_SYMBOL_GPL(dasd_generic_probe);
+EXPORT_SYMBOL_GPL(dasd_generic_remove);
+EXPORT_SYMBOL_GPL(dasd_generic_set_online);
+EXPORT_SYMBOL_GPL(dasd_generic_set_offline);
+EXPORT_SYMBOL_GPL(dasd_generic_auto_online);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -urN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	Sat Aug 23 01:56:59 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_ioctl.c	Fri Aug 29 18:55:10 2003
@@ -125,8 +125,7 @@
 
 /*
  * Enable device.
- * FIXME: how can we get here if the device is not already enabled?
- * 	-arnd
+ * used by dasdfmt after BIODASDDISABLE to retrigger blocksize detection
  */
 static int
 dasd_ioctl_enable(struct block_device *bdev, int no, long args)
