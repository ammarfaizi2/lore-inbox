Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVLIPYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVLIPYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVLIPYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:24:22 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:59067 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932276AbVLIPYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:24:14 -0500
Date: Fri, 9 Dec 2005 16:24:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, horst.hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 4/17] s390: BIODASDPRRD ioctl return code.
Message-ID: <20051209152412.GE6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[patch 4/17] s390: BIODASDPRRD ioctl return code.

The IOCTL BIODASDPRRD had no return code for 'profiling is
inactive' and therefore tunedasd wrote misleading message for
request-counter = 0.
Introduce return-code EIO for inactive profiling.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/block/dasd_ioctl.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2005-12-09 14:24:23.000000000 +0100
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.47 $
+ * $Revision: 1.50 $
  *
  * i/o controls for the dasd driver.
  */
@@ -352,6 +352,9 @@ dasd_ioctl_read_profile(struct block_dev
 	if (device == NULL)
 		return -ENODEV;
 
+	if (dasd_profile_level == DASD_PROFILE_OFF)
+		return -EIO;
+
 	if (copy_to_user((long __user *) args, (long *) &device->profile,
 			 sizeof (struct dasd_profile_info_t)))
 		return -EFAULT;
