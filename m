Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbTL3WYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265857AbTL3WN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:13:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:53441 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265844AbTL3WGe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:34 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <1072821971560@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:11 -0800
Message-Id: <10728219711872@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.8.33, 2003/12/17 16:06:23-08:00, mhoffman@lightlink.com

[PATCH] I2C: remove initialization of limits by lm75 driver

This patch is from the lm_sensors project CVS, from this revision:

	1.44 (mds) remove initialization of limits by driver

It is better to set these limits by a combination of /etc/sensors.conf
and 'sensors -s'; "mechanism not policy."


 drivers/i2c/chips/lm75.c |    8 --------
 1 files changed, 8 deletions(-)


diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Tue Dec 30 12:30:13 2003
+++ b/drivers/i2c/chips/lm75.c	Tue Dec 30 12:30:13 2003
@@ -51,10 +51,6 @@
 #define TEMP_FROM_REG(val)	((((val & 0x7fff) >> 7) * 5) | ((val & 0x8000)?-256:0))
 #define TEMP_TO_REG(val)	(SENSORS_LIMIT((val<0?(0x200+((val)/5))<<7:(((val) + 2) / 5) << 7),0,0xffff))
 
-/* Initial values */
-#define LM75_INIT_TEMP_OS	600
-#define LM75_INIT_TEMP_HYST	500
-
 /* Each client has this additional data */
 struct lm75_data {
 	struct semaphore	update_lock;
@@ -258,10 +254,6 @@
 static void lm75_init_client(struct i2c_client *client)
 {
 	/* Initialize the LM75 chip */
-	lm75_write_value(client, LM75_REG_TEMP_OS,
-			 TEMP_TO_REG(LM75_INIT_TEMP_OS));
-	lm75_write_value(client, LM75_REG_TEMP_HYST,
-			 TEMP_TO_REG(LM75_INIT_TEMP_HYST));
 	lm75_write_value(client, LM75_REG_CONF, 0);
 }
 

