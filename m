Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263912AbTDIWTT (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263878AbTDIWR5 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:17:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:46799 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263883AbTDIWRl convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:17:41 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10499274991425@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.67
In-Reply-To: <10499274992999@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Apr 2003 15:31:39 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1033.5.2, 2003/04/07 15:56:32-07:00, greg@kroah.com

i2c: fix up compile error in scx200_i2c driver.


 drivers/i2c/scx200_i2c.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/scx200_i2c.c b/drivers/i2c/scx200_i2c.c
--- a/drivers/i2c/scx200_i2c.c	Wed Apr  9 15:16:24 2003
+++ b/drivers/i2c/scx200_i2c.c	Wed Apr  9 15:16:24 2003
@@ -82,9 +82,11 @@
 
 static struct i2c_adapter scx200_i2c_ops = {
 	.owner		   = THIS_MODULE,
-	.name              = "NatSemi SCx200 I2C",
 	.id		   = I2C_HW_B_VELLE,
 	.algo_data	   = &scx200_i2c_data,
+	.dev		= {
+		.name	= "NatSemi SCx200 I2C",
+	},
 };
 
 int scx200_i2c_init(void)
@@ -110,7 +112,7 @@
 
 	if (i2c_bit_add_bus(&scx200_i2c_ops) < 0) {
 		printk(KERN_ERR NAME ": adapter %s registration failed\n", 
-		       scx200_i2c_ops.name);
+		       scx200_i2c_ops.dev.name);
 		return -ENODEV;
 	}
 	

