Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTGASds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTGASdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:33:46 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:38632 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S263271AbTGAScg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:32:36 -0400
Date: Tue, 1 Jul 2003 20:45:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (3/6): online attribute.
Message-ID: <20030701184552.GD12212@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix online attribute. "echo 1 > online" should enable a device and
"echo 0 > online" should disable a device, not the other way round.

diffstat:
 drivers/s390/cio/device.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urN linux-2.5/drivers/s390/cio/device.c linux-2.5-s390/drivers/s390/cio/device.c
--- linux-2.5/drivers/s390/cio/device.c	Tue Jul  1 20:48:10 2003
+++ linux-2.5-s390/drivers/s390/cio/device.c	Tue Jul  1 20:48:27 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.57 $
+ *   $Revision: 1.58 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -305,9 +305,9 @@
 		return count;
 
 	i = simple_strtoul(buf, &tmp, 16);
-	if (i == 0 && cdev->drv->set_online)
+	if (i == 1 && cdev->drv->set_online)
 		ccw_device_set_online(cdev);
-	else if (i == 1 && cdev->drv->set_offline)
+	else if (i == 0 && cdev->drv->set_offline)
 		ccw_device_set_offline(cdev);
 	else
 		return -EINVAL;
