Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbUBVM0O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 07:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUBVM0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 07:26:14 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:1548 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261233AbUBVM0N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 07:26:13 -0500
Date: Sun, 22 Feb 2004 13:26:11 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] Another oops in i2c-core with debug
Message-Id: <20040222132611.57e9faa7.khali@linux-fr.org>
Reply-To: sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Some times ago, you fixed an oops in i2c-core when debugging is enabled:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107585749612115&w=2

Looks like you missed that second one:

--- linux-2.6.3/drivers/i2c/i2c-core.c	2004-02-18 20:18:14.000000000 +0100
+++ linux-2.6.3-i2c/drivers/i2c/i2c-core.c	2004-02-22 13:04:11.000000000 +0100
@@ -618,7 +618,7 @@
 	int ret = 0;
 	struct i2c_adapter *adap = client->adapter;
 
-	dev_dbg(&client->dev, "i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg);
+	dev_dbg(&client->adapter->dev, "i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg);
 	switch (cmd) {
 		case I2C_RETRIES:
 			adap->retries = arg;


Reported by Emil Svensson on IRC. Sensors-detect would trigger the oops
(through i2c-dev), I could reproduce it easily. Works OK after applying
the patch above.

Please apply,
Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
