Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbVAQWDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbVAQWDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVAQWAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:00:17 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:52364 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262910AbVAQVtV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:21 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Fix bogus bitmask in lm63 debug message
In-Reply-To: <11059983953842@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:46:35 -0800
Message-Id: <11059983951840@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.5, 2005/01/14 14:42:49-08:00, khali@linux-fr.org

[PATCH] I2C: Fix bogus bitmask in lm63 debug message

There is a bitmask error in one debug message of my lm63 chip driver.
Nothing critical but still worth fixing, hence comes a patch.

Credits go to Mohan Mistry for finding the error.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm63.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/lm63.c b/drivers/i2c/chips/lm63.c
--- a/drivers/i2c/chips/lm63.c	2005-01-17 13:20:43 -08:00
+++ b/drivers/i2c/chips/lm63.c	2005-01-17 13:20:43 -08:00
@@ -464,8 +464,8 @@
 		(data->config & 0x04) ? "tachometer input" :
 		"alert output");
 	dev_dbg(&client->dev, "PWM clock %s kHz, output frequency %u Hz\n",
-		(data->config_fan & 0x04) ? "1.4" : "360",
-		((data->config_fan & 0x04) ? 700 : 180000) / data->pwm1_freq);
+		(data->config_fan & 0x08) ? "1.4" : "360",
+		((data->config_fan & 0x08) ? 700 : 180000) / data->pwm1_freq);
 	dev_dbg(&client->dev, "PWM output active %s, %s mode\n",
 		(data->config_fan & 0x10) ? "low" : "high",
 		(data->config_fan & 0x20) ? "manual" : "auto");

