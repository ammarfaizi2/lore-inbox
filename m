Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270047AbUJHRqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270047AbUJHRqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270045AbUJHRl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:41:56 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:61183 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S270046AbUJHRik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:38:40 -0400
Date: Fri, 8 Oct 2004 19:38:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (6/12): qeth network driver.
Message-ID: <20041008173831.GG7356@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: qeth network driver.

From: Thomas Spatzier <tspat@de.ibm.com>

qeth network driver changes:
 - Unlock queue in qeth_do_sent_packet if there is no empty buffer
   in packing state.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/qeth_main.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2004-10-08 19:18:59.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2004-10-08 19:19:13.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.138 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.145 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.138 $	 $Date: 2004/09/17 10:40:53 $
+ *    $Revision: 1.145 $	 $Date: 2004/10/08 15:08:40 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -79,7 +79,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.138 $"
+#define VERSION_QETH_C "$Revision: 1.145 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -3835,6 +3835,7 @@
 				/* return EBUSY because we sent old packet, not
 				 * the current one */
 				rc = -EBUSY;
+				atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
 				goto out;
 			}
 		}
