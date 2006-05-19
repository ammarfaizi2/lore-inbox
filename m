Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWESHJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWESHJH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 03:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWESHJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 03:09:07 -0400
Received: from mx0.towertech.it ([213.215.222.73]:49133 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1750863AbWESHJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 03:09:06 -0400
Date: Fri, 19 May 2006 09:08:58 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
       Ingo Oeser <ioe-lkml@rameria.de>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] rtc subsystem, use ENOIOCTLCMD and ENOTTY where appropriate
Message-ID: <20060519090858.7008b79f@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Appropriately use -ENOIOCTLCMD and -ENOTTY when
the ioctl is not implemented by a driver.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

---
 drivers/rtc/rtc-dev.c    |    6 +++---
 drivers/rtc/rtc-sa1100.c |    2 +-
 drivers/rtc/rtc-test.c   |    2 +-
 drivers/rtc/rtc-vr41xx.c |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

--- linux-rtc.orig/drivers/rtc/rtc-test.c	2006-05-17 01:21:35.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-test.c	2006-05-17 01:22:39.000000000 +0200
@@ -71,7 +71,7 @@ static int test_rtc_ioctl(struct device 
 		return 0;
 
 	default:
-		return -EINVAL;
+		return -ENOIOCTLCMD;
 	}
 }
 
--- linux-rtc.orig/drivers/rtc/rtc-vr41xx.c	2006-05-17 01:21:59.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-vr41xx.c	2006-05-19 09:05:03.000000000 +0200
@@ -270,7 +270,7 @@ static int vr41xx_rtc_ioctl(struct devic
 		epoch = arg;
 		break;
 	default:
-		return -EINVAL;
+		return -ENOIOCTLCMD;
 	}
 
 	return 0;
--- linux-rtc.orig/drivers/rtc/rtc-sa1100.c	2006-05-17 01:18:19.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-sa1100.c	2006-05-19 09:05:03.000000000 +0200
@@ -247,7 +247,7 @@ static int sa1100_rtc_ioctl(struct devic
 		rtc_freq = arg;
 		return 0;
 	}
-	return -EINVAL;
+	return -ENOIOCTLCMD;
 }
 
 static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
--- linux-rtc.orig/drivers/rtc/rtc-dev.c	2006-05-17 01:18:19.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-dev.c	2006-05-19 09:06:00.000000000 +0200
@@ -141,13 +141,13 @@ static int rtc_dev_ioctl(struct inode *i
 	/* try the driver's ioctl interface */
 	if (ops->ioctl) {
 		err = ops->ioctl(class_dev->dev, cmd, arg);
-		if (err != -EINVAL)
+		if (err != -ENOIOCTLCMD)
 			return err;
 	}
 
 	/* if the driver does not provide the ioctl interface
 	 * or if that particular ioctl was not implemented
-	 * (-EINVAL), we will try to emulate here.
+	 * (-ENOIOCTLCMD), we will try to emulate here.
 	 */
 
 	switch (cmd) {
@@ -233,7 +233,7 @@ static int rtc_dev_ioctl(struct inode *i
 		break;
 
 	default:
-		err = -EINVAL;
+		err = -ENOTTY;
 		break;
 	}
 
