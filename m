Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUHXN3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUHXN3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUHXN3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:29:51 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:59122 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S267798AbUHXN1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:27:37 -0400
Date: Tue, 24 Aug 2004 15:28:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: qeth network driver.
Message-ID: <20040824132804.GD5954@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: qeth network driver.

From: Steffen Thoss <thoss@de.ibm.com>

qeth network driver change:
 - Make qeth devices which are present but not up addressable by
   snmp ioctls.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/qeth_main.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-s390/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	Tue Aug 24 15:12:22 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_main.c	Tue Aug 24 15:12:44 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.130 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.132 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.130 $	 $Date: 2004/08/05 11:21:50 $
+ *    $Revision: 1.132 $	 $Date: 2004/08/19 12:39:43 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -79,7 +79,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.130 $"
+#define VERSION_QETH_C "$Revision: 1.132 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -4547,7 +4547,8 @@
 	if (!card)
 		return -ENODEV;
 
-	if (card->state != CARD_STATE_UP)
+	if ((card->state != CARD_STATE_UP) &&
+            (card->state != CARD_STATE_SOFTSETUP))
 		return -ENODEV;
 
 	switch (cmd){
