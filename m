Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265831AbTL3WMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbTL3WME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:12:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:62145 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265804AbTL3WGo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:44 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219753853@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:15 -0800
Message-Id: <10728219752634@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.9.8, 2003/12/04 14:26:44-08:00, khali@linux-fr.org

[PATCH] I2C: it87 and via686a alarms

> it87 and via686a violate the sysfs standard by having "alarm" instead
> of "alarms", would you please fix in your next patch?

I'm not the only one allowed to send patches to Greg, you know ;)
Anyway, here we go. Greg, here is a patch that corrects the standard
violation reported by Mark. Tested to compile.

(It also removes a useless comment in it87.c.)


 drivers/i2c/chips/it87.c    |    9 ++++-----
 drivers/i2c/chips/via686a.c |    8 ++++----
 2 files changed, 8 insertions(+), 9 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Tue Dec 30 12:31:15 2003
+++ b/drivers/i2c/chips/it87.c	Tue Dec 30 12:31:15 2003
@@ -412,7 +412,6 @@
 show_temp_offset(2);
 show_temp_offset(3);
 
-/* more like overshoot temperature */
 static ssize_t show_sensor(struct device *dev, char *buf, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -561,15 +560,15 @@
 show_fan_offset(2);
 show_fan_offset(3);
 
-/* Alarm */
-static ssize_t show_alarm(struct device *dev, char *buf)
+/* Alarms */
+static ssize_t show_alarms(struct device *dev, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	it87_update_client(client);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
 }
-static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, show_alarm, NULL);
+static DEVICE_ATTR(alarms, S_IRUGO | S_IWUSR, show_alarms, NULL);
 
 /* This function is called when:
      * it87_driver is inserted (when this module is loaded), for each
@@ -749,7 +748,7 @@
 	device_create_file(&new_client->dev, &dev_attr_fan_div1);
 	device_create_file(&new_client->dev, &dev_attr_fan_div2);
 	device_create_file(&new_client->dev, &dev_attr_fan_div3);
-	device_create_file(&new_client->dev, &dev_attr_alarm);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
 
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Tue Dec 30 12:31:15 2003
+++ b/drivers/i2c/chips/via686a.c	Tue Dec 30 12:31:15 2003
@@ -635,14 +635,14 @@
 show_fan_offset(1);
 show_fan_offset(2);
 
-/* Alarm */
-static ssize_t show_alarm(struct device *dev, char *buf) {
+/* Alarms */
+static ssize_t show_alarms(struct device *dev, char *buf) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
 }
-static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, show_alarm, NULL);
+static DEVICE_ATTR(alarms, S_IRUGO | S_IWUSR, show_alarms, NULL);
 
 /* The driver. I choose to use type i2c_driver, as at is identical to both
    smbus_driver and isa_driver, and clients could be of either kind */
@@ -767,7 +767,7 @@
 	device_create_file(&new_client->dev, &dev_attr_fan_min2);
 	device_create_file(&new_client->dev, &dev_attr_fan_div1);
 	device_create_file(&new_client->dev, &dev_attr_fan_div2);
-	device_create_file(&new_client->dev, &dev_attr_alarm);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
 

