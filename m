Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTFYHMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 03:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTFYHMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 03:12:08 -0400
Received: from b107155.adsl.hansenet.de ([62.109.107.155]:34440 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S262318AbTFYHMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 03:12:05 -0400
Message-ID: <3EF94E57.9070802@portrix.net>
Date: Wed, 25 Jun 2003 09:25:11 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i2c convert via686a temp_* to milli degree celsius
Content-Type: multipart/mixed;
 boundary="------------080108050003090207040404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080108050003090207040404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Forgot to send this.

This converts the i2c chip driver via686a to handle milli degree celsius 
instead of centi degree celsius. Applies for temp_input, temp_min, temp_max.

Jan




--------------080108050003090207040404
Content-Type: text/plain;
 name="via686a_convert_temp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via686a_convert_temp.patch"

diff -u linux-mm/drivers/i2c/chips/via686a.c 2.5.73-mm1/drivers/i2c/chips/via686a.c
--- linux-mm/drivers/i2c/chips/via686a.c	2003-05-31 14:15:03.000000000 +0200
+++ 2.5.73-mm1/drivers/i2c/chips/via686a.c	2003-06-24 17:18:09.000000000 +0200
@@ -494,27 +494,27 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
-	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr])*10 );
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr])*100 );
 }
 /* more like overshoot temperature */
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
-	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr])*10);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr])*100);
 }
 /* more like hysteresis temperature */
 static ssize_t show_temp_min(struct device *dev, char *buf, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
-	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr])*10);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr])*100);
 }
 static ssize_t set_temp_max(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/10;
+	int val = simple_strtol(buf, NULL, 10)/100;
 	data->temp_over[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
 	return count;
@@ -523,7 +523,7 @@
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/10;
+	int val = simple_strtol(buf, NULL, 10)/100;
 	data->temp_hyst[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr), data->temp_hyst[nr]);
 	return count;

--------------080108050003090207040404--

