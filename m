Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263607AbUESLCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUESLCm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUESLB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:01:58 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:61405 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S263646AbUESLBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:01:46 -0400
Date: Wed, 19 May 2004 13:01:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/4): dasd driver.
Message-ID: <20040519110142.GC5888@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: dasd driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

dasd device driver changes:
 - Reset pointer from ccw device to dasd_devmap on device removal.

diffstat:
 drivers/s390/block/dasd_devmap.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -urN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	Mon May 10 04:32:37 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_devmap.c	Wed May 19 12:47:29 2004
@@ -11,7 +11,7 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.27 $
+ * $Revision: 1.28 $
  */
 
 #include <linux/config.h>
@@ -526,6 +526,9 @@
 	cdev = device->cdev;
 	device->cdev = NULL;
 
+	/* Disconnect dasd_devmap structure from ccw_device structure. */
+	cdev->dev.driver_data = NULL;
+
 	/* Put ccw_device structure. */
 	put_device(&cdev->dev);
 
