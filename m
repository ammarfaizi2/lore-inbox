Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263878AbTDIWT2 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTDIWRx (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:17:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:63369 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263878AbTDIWRl convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:17:41 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10499275002316@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.67
In-Reply-To: <10499275003618@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Apr 2003 15:31:40 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1133.1.5, 2003/04/09 11:04:03-07:00, schlicht@uni-mannheim.de

[PATCH] i2c: fix compilation error for various i2c-devices

Changed the i2c_adapter name definition to match the current interface.


 drivers/i2c/i2c-adap-ite.c |    4 +++-
 drivers/i2c/i2c-frodo.c    |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/i2c-adap-ite.c b/drivers/i2c/i2c-adap-ite.c
--- a/drivers/i2c/i2c-adap-ite.c	Wed Apr  9 15:15:46 2003
+++ b/drivers/i2c/i2c-adap-ite.c	Wed Apr  9 15:15:46 2003
@@ -196,9 +196,11 @@
 
 static struct i2c_adapter iic_ite_ops = {
 	.owner		= THIS_MODULE,
-	.name		= "ITE IIC adapter",
 	.id		= I2C_HW_I_IIC,
 	.algo_data	= &iic_ite_data,
+	.dev		= {
+		.name	= "ITE IIC adapter",
+	},
 };
 
 /* Called when the module is loaded.  This function starts the
diff -Nru a/drivers/i2c/i2c-frodo.c b/drivers/i2c/i2c-frodo.c
--- a/drivers/i2c/i2c-frodo.c	Wed Apr  9 15:15:46 2003
+++ b/drivers/i2c/i2c-frodo.c	Wed Apr  9 15:15:46 2003
@@ -59,9 +59,11 @@
 
 static struct i2c_adapter frodo_ops = {
 	.owner			= THIS_MODULE,
-	.name			= "Frodo adapter driver",
 	.id			= I2C_HW_B_FRODO,
 	.algo_data		= &bit_frodo_data,
+	.dev			= {
+		.name		= "Frodo adapter driver",
+	},
 };
 
 static int __init i2c_frodo_init (void)

