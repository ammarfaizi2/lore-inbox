Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbUCPB36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUCPB3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:29:33 -0500
Received: from mail.kroah.org ([65.200.24.183]:40879 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262922AbUCPACv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:51 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913911123@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:32 -0800
Message-Id: <107939139263@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.13, 2004/02/23 16:31:52-08:00, khali@linux-fr.org

[PATCH] I2C: fix another oops in i2c-core with debug

Some times ago, you fixed an oops in i2c-core when debugging is enabled:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107585749612115&w=2

Looks like you missed that second one:


 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 15 14:36:50 2004
+++ b/drivers/i2c/i2c-core.c	Mon Mar 15 14:36:50 2004
@@ -618,7 +618,7 @@
 	int ret = 0;
 	struct i2c_adapter *adap = client->adapter;
 
-	dev_dbg(&client->dev, "i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg);
+	dev_dbg(&client->adapter->dev, "i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg);
 	switch (cmd) {
 		case I2C_RETRIES:
 			adap->retries = arg;

