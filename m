Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbVFVFnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVFVFnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVFVFjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:39:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:55964 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262817AbVFVFWT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:19 -0400
Cc: ladis@linux-mips.org
Subject: [PATCH] I2C: ds1337 1/4
In-Reply-To: <11194174613004@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:42 -0700
Message-Id: <11194174622441@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: ds1337 1/4

Use i2c_transfer to send message, so we get proper bus locking.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3e9d0ba1305cd7c6efd2ab3a003e58a27da1796b
tree bdbcf0d4fca8ed72cb59ae89fa9e513bd2c3da3e
parent 69113efac29e5f1b7a03dd4fdca5ede6901f4eb8
author Ladislav Michl <ladis@linux-mips.org> Fri, 08 Apr 2005 15:00:21 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:50 -0700

 drivers/i2c/chips/ds1337.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2005 James Chapman <jchapman@katalix.com>
  *
- *	based on linux/drivers/acron/char/pcf8583.c
+ *	based on linux/drivers/acorn/char/pcf8583.c
  *  Copyright (C) 2000 Russell King
  *
  * This program is free software; you can redistribute it and/or modify
@@ -119,8 +119,7 @@ static int ds1337_get_datetime(struct i2
 	msg[1].len = sizeof(buf);
 	msg[1].buf = &buf[0];
 
-	result = client->adapter->algo->master_xfer(client->adapter,
-						    &msg[0], 2);
+	result = i2c_transfer(client->adapter, msg, 2);
 
 	dev_dbg(&client->adapter->dev,
 		"%s: [%d] %02x %02x %02x %02x %02x %02x %02x\n",
@@ -194,8 +193,7 @@ static int ds1337_set_datetime(struct i2
 	msg[0].len = sizeof(buf);
 	msg[0].buf = &buf[0];
 
-	result = client->adapter->algo->master_xfer(client->adapter,
-						    &msg[0], 1);
+	result = i2c_transfer(client->adapter, msg, 1);
 	if (result < 0) {
 		dev_err(&client->adapter->dev, "ds1337[%d]: error "
 			"writing data! %d\n", data->id, result);

