Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268633AbUJTQJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268633AbUJTQJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268575AbUJTQFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:05:38 -0400
Received: from 62-3-251-85.dyn.gotadsl.co.uk ([62.3.251.85]:33666 "EHLO
	talia.fluff.org") by vger.kernel.org with ESMTP id S268474AbUJTQEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:04:07 -0400
Date: Wed, 20 Oct 2004 18:03:05 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix compile of drivers/i2c/busses/i2c-s3c2410.c
Message-ID: <20041020170305.GA12953@fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fixes missing <asm/io.h> and removes the references to I2C_ALGO_S3C2410

Thanks to Dimitry Andric <dimitry.andric@tomtom.com> for finding this.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="s3c-i2cfix1.patch"

--- linux-2.6.9-bk4-orig/drivers/i2c/busses/i2c-s3c2410.c	2004-10-20 15:50:29.000000000 +0100
+++ linux-2.6.9-bk4/drivers/i2c/busses/i2c-s3c2410.c	2004-10-20 16:29:03.000000000 +0100
@@ -36,6 +36,7 @@
 
 #include <asm/hardware.h>
 #include <asm/irq.h>
+#include <asm/io.h>
 
 #include <asm/hardware/clock.h>
 #include <asm/arch/regs-gpio.h>
@@ -534,7 +535,6 @@
 
 static struct i2c_algorithm s3c24xx_i2c_algorithm = {
 	.name			= "S3C2410-I2C-Algorithm",
-	.id			= I2C_ALGO_S3C2410,
 	.master_xfer		= s3c24xx_i2c_xfer,
 };
 
@@ -543,7 +543,6 @@
 	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER(s3c24xx_i2c.wait),
 	.adap	= {
 		.name			= "s3c2410-i2c",
-		.id			= I2C_ALGO_S3C2410,
 		.algo			= &s3c24xx_i2c_algorithm,
 		.retries		= 2,
 	},

--DocE+STaALJfprDB--
