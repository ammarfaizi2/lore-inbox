Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbUKTM05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUKTM05 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbUKTM05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 07:26:57 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:61448 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262810AbUKTM0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 07:26:48 -0500
Date: Sat, 20 Nov 2004 13:26:47 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] I2C updates for 2.4.28 (3/5)
Message-Id: <20041120132647.364b2fa4.khali@linux-fr.org>
In-Reply-To: <20041120125423.42527051.khali@linux-fr.org>
References: <20041120125423.42527051.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original report and discussion:
http://marc.theaimsgroup.com/?l=linux-arm-kernel&m=109816546827995&w=2
http://marc.theaimsgroup.com/?l=linux-arm-kernel&m=109926079025024&w=2

Bottom line:
Two hardcoded buffer sizes in i2c_smbus_xfer_emulated (i2c-core) should
depend on I2C_SMBUS_BLOCK_MAX. Else increasing I2C_SMBUS_BLOCK_MAX (in
include/linux/i2c.h) will result in buffer overflows.

Credits go to Tehn Yit Chin for noticing the suspicious hardcoded
values.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.4.28-rc1/drivers/i2c/i2c-core.c.orig	2004-10-27 23:45:48.000000000 +0200
+++ linux-2.4.28-rc1/drivers/i2c/i2c-core.c	2004-10-29 19:18:09.000000000 +0200
@@ -1098,8 +1098,8 @@
 	  need to use only one message; when reading, we need two. We initialize
 	  most things with sane defaults, to keep the code below somewhat
 	  simpler. */
-	unsigned char msgbuf0[34];
-	unsigned char msgbuf1[34];
+	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+2];
+	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
 	int num = read_write == I2C_SMBUS_READ?2:1;
 	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 }, 
 	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }


-- 
Jean Delvare
http://khali.linux-fr.org/
