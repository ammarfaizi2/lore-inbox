Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVFVGSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVFVGSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVFVGQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:16:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:45468 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262812AbVFVFWM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:12 -0400
Cc: ladis@linux-mips.org
Subject: [PATCH] I2C: ds1337: Make time format consistent with other RTC drivers
In-Reply-To: <11194174624039@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:42 -0700
Message-Id: <11194174623385@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: ds1337: Make time format consistent with other RTC drivers

Make time format consistent with other RTC drivers.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0b46e334d77b2d3b8b3aa665c81c4afbe9f1f458
tree ecf82d1aa2a4416835a082500970df3784e1194e
parent d01b79d0613ebb6810bb48baf6e53e9319701fea
author Ladislav Michl <ladis@linux-mips.org> Wed, 04 May 2005 08:13:13 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:51 -0700

 drivers/i2c/chips/ds1337.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
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
 

