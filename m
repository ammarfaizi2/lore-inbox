Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUDNXKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUDNWeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:34:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:27039 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261914AbUDNWYa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:24:30 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814531232@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:13 -0700
Message-Id: <1081981453446@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.26, 2004/04/12 15:16:36-07:00, khali@linux-fr.org

[PATCH] I2C: make I2C chip drivers return -EINVAL on error


 drivers/i2c/chips/fscher.c  |    2 +-
 drivers/i2c/chips/it87.c    |    2 +-
 drivers/i2c/chips/pcf8591.c |    3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	Wed Apr 14 15:12:39 2004
+++ b/drivers/i2c/chips/fscher.c	Wed Apr 14 15:12:39 2004
@@ -512,7 +512,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			 "supported. Choose one of 2, 4 or 8!\n", v);
-		return -1;
+		return -EINVAL;
 	}
 
 	/* bits 2..7 reserved => mask with 0x03 */
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Wed Apr 14 15:12:39 2004
+++ b/drivers/i2c/chips/it87.c	Wed Apr 14 15:12:39 2004
@@ -367,7 +367,7 @@
 	else if (val == 2)
 	    data->sensor |= 8 << nr;
 	else if (val != 0)
-		return -1;
+		return -EINVAL;
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
 	return count;
 }
diff -Nru a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c	Wed Apr 14 15:12:39 2004
+++ b/drivers/i2c/chips/pcf8591.c	Wed Apr 14 15:12:39 2004
@@ -129,8 +129,9 @@
 	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255) {
 		data->aout = value;
 		i2c_smbus_write_byte_data(client, data->control, data->aout);
+		return count;
 	}
-	return count;
+	return -EINVAL;
 }
 
 static DEVICE_ATTR(out0_output, S_IWUSR | S_IRUGO, 

