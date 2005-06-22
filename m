Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbVFVHJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVFVHJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVFVHH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:07:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:1692 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262777AbVFVFVy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:54 -0400
Cc: ladis@linux-mips.org
Subject: [PATCH] I2C: ds1337 2/4
In-Reply-To: <11194174623385@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:42 -0700
Message-Id: <1119417462982@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: ds1337 2/4

Use correct macros to convert between bdc and bin. See linux/bcd.h

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6069ffde15472da9d041a58df490d388bb175d51
tree 0e1b536969aafe6bb3a9a567be46a61b8be91886
parent 3e9d0ba1305cd7c6efd2ab3a003e58a27da1796b
author Ladislav Michl <ladis@linux-mips.org> Fri, 08 Apr 2005 15:02:16 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:51 -0700

 drivers/i2c/chips/ds1337.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -127,15 +127,15 @@ static int ds1337_get_datetime(struct i2
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
 
@@ -174,19 +174,19 @@ static int ds1337_set_datetime(struct i2
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

