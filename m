Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270797AbTHOSqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270757AbTHOSey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:34:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:52868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270755AbTHOSdJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:33:09 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10609724081720@kroah.com>
Subject: Re: [PATCH] i2c driver changes 2.6.0-test3
In-Reply-To: <10609724071636@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:33:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1123.18.6, 2003/08/14 14:31:21-07:00, rusty@linux.co.intel.com

[PATCH] I2C: bugfix for initialization bug in adm1021 driver

While initializing the adm1021 device, the driver is performing a conversion
from fixed point to Celcius on values that were declaired as Celcius.  On
my Dell Precision 220 this results in a shutdown after a couple of minutes
running.

This is a very simple patch against the 2.6.0-test3 tree that just removes the
conversion.


 drivers/i2c/chips/adm1021.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Fri Aug 15 11:26:53 2003
+++ b/drivers/i2c/chips/adm1021.c	Fri Aug 15 11:26:53 2003
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

