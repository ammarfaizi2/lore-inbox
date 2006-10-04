Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030767AbWJDImB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030767AbWJDImB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 04:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030770AbWJDImB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 04:42:01 -0400
Received: from havoc.gtf.org ([69.61.125.42]:55941 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030767AbWJDImA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 04:42:00 -0400
Date: Wed, 4 Oct 2006 04:41:53 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, david-b@pacbell.net,
       a.zummo@towertech.it
Subject: [PATCH] RTC: build fixes
Message-ID: <20061004084153.GA12618@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix obvious build breakage revealed by 'make allyesconfig'
in current -git.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/rtc/rtc-ds1307.c  |    6 +++---
 drivers/rtc/rtc-ds1672.c  |    4 ++--
 drivers/rtc/rtc-rs5c372.c |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index cc5032b..3f0f7b8 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -141,9 +141,9 @@ static int ds1307_set_time(struct device
 
 	dev_dbg(dev, "%s secs=%d, mins=%d, "
 		"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
-		"write", dt->tm_sec, dt->tm_min,
-		dt->tm_hour, dt->tm_mday,
-		dt->tm_mon, dt->tm_year, dt->tm_wday);
+		"write", t->tm_sec, t->tm_min,
+		t->tm_hour, t->tm_mday,
+		t->tm_mon, t->tm_year, t->tm_wday);
 
 	*buf++ = 0;		/* first register addr */
 	buf[DS1307_REG_SECS] = BIN2BCD(t->tm_sec);
diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index 9c68ec9..67e816a 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -55,7 +55,7 @@ static int ds1672_get_datetime(struct i2
 	}
 
 	dev_dbg(&client->dev,
-		"%s: raw read data - counters=%02x,%02x,%02x,%02x\n"
+		"%s: raw read data - counters=%02x,%02x,%02x,%02x\n",
 		__FUNCTION__, buf[0], buf[1], buf[2], buf[3]);
 
 	time = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
@@ -96,7 +96,7 @@ static int ds1672_set_datetime(struct i2
 	unsigned long secs;
 
 	dev_dbg(&client->dev,
-		"%s: secs=%d, mins=%d, hours=%d, ",
+		"%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
 		__FUNCTION__,
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index bbdad09..2a86632 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -91,7 +91,7 @@ static int rs5c372_set_datetime(struct i
 	unsigned char buf[8] = { RS5C372_REG_BASE };
 
 	dev_dbg(&client->dev,
-		"%s: secs=%d, mins=%d, hours=%d ",
+		"%s: secs=%d, mins=%d, hours=%d "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
 		__FUNCTION__, tm->tm_sec, tm->tm_min, tm->tm_hour,
 		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
@@ -126,7 +126,7 @@ static int rs5c372_get_trim(struct i2c_c
 		return -EIO;
 	}
 
-	dev_dbg(&client->dev, "%s: raw trim=%x\n", __FUNCTION__, trim);
+	dev_dbg(&client->dev, "%s: raw trim=%x\n", __FUNCTION__, *trim);
 
 	if (osc)
 		*osc = (buf & RS5C372_TRIM_XSL) ? 32000 : 32768;
