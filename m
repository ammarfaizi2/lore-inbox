Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263722AbTCUS0C>; Fri, 21 Mar 2003 13:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263714AbTCUSYs>; Fri, 21 Mar 2003 13:24:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52099
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263722AbTCUSXy>; Fri, 21 Mar 2003 13:23:54 -0500
Date: Fri, 21 Mar 2003 19:39:04 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211939.h2LJd4e9025863@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Fix i2o_scsi hang
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/message/i2o/i2o_scsi.c linux-2.5.65-ac2/drivers/message/i2o/i2o_scsi.c
--- linux-2.5.65/drivers/message/i2o/i2o_scsi.c	2003-02-15 03:39:30.000000000 +0000
+++ linux-2.5.65-ac2/drivers/message/i2o/i2o_scsi.c	2003-03-14 01:14:29.000000000 +0000
@@ -85,7 +85,7 @@
 static u32 *retry[32];
 static struct i2o_controller *retry_ctrl[32];
 static struct timer_list retry_timer;
-static spinlock_t retry_lock;
+static spinlock_t retry_lock = SPIN_LOCK_UNLOCKED;
 static int retry_ct = 0;
 
 static atomic_t queue_depth;
