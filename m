Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbTIVXkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbTIVXhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:37:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:2209 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262404AbTIVXag convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:36 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1064273416272@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734162392@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:16 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1153.85.2, 2003/08/27 15:29:33-07:00, mds@paradyne.com

[PATCH] I2C: i2c-isa functionality

The "functionality" return was incorrectly removed for i2c-isa.c when porting to 2.5.
A driver that does nothing must return a 0 or else i2c-core assumes
0xffffffff (all functionality).


 drivers/i2c/busses/i2c-isa.c |    9 +++++++++
 1 files changed, 9 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c	Mon Sep 22 16:17:05 2003
+++ b/drivers/i2c/busses/i2c-isa.c	Mon Sep 22 16:17:05 2003
@@ -30,10 +30,13 @@
 #include <linux/errno.h>
 #include <linux/i2c.h>
 
+static u32 isa_func(struct i2c_adapter *adapter);
+
 /* This is the actual algorithm we define */
 static struct i2c_algorithm isa_algorithm = {
 	.name		= "ISA bus algorithm",
 	.id		= I2C_ALGO_ISA,
+	.functionality	= isa_func,
 };
 
 /* There can only be one... */
@@ -44,6 +47,12 @@
 	.algo		= &isa_algorithm,
 	.name		= "ISA main adapter",
 };
+
+/* We can't do a thing... */
+static u32 isa_func(struct i2c_adapter *adapter)
+{
+	return 0;
+}
 
 static int __init i2c_isa_init(void)
 {

