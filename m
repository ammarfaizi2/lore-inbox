Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVDHNF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVDHNF1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 09:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVDHNDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 09:03:46 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:45210 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262813AbVDHNCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 09:02:22 -0400
Date: Fri, 8 Apr 2005 15:02:16 +0200
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ds1337 2/4
Message-ID: <20050408130216.GB7054@orphique>
References: <20050407231820.GC27226@orphique> <okTF4WNV.1112950260.5841330.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <okTF4WNV.1112950260.5841330.khali@localhost>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 10:51:00AM +0200, Jean Delvare wrote:
> Yes, this one is OK with me too.

Ok, here it is with signed off line.

Use correct macros to convert between bdc and bin. See linux/bcd.h

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-04-08 00:32:45.234203040 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-04-08 00:34:58.457949952 +0200
@@ -127,15 +127,15 @@
 		buf[4], buf[5], buf[6]);
 
 	if (result >= 0) {
-		dt->tm_sec = BCD_TO_BIN(buf[0]);
-		dt->tm_min = BCD_TO_BIN(buf[1]);
+		dt->tm_sec = BCD2BIN(buf[0]);
+		dt->tm_min = BCD2BIN(buf[1]);
 		val = buf[2] & 0x3f;
-		dt->tm_hour = BCD_TO_BIN(val);
-		dt->tm_wday = BCD_TO_BIN(buf[3]) - 1;
-		dt->tm_mday = BCD_TO_BIN(buf[4]);
+		dt->tm_hour = BCD2BIN(val);
+		dt->tm_wday = BCD2BIN(buf[3]) - 1;
+		dt->tm_mday = BCD2BIN(buf[4]);
 		val = buf[5] & 0x7f;
-		dt->tm_mon = BCD_TO_BIN(val);
-		dt->tm_year = 1900 + BCD_TO_BIN(buf[6]);
+		dt->tm_mon = BCD2BIN(val);
+		dt->tm_year = 1900 + BCD2BIN(buf[6]);
 		if (buf[5] & 0x80)
 			dt->tm_year += 100;
 
@@ -174,19 +174,19 @@
 		dt->tm_mday, dt->tm_mon, dt->tm_year, dt->tm_wday);
 
 	buf[0] = 0;		/* reg offset */
-	buf[1] = BIN_TO_BCD(dt->tm_sec);
-	buf[2] = BIN_TO_BCD(dt->tm_min);
-	buf[3] = BIN_TO_BCD(dt->tm_hour) | (1 << 6);
-	buf[4] = BIN_TO_BCD(dt->tm_wday) + 1;
-	buf[5] = BIN_TO_BCD(dt->tm_mday);
-	buf[6] = BIN_TO_BCD(dt->tm_mon);
+	buf[1] = BIN2BCD(dt->tm_sec);
+	buf[2] = BIN2BCD(dt->tm_min);
+	buf[3] = BIN2BCD(dt->tm_hour) | (1 << 6);
+	buf[4] = BIN2BCD(dt->tm_wday) + 1;
+	buf[5] = BIN2BCD(dt->tm_mday);
+	buf[6] = BIN2BCD(dt->tm_mon);
 	if (dt->tm_year >= 2000) {
 		val = dt->tm_year - 2000;
 		buf[6] |= (1 << 7);
 	} else {
 		val = dt->tm_year - 1900;
 	}
-	buf[7] = BIN_TO_BCD(val);
+	buf[7] = BIN2BCD(val);
 
 	msg[0].addr = client->addr;
 	msg[0].flags = 0;
