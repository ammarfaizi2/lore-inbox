Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbVJ1OII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbVJ1OII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbVJ1OII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:08:08 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:48609 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751641AbVJ1OIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:08:02 -0400
Date: Fri, 28 Oct 2005 16:08:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 6/14] s390: ccwgroup online attribute.
Message-ID: <20051028140809.GF7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@de.ibm.com>

[patch 6/14] s390: ccwgroup online attribute.

Make the interface for setting ccw group devices on-/offline consistent with
that for ccw devices: Check if the device driver provided a set_{on,off}line
function and just set the device on-/offline if not.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/ccwgroup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-patched/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/ccwgroup.c	2005-10-28 14:04:48.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.29 $
+ *   $Revision: 1.32 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
@@ -274,7 +274,7 @@ ccwgroup_set_online(struct ccwgroup_devi
 		goto out;
 	}
 	gdrv = to_ccwgroupdrv (gdev->dev.driver);
-	if ((ret = gdrv->set_online(gdev)))
+	if ((ret = gdrv->set_online ? gdrv->set_online(gdev) : 0))
 		goto out;
 
 	gdev->state = CCWGROUP_ONLINE;
@@ -300,7 +300,7 @@ ccwgroup_set_offline(struct ccwgroup_dev
 		goto out;
 	}
 	gdrv = to_ccwgroupdrv (gdev->dev.driver);
-	if ((ret = gdrv->set_offline(gdev)))
+	if ((ret = gdrv->set_offline ? gdrv->set_offline(gdev) : 0))
 		goto out;
 
 	gdev->state = CCWGROUP_OFFLINE;
