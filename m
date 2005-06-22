Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVFVFno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVFVFno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVFVFkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:40:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:55452 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262815AbVFVFWT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:19 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: pcf8574 driver cleanup
In-Reply-To: <1119417467970@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:47 -0700
Message-Id: <11194174673876@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: pcf8574 driver cleanup

I found a possible cleanup in the pcf8574 driver. We don't need to store
the read value in our private data structure, as we then never use it
again. I asked Aurelien and he is fine with the change. Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit eb071cbbc38efa4b1d707f540de2ec6283ab0894
tree dd9037caf6acb546abe76f76d60987b8d870a1e4
parent 5d740fe9fefda41292b5cabe70f4f8eff9f8aad0
author Jean Delvare <khali@linux-fr.org> Sat, 04 Jun 2005 13:17:43 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:03 -0700

 drivers/i2c/chips/pcf8574.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
--- a/drivers/i2c/chips/pcf8574.c
+++ b/drivers/i2c/chips/pcf8574.c
@@ -57,7 +57,7 @@ SENSORS_INSMOD_2(pcf8574, pcf8574a);
 struct pcf8574_data {
 	struct i2c_client client;
 
-	u8 read, write;			/* Register values */
+	u8 write;			/* Remember last written value */
 };
 
 static int pcf8574_attach_adapter(struct i2c_adapter *adapter);
@@ -79,9 +79,7 @@ static struct i2c_driver pcf8574_driver 
 static ssize_t show_read(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct pcf8574_data *data = i2c_get_clientdata(client);
-	data->read = i2c_smbus_read_byte(client); 
-	return sprintf(buf, "%u\n", data->read);
+	return sprintf(buf, "%u\n", i2c_smbus_read_byte(client));
 }
 
 static DEVICE_ATTR(read, S_IRUGO, show_read, NULL);

