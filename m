Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVB1ROI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVB1ROI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 12:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVB1ROH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 12:14:07 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:32779 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S261694AbVB1RNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 12:13:42 -0500
Message-ID: <4223513F.4030403@katalix.com>
Date: Mon, 28 Feb 2005 17:13:35 +0000
From: James Chapman <jchapman@katalix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: sensors@stimpy.netroedge.com
CC: linux-kernel@vger.kernel.org, khali@linux-fr.org
Subject: [PATCH: 2.6.11-rc5] i2c chips: add adt7461 support to lm90 driver
Content-Type: multipart/mixed;
 boundary="------------050700030009070208090202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050700030009070208090202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Add ADT7461 (temperature sensor) support to LM90 driver.

Signed-off-by: James Chapman <jchapman@katalix.com>






--------------050700030009070208090202
Content-Type: text/plain;
 name="lm90.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lm90.patch"

diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2005-02-27 13:24:11 +00:00
+++ b/drivers/i2c/chips/lm90.c	2005-02-27 13:24:11 +00:00
@@ -85,7 +85,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_5(lm90, adm1032, lm99, lm86, max6657);
+SENSORS_INSMOD_6(lm90, adm1032, lm99, lm86, max6657, adt7461);
 
 /*
  * The LM90 registers
@@ -386,7 +386,10 @@
 			 && (reg_config1 & 0x3F) == 0x00
 			 && reg_convrate <= 0x0A) {
 				kind = adm1032;
-			}
+			} else
+			if (address == 0x4c
+			 && chip_id == 0x51) /* ADT7461 */
+				kind = adt7461;
 		} else
 		if (man_id == 0x4D) { /* Maxim */
 			/*
@@ -423,6 +426,8 @@
 		name = "lm86";
 	} else if (kind == max6657) {
 		name = "max6657";
+	} else if (kind == adt7461) {
+		name = "adt7461";
 	}
 
 	/* We can fill in the remaining client fields */






--------------050700030009070208090202--
