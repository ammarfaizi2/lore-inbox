Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271298AbTHMAEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271289AbTHMAEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:04:22 -0400
Received: from fmr05.intel.com ([134.134.136.6]:22265 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271298AbTHMAEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:04:20 -0400
Subject: [PATCH 2.6.0-test3]bugfix for initialization bug in adm1021 driver
From: Rusty Lynch <rusty@linux.co.intel.com>
To: LM Sensors <sensors@stimpy.netroedge.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Aug 2003 16:38:13 -0700
Message-Id: <1060731495.11264.8.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While initializing the adm1021 device, the driver is performing a conversion
from fixed point to Celcius on values that were declaired as Celcius.  On
my Dell Precision 220 this results in a shutdown after a couple of minutes
running.

This is a very simple patch against the 2.6.0-test3 tree that just removes the
conversion.

    --rustyl


diff -urN linux-2.6.0-test3/drivers/i2c/chips/adm1021.c linux-2.6.0-test3-patched/drivers/i2c/chips/adm1021.c
--- linux-2.6.0-test3/drivers/i2c/chips/adm1021.c	2003-08-08 21:31:16.000000000 -0700
+++ linux-2.6.0-test3-patched/drivers/i2c/chips/adm1021.c	2003-08-12 16:54:25.000000000 -0700
@@ -356,13 +356,13 @@
 {
 	/* Initialize the adm1021 chip */
 	adm1021_write_value(client, ADM1021_REG_TOS_W,
-			    TEMP_TO_REG(adm1021_INIT_TOS));
+			    adm1021_INIT_TOS);
 	adm1021_write_value(client, ADM1021_REG_THYST_W,
-			    TEMP_TO_REG(adm1021_INIT_THYST));
+			    adm1021_INIT_THYST);
 	adm1021_write_value(client, ADM1021_REG_REMOTE_TOS_W,
-			    TEMP_TO_REG(adm1021_INIT_REMOTE_TOS));
+			    adm1021_INIT_REMOTE_TOS);
 	adm1021_write_value(client, ADM1021_REG_REMOTE_THYST_W,
-			    TEMP_TO_REG(adm1021_INIT_REMOTE_THYST));
+			    adm1021_INIT_REMOTE_THYST);
 	/* Enable ADC and disable suspend mode */
 	adm1021_write_value(client, ADM1021_REG_CONFIG_W, 0);
 	/* Set Conversion rate to 1/sec (this can be tinkered with) */



