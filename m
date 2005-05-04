Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVEDH3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVEDH3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVEDH31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:29:27 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:51127 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262073AbVEDH2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:28:01 -0400
Date: Wed, 4 May 2005 08:13:13 +0200
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: [PATCH] ds1337 1/3
Message-ID: <20050504061313.GB1439@orphique>
References: <20050407231848.GD27226@orphique> <u5mZNEX1.1112954918.3200720.khali@localhost> <20050408130639.GC7054@orphique> <20050502204136.GE32713@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502204136.GE32713@kroah.com>
User-Agent: Mutt/1.5.9i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

thanks for applying changes. Here is next batch of incremental
patches for ds1337. These were created against 2.6.12-rc2 patched with
ds1337 [123]/4. Changes were discussed with James Chapman privately
and he sent me his Signed-off-by line for submition.


Make time format consistent with other RTC drivers.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: James Chapman <jchapman@katalix.com>

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-04-13 11:48:32.000000000 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-04-18 09:22:45.531771744 +0200
@@ -130,8 +130,8 @@ static int ds1337_get_datetime(struct i2
 		dt->tm_wday = BCD2BIN(buf[3]) - 1;
 		dt->tm_mday = BCD2BIN(buf[4]);
 		val = buf[5] & 0x7f;
-		dt->tm_mon = BCD2BIN(val);
-		dt->tm_year = 1900 + BCD2BIN(buf[6]);
+		dt->tm_mon = BCD2BIN(val) - 1;
+		dt->tm_year = BCD2BIN(buf[6]);
 		if (buf[5] & 0x80)
 			dt->tm_year += 100;
 
@@ -171,12 +171,11 @@ static int ds1337_set_datetime(struct i2
 	buf[3] = BIN2BCD(dt->tm_hour) | (1 << 6);
 	buf[4] = BIN2BCD(dt->tm_wday) + 1;
 	buf[5] = BIN2BCD(dt->tm_mday);
-	buf[6] = BIN2BCD(dt->tm_mon);
-	if (dt->tm_year >= 2000) {
-		val = dt->tm_year - 2000;
+	buf[6] = BIN2BCD(dt->tm_mon) + 1;
+	val = dt->tm_year;
+	if (val >= 100) {
+		val -= 100;
 		buf[6] |= (1 << 7);
-	} else {
-		val = dt->tm_year - 1900;
 	}
 	buf[7] = BIN2BCD(val);
 
