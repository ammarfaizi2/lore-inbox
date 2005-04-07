Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVDGXYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVDGXYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVDGXV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:21:27 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:18602 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262592AbVDGXR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:17:57 -0400
Date: Fri, 8 Apr 2005 01:17:58 +0200
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: [PATCH] ds1337 1/4
Message-ID: <20050407231758.GB27226@orphique>
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost> <20050407142804.GA11284@orphique> <20050407211839.GA5357@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407211839.GA5357@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 02:18:39PM -0700, Greg KH wrote:
> Jean's point is that you should send an individual patch for each type
> of individual change.  It's ok to say "patch 3 requires you to have
> applied patches 1 and 2" and so on.  Please split this up better.

Here it is...

Use i2c_transfer to send message, so we get proper bus locking.

===== drivers/i2c/chips/ds1337.c 1.1 vs edited =====
--- 1.1/drivers/i2c/chips/ds1337.c	2005-03-31 22:58:08 +02:00
+++ edited/drivers/i2c/chips/ds1337.c	2005-04-08 00:18:45 +02:00
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2005 James Chapman <jchapman@katalix.com>
  *
- *	based on linux/drivers/acron/char/pcf8583.c
+ *	based on linux/drivers/acorn/char/pcf8583.c
  *  Copyright (C) 2000 Russell King
  *
  * This program is free software; you can redistribute it and/or modify
@@ -119,8 +119,7 @@
 	msg[1].len = sizeof(buf);
 	msg[1].buf = &buf[0];
 
-	result = client->adapter->algo->master_xfer(client->adapter,
-						    &msg[0], 2);
+	result = i2c_transfer(client->adapter, msg, 2);
 
 	dev_dbg(&client->adapter->dev,
 		"%s: [%d] %02x %02x %02x %02x %02x %02x %02x\n",
@@ -194,8 +193,7 @@
 	msg[0].len = sizeof(buf);
 	msg[0].buf = &buf[0];
 
-	result = client->adapter->algo->master_xfer(client->adapter,
-						    &msg[0], 1);
+	result = i2c_transfer(client->adapter, msg, 1);
 	if (result < 0) {
 		dev_err(&client->adapter->dev, "ds1337[%d]: error "
 			"writing data! %d\n", data->id, result);
