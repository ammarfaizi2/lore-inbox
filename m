Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUDHOaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUDHOaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:30:09 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:9133 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261832AbUDHO3I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:29:08 -0400
Date: Thu, 8 Apr 2004 16:28:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/12): dasd driver fix.
Message-ID: <20040408142856.GE1793@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dasd driver changes:
 - Fix check for device type in error recovery for fba devices.

diffstat:
 drivers/s390/block/dasd_fba.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urN linux-2.6/drivers/s390/block/dasd_fba.c linux-2.6-s390/drivers/s390/block/dasd_fba.c
--- linux-2.6/drivers/s390/block/dasd_fba.c	Sun Apr  4 05:37:36 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_fba.c	Thu Apr  8 15:21:25 2004
@@ -4,7 +4,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.32 $
+ * $Revision: 1.33 $
  */
 
 #include <linux/config.h>
@@ -205,7 +205,7 @@
 		return dasd_era_none;
 	
 	cdev = device->cdev;
-	switch (cdev->id.dev_model) {
+	switch (cdev->id.dev_type) {
 	case 0x3370:
 		return dasd_3370_erp_examine(cqr, irb);
 	case 0x9336:
