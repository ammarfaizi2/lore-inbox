Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264244AbUFKRit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbUFKRit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbUFKRis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:38:48 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:27889 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S264244AbUFKRcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:32:46 -0400
Date: Fri, 11 Jun 2004 19:32:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: common i/o layer.
Message-ID: <20040611173253.GE3279@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: common i/o layer.

From: Cornelia Huck <cohuck@de.ibm.com>

Common i/o layer changes:
 - Remove bogus defines.
 - Fix length of strncmp on bus id.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/chsc.c   |    3 +--
 drivers/s390/cio/chsc.h   |    1 -
 drivers/s390/cio/device.c |    5 +++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-s390/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	Fri Jun 11 19:09:24 2004
+++ linux-2.6-s390/drivers/s390/cio/chsc.c	Fri Jun 11 19:09:57 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.111 $
+ *   $Revision: 1.112 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -24,7 +24,6 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define CHPID_LONGS (256 / (8 * sizeof(long))) /* 256 chpids */
 static struct channel_path *chps[NR_CHPIDS];
 
 static void *sei_page;
diff -urN linux-2.6/drivers/s390/cio/chsc.h linux-2.6-s390/drivers/s390/cio/chsc.h
--- linux-2.6/drivers/s390/cio/chsc.h	Mon May 10 04:33:13 2004
+++ linux-2.6-s390/drivers/s390/cio/chsc.h	Fri Jun 11 19:09:57 2004
@@ -23,5 +23,4 @@
 extern void s390_process_css( void );
 extern void chsc_validate_chpids(struct subchannel *);
 extern void chpid_is_actually_online(int);
-extern int is_chpid_online(int);
 #endif
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Fri Jun 11 19:09:24 2004
+++ linux-2.6-s390/drivers/s390/cio/device.c	Fri Jun 11 19:09:57 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.119 $
+ *   $Revision: 1.120 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -526,7 +526,8 @@
 		cdev = to_ccwdev(dev);
 		if ((cdev->private->state == DEV_STATE_DISCONNECTED) &&
 		    (cdev->private->devno == devno) &&
-		    (!strncmp(cdev->dev.bus_id, sibling->dev.bus_id, 4))) {
+		    (!strncmp(cdev->dev.bus_id, sibling->dev.bus_id,
+			      BUS_ID_SIZE))) {
 			cdev->private->state = DEV_STATE_NOT_OPER;
 			break;
 		}
