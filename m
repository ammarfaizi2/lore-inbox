Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVBXKlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVBXKlH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVBXKlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:41:07 -0500
Received: from mx1.mail.ru ([194.67.23.121]:9037 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262181AbVBXKko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 05:40:44 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] sonyipi: fix sparse warnings
Date: Thu, 24 Feb 2005 13:40:37 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502241340.38002.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also convert copy_{from,to}_user() of 1 and 2 byte variables to {get,put}_user().

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Index: linux-2.6.11-rc4-bk9-warnings/drivers/char/sonypi.c
===================================================================
--- linux-2.6.11-rc4-bk9-warnings.orig/drivers/char/sonypi.c	2005-02-24 12:42:05.000000000 +0200
+++ linux-2.6.11-rc4-bk9-warnings/drivers/char/sonypi.c	2005-02-24 13:01:44.000000000 +0200
@@ -940,7 +940,8 @@ static int sonypi_misc_ioctl(struct inod
 			     unsigned int cmd, unsigned long arg)
 {
 	int ret = 0;
-	void __user *argp = (void __user *)arg;
+	u8 __user *argp8 = (u8 __user *) arg;
+	u16 __user *argp16 = (u16 __user *) arg;
 	u8 val8;
 	u16 val16;
 
@@ -951,11 +952,11 @@ static int sonypi_misc_ioctl(struct inod
 			ret = -EIO;
 			break;
 		}
-		if (copy_to_user(argp, &val8, sizeof(val8)))
+		if (put_user(val8, argp8))
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCSBRT:
-		if (copy_from_user(&val8, argp, sizeof(val8))) {
+		if (get_user(val8, argp8)) {
 			ret = -EFAULT;
 			break;
 		}
@@ -967,7 +968,7 @@ static int sonypi_misc_ioctl(struct inod
 			ret = -EIO;
 			break;
 		}
-		if (copy_to_user(argp, &val16, sizeof(val16)))
+		if (put_user(val16, argp16))
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBAT1REM:
@@ -975,7 +976,7 @@ static int sonypi_misc_ioctl(struct inod
 			ret = -EIO;
 			break;
 		}
-		if (copy_to_user(argp, &val16, sizeof(val16)))
+		if (put_user(val16, argp16))
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBAT2CAP:
@@ -983,7 +984,7 @@ static int sonypi_misc_ioctl(struct inod
 			ret = -EIO;
 			break;
 		}
-		if (copy_to_user(argp, &val16, sizeof(val16)))
+		if (put_user(val16, argp16))
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBAT2REM:
@@ -991,7 +992,7 @@ static int sonypi_misc_ioctl(struct inod
 			ret = -EIO;
 			break;
 		}
-		if (copy_to_user(argp, &val16, sizeof(val16)))
+		if (put_user(val16, argp16))
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBATFLAGS:
@@ -1000,16 +1001,16 @@ static int sonypi_misc_ioctl(struct inod
 			break;
 		}
 		val8 &= 0x07;
-		if (copy_to_user(argp, &val8, sizeof(val8)))
+		if (put_user(val8, argp8))
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBLUE:
 		val8 = sonypi_device.bluetooth_power;
-		if (copy_to_user(argp, &val8, sizeof(val8)))
+		if (put_user(val8, argp8))
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCSBLUE:
-		if (copy_from_user(&val8, argp, sizeof(val8))) {
+		if (get_user(val8, argp8)) {
 			ret = -EFAULT;
 			break;
 		}
@@ -1021,11 +1022,11 @@ static int sonypi_misc_ioctl(struct inod
 			ret = -EIO;
 			break;
 		}
-		if (copy_to_user((u8 *)arg, &val8, sizeof(val8)))
+		if (put_user(val8, argp8))
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCSFAN:
-		if (copy_from_user(&val8, (u8 *)arg, sizeof(val8))) {
+		if (get_user(val8, argp8)) {
 			ret = -EFAULT;
 			break;
 		}
@@ -1038,7 +1039,7 @@ static int sonypi_misc_ioctl(struct inod
 			ret = -EIO;
 			break;
 		}
-		if (copy_to_user((u8 *)arg, &val8, sizeof(val8)))
+		if (put_user(val8, argp8))
 			ret = -EFAULT;
 		break;
 	default:
