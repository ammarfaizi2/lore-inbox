Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbTLPEO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 23:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbTLPEO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 23:14:26 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:2495 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S264343AbTLPEOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 23:14:23 -0500
Date: Mon, 15 Dec 2003 23:03:33 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: [PATCH 2.6] sensors chip updates (3 of 4)
Message-ID: <20031216040333.GD1658@earth.solarsys.private>
References: <20031216035219.GA1658@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031216035219.GA1658@earth.solarsys.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is from the lm_sensors project CVS, from this revision:

	1.44 (mds) remove initialization of limits by driver

It is better to set these limits by a combination of /etc/sensors.conf
and 'sensors -s'; "mechanism not policy." 

--- linux-2.6.0-test11-gkh/drivers/i2c/chips/lm75.c	2003-12-14 13:53:50.000000000 -0500
+++ linux-2.6.0-test11-mmh/drivers/i2c/chips/lm75.c	2003-12-14 17:52:49.000000000 -0500
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
 
-- 
Mark M. Hoffman
mhoffman@lightlink.com

