Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVE0JAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVE0JAh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVE0JAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:00:36 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21433 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262385AbVE0I7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:59:43 -0400
Date: Fri, 27 May 2005 11:01:21 +0200
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch 1/10] s390: claw driver wiring
Message-ID: <20050527090121.GA8213@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Frank Pavlic <pavlic@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 1/10] s390: claw driver wiring.

From: Andy Richter <richtera@us.ibm.com>

claw network driver changes:
 - Add an entry to the drivers/s390/net Makefile to build the claw driver.
 - Add claw channel type to cu3088.

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 drivers/s390/net/Makefile |    1 +
 drivers/s390/net/cu3088.c |    4 +++-
 drivers/s390/net/cu3088.h |    3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/net/cu3088.c linux-2.6-patched/drivers/s390/net/cu3088.c
--- linux-2.6/drivers/s390/net/cu3088.c	2005-03-02 08:37:53.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/cu3088.c	2005-05-06 11:26:12.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * $Id: cu3088.c,v 1.34 2004/06/15 13:16:27 pavlic Exp $
+ * $Id: cu3088.c,v 1.35 2005/03/30 19:28:52 richtera Exp $
  *
  * CTC / LCS ccw_device driver
  *
@@ -39,6 +39,7 @@ const char *cu3088_type[] = {
 	"FICON channel",
 	"P390 LCS card",
 	"OSA LCS card",
+	"CLAW channel device",
 	"unknown channel type",
 	"unsupported channel type",
 };
@@ -51,6 +52,7 @@ static struct ccw_device_id cu3088_ids[]
 	{ CCW_DEVICE(0x3088, 0x1e), .driver_info = channel_type_ficon },
 	{ CCW_DEVICE(0x3088, 0x01), .driver_info = channel_type_p390 },
 	{ CCW_DEVICE(0x3088, 0x60), .driver_info = channel_type_osa2 },
+	{ CCW_DEVICE(0x3088, 0x61), .driver_info = channel_type_claw },
 	{ /* end of list */ }
 };
 
diff -urpN linux-2.6/drivers/s390/net/cu3088.h linux-2.6-patched/drivers/s390/net/cu3088.h
--- linux-2.6/drivers/s390/net/cu3088.h	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/cu3088.h	2005-05-06 11:26:12.000000000 +0200
@@ -23,6 +23,9 @@ enum channel_types {
 	/* Device is a OSA2 card */
 	channel_type_osa2,
 
+	/* Device is a CLAW channel device */
+	channel_type_claw,
+
 	/* Device is a channel, but we don't know
 	 * anything about it */
 	channel_type_unknown,
diff -urpN linux-2.6/drivers/s390/net/Makefile linux-2.6-patched/drivers/s390/net/Makefile
--- linux-2.6/drivers/s390/net/Makefile	2005-05-06 11:25:57.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/Makefile	2005-05-06 11:26:12.000000000 +0200
@@ -9,6 +9,7 @@ obj-$(CONFIG_NETIUCV) += netiucv.o fsm.o
 obj-$(CONFIG_SMSGIUCV) += smsgiucv.o
 obj-$(CONFIG_CTC) += ctc.o fsm.o cu3088.o
 obj-$(CONFIG_LCS) += lcs.o cu3088.o
+obj-$(CONFIG_CLAW) += claw.o cu3088.o
 qeth-y := qeth_main.o qeth_mpc.o qeth_sys.o qeth_eddp.o qeth_tso.o
 qeth-$(CONFIG_PROC_FS) += qeth_proc.o
 obj-$(CONFIG_QETH) += qeth.o
