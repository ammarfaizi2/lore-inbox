Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272414AbTHFUbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272426AbTHFUbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:31:24 -0400
Received: from fmr06.intel.com ([134.134.136.7]:48086 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S272414AbTHFUbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:31:20 -0400
Subject: [PATCH][2.6.0-test2]adm1021 i2c driver bug fix
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Philip Edelbrock <phil@netroedge.com>, Frodo Looijaard <frodol@dds.nl>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Aug 2003 13:17:55 -0700
Message-Id: <1060201075.3854.15.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While initializing the adm1021 device, the driver is performing a conversion 
from fixed point to Celcius on values that were declaired as Celcius.  On 
my Dell Precision 220 this results in a shutdown after a couple of minutes
running.

This patch was made against the 2.6.0-test2 tree, and just removes the 
conversion.

    --rustyl

--- drivers/i2c/chips/adm1021.c.orig	2003-08-06 13:04:25.000000000 -0700
+++ drivers/i2c/chips/adm1021.c	2003-08-06 13:09:43.000000000 -0700
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



