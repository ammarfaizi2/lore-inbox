Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261631AbTCaNT1>; Mon, 31 Mar 2003 08:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261632AbTCaNT1>; Mon, 31 Mar 2003 08:19:27 -0500
Received: from mx00.yatack.net ([193.71.32.2]:40713 "HELO mx00.yatack.net")
	by vger.kernel.org with SMTP id <S261631AbTCaNT0>;
	Mon, 31 Mar 2003 08:19:26 -0500
Message-ID: <3E884305.9070701@uw.no>
Date: Mon, 31 Mar 2003 13:30:45 +0000
From: "Daniel K." <dk@uw.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stelian Pop <stelian@popies.net>
CC: linux-kernel@vger.kernel.org
Subject: [patch] fix ec_read using wrong #define's in sonypi driver.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will make the driver use the correct #define's when
querying battery charge.

This error sneaked into 2.4.20-pre1,
and have been present in 2.5 since 2.5.49.

The patch is for 2.4.21-pre6, but will also apply to 2.5.66
with an offset of 1 line.

Please apply.

Daniel K.



--- linux-2.4.21-pre6.vanilla/drivers/char/sonypi.c	2003-03-29 17:27:22.000000000 +0000
+++ linux-2.4.21-pre6/drivers/char/sonypi.c	2003-03-30 11:44:42.000000000 +0000
@@ -531,7 +531,7 @@
  			ret = -EFAULT;
  		break;
  	case SONYPI_IOCGBAT1REM:
-		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+		if (ec_read16(SONYPI_BAT1_LEFT, &val16)) {
  			ret = -EIO;
  			break;
  		}
@@ -539,7 +539,7 @@
  			ret = -EFAULT;
  		break;
  	case SONYPI_IOCGBAT2CAP:
-		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+		if (ec_read16(SONYPI_BAT2_FULL, &val16)) {
  			ret = -EIO;
  			break;
  		}
@@ -547,7 +547,7 @@
  			ret = -EFAULT;
  		break;
  	case SONYPI_IOCGBAT2REM:
-		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+		if (ec_read16(SONYPI_BAT2_LEFT, &val16)) {
  			ret = -EIO;
  			break;
  		}

