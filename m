Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbUCPBeM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbUCPBcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:32:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:32431 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262907AbUCPACk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:40 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913933600@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:33 -0800
Message-Id: <1079391393684@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.6, 2004/03/09 15:29:26-08:00, khali@linux-fr.org

[PATCH] I2C: fix i2c adapters class for now

Please accept this temporary fix for the class issue. I'd like users of
the i2c-ali1535, i2c-sis5595 and i2c-via driver to be able to use
sensors as soon as possible, even if we have not yet determined what our
policy WRT classes should be.

Thanks.

BTW, don't you think I2C_ADAP_CLASS_SMBUS is a misnomer? It's about
hardware monitoring, not the SMBus protocol. I'd say
I2C_ADAP_CLASS_HWMON or I2C_ADAP_CLASS_SENSORS would have been more
appropriate (although it may be a bit late for a change...)


 drivers/i2c/busses/i2c-ali1535.c |    1 +
 drivers/i2c/busses/i2c-sis5595.c |    1 +
 drivers/i2c/busses/i2c-via.c     |    1 +
 3 files changed, 3 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Mon Mar 15 14:34:50 2004
+++ b/drivers/i2c/busses/i2c-ali1535.c	Mon Mar 15 14:34:50 2004
@@ -484,6 +484,7 @@
 
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	Mon Mar 15 14:34:50 2004
+++ b/drivers/i2c/busses/i2c-sis5595.c	Mon Mar 15 14:34:50 2004
@@ -364,6 +364,7 @@
 
 static struct i2c_adapter sis5595_adapter = {
 	.owner		= THIS_MODULE,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c	Mon Mar 15 14:34:50 2004
+++ b/drivers/i2c/busses/i2c-via.c	Mon Mar 15 14:34:50 2004
@@ -92,6 +92,7 @@
 
 static struct i2c_adapter vt586b_adapter = {
 	.owner		= THIS_MODULE,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.name		= "VIA i2c",
 	.algo_data	= &bit_data,
 };

