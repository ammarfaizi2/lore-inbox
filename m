Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVKQNFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVKQNFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVKQNFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:05:36 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:38090 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750788AbVKQNFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:05:35 -0500
Date: Thu, 17 Nov 2005 14:05:17 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] s390: fix class_device_create calls in 3270 the driver.
Message-ID: <20051117130517.GA10381@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch] s390: fix class_device_create calls in 3270 the driver.

Add the missing NULL argument to the class_device_create calls.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/raw3270.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-patched/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	2005-11-14 09:47:51.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/raw3270.c	2005-11-17 13:30:29.000000000 +0100
@@ -1179,12 +1179,12 @@ raw3270_create_attributes(struct raw3270
 	//FIXME: check return code
 	sysfs_create_group(&rp->cdev->dev.kobj, &raw3270_attr_group);
 	rp->clttydev =
-		class_device_create(class3270,
+		class_device_create(class3270, NULL,
 				    MKDEV(IBM_TTY3270_MAJOR, rp->minor),
 				    &rp->cdev->dev, "tty%s",
 				    rp->cdev->dev.bus_id);
 	rp->cltubdev =
-		class_device_create(class3270,
+		class_device_create(class3270, NULL,
 				    MKDEV(IBM_FS3270_MAJOR, rp->minor),
 				    &rp->cdev->dev, "tub%s",
 				    rp->cdev->dev.bus_id);
