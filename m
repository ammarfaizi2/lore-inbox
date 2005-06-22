Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbVFVHmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbVFVHmM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVFVHkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:40:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:54683 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262746AbVFVFVr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:47 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: w83781d: remove non-i2c sensor chips
In-Reply-To: <11194174683773@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:48 -0700
Message-Id: <11194174683171@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: w83781d: remove non-i2c sensor chips

This patch removes the support for the W83697HF and W83627THF chips from
the w83781d driver. These chips have no I2C/SMBus interface and are
better supported by the Super-I/O-based w83627hf driver. Documentation
was updated to reflect the support drop.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7c7a530463ced6011789937b24dc2bfba43c706b
tree 56082dfa7b18e6019c2bba32d013c945cfbf46aa
parent a45cfe2cd7450e56b4f44802b34faaf2a78a6cdb
author Jean Delvare <khali@linux-fr.org> Thu, 16 Jun 2005 19:24:14 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:07 -0700

 Documentation/i2c/chips/w83781d |   16 ++-------
 drivers/i2c/chips/w83781d.c     |   72 +++++++++++----------------------------
 2 files changed, 24 insertions(+), 64 deletions(-)

diff --git a/Documentation/i2c/chips/w83781d b/Documentation/i2c/chips/w83781d
--- a/Documentation/i2c/chips/w83781d
+++ b/Documentation/i2c/chips/w83781d
@@ -18,14 +18,6 @@ Supported chips:
     Prefix: 'w83627hf'
     Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
     Datasheet: http://www.winbond.com/PDF/sheet/w83627hf.pdf
-  * Winbond W83627THF
-    Prefix: 'w83627thf'
-    Addresses scanned: ISA address 0x290 (8 I/O ports)
-    Datasheet: http://www.winbond.com/PDF/sheet/w83627thf.pdf
-  * Winbond W83697HF
-    Prefix: 'w83697hf'
-    Addresses scanned: ISA 0x290 (8 I/O ports)
-    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/w83697hf.pdf
   * Asus AS99127F
     Prefix: 'as99127f'
     Addresses scanned: I2C 0x28 - 0x2f
@@ -53,9 +45,9 @@ force_subclients=bus,caddr,saddr,saddr
 Description
 -----------
 
-This driver implements support for the Winbond W83627HF, W83627THF, W83781D,
-W83782D, W83783S, W83697HF chips, and the Asus AS99127F chips. We will refer
-to them collectively as W8378* chips.
+This driver implements support for the Winbond W83781D, W83782D, W83783S,
+W83627HF chips, and the Asus AS99127F chips. We will refer to them
+collectively as W8378* chips.
 
 There is quite some difference between these chips, but they are similar
 enough that it was sensible to put them together in one driver.
@@ -67,10 +59,8 @@ as99127f    7       3       0       3   
 as99127f rev.2 (type_name = as99127f)       0x31    0x5ca3  yes     no
 w83781d     7       3       0       3       0x10-1  0x5ca3  yes     yes
 w83627hf    9       3       2       3       0x21    0x5ca3  yes     yes(LPC)
-w83627thf   9       3       2       3       0x90    0x5ca3  no      yes(LPC)
 w83782d     9       3       2-4     3       0x30    0x5ca3  yes     yes
 w83783s     5-6     3       2       1-2     0x40    0x5ca3  yes     no
-w83697hf    8       2       2       2       0x60    0x5ca3  no      yes(LPC)
 
 Detection of these chips can sometimes be foiled because they can be in
 an internal state that allows no clean access. If you know the address
diff --git a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c
+++ b/drivers/i2c/chips/w83781d.c
@@ -28,10 +28,8 @@
     as99127f rev.2 (type_name = as99127f)	0x31	0x5ca3	yes	no
     w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
     w83627hf	9	3	2	3	0x21	0x5ca3	yes	yes(LPC)
-    w83627thf	9	3	2	3	0x90	0x5ca3	no	yes(LPC)
     w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
     w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
-    w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
 
 */
 
@@ -52,7 +50,7 @@ static unsigned short normal_i2c[] = { 0
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_6(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf);
+SENSORS_INSMOD_5(w83781d, w83782d, w83783s, w83627hf, as99127f);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
@@ -998,13 +996,6 @@ w83781d_detect(struct i2c_adapter *adapt
 		err = -EINVAL;
 		goto ERROR0;
 	}
-	if (!is_isa && kind == w83697hf) {
-		dev_err(&adapter->dev,
-			"Cannot force ISA-only chip for I2C address 0x%02x.\n",
-			address);
-		err = -EINVAL;
-		goto ERROR0;
-	}
 	
 	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT,
@@ -1137,12 +1128,10 @@ w83781d_detect(struct i2c_adapter *adapt
 		else if (val1 == 0x40 && vendid == winbond && !is_isa
 				&& address == 0x2d)
 			kind = w83783s;
-		else if ((val1 == 0x21 || val1 == 0x90) && vendid == winbond)
+		else if (val1 == 0x21 && vendid == winbond)
 			kind = w83627hf;
 		else if (val1 == 0x31 && !is_isa && address >= 0x28)
 			kind = as99127f;
-		else if (val1 == 0x60 && vendid == winbond && is_isa)
-			kind = w83697hf;
 		else {
 			if (kind == 0)
 				dev_warn(&new_client->dev, "Ignoring 'force' "
@@ -1161,14 +1150,9 @@ w83781d_detect(struct i2c_adapter *adapt
 	} else if (kind == w83783s) {
 		client_name = "w83783s";
 	} else if (kind == w83627hf) {
-		if (val1 == 0x90)
-			client_name = "w83627thf";
-		else
-			client_name = "w83627hf";
+		client_name = "w83627hf";
 	} else if (kind == as99127f) {
 		client_name = "as99127f";
-	} else if (kind == w83697hf) {
-		client_name = "w83697hf";
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
@@ -1206,7 +1190,7 @@ w83781d_detect(struct i2c_adapter *adapt
 
 	/* Register sysfs hooks */
 	device_create_file_in(new_client, 0);
-	if (kind != w83783s && kind != w83697hf)
+	if (kind != w83783s)
 		device_create_file_in(new_client, 1);
 	device_create_file_in(new_client, 2);
 	device_create_file_in(new_client, 3);
@@ -1220,24 +1204,19 @@ w83781d_detect(struct i2c_adapter *adapt
 
 	device_create_file_fan(new_client, 1);
 	device_create_file_fan(new_client, 2);
-	if (kind != w83697hf)
-		device_create_file_fan(new_client, 3);
+	device_create_file_fan(new_client, 3);
 
 	device_create_file_temp(new_client, 1);
 	device_create_file_temp(new_client, 2);
-	if (kind != w83783s && kind != w83697hf)
+	if (kind != w83783s)
 		device_create_file_temp(new_client, 3);
 
-	if (kind != w83697hf)
-		device_create_file_vid(new_client);
-
-	if (kind != w83697hf)
-		device_create_file_vrm(new_client);
+	device_create_file_vid(new_client);
+	device_create_file_vrm(new_client);
 
 	device_create_file_fan_div(new_client, 1);
 	device_create_file_fan_div(new_client, 2);
-	if (kind != w83697hf)
-		device_create_file_fan_div(new_client, 3);
+	device_create_file_fan_div(new_client, 3);
 
 	device_create_file_alarms(new_client);
 
@@ -1256,7 +1235,7 @@ w83781d_detect(struct i2c_adapter *adapt
 	if (kind != as99127f && kind != w83781d) {
 		device_create_file_sensor(new_client, 1);
 		device_create_file_sensor(new_client, 2);
-		if (kind != w83783s && kind != w83697hf)
+		if (kind != w83783s)
 			device_create_file_sensor(new_client, 3);
 	}
 
@@ -1479,7 +1458,7 @@ w83781d_init_client(struct i2c_client *c
 				else
 					data->sens[i - 1] = 2;
 			}
-			if ((type == w83783s || type == w83697hf) && (i == 2))
+			if (type == w83783s && i == 2)
 				break;
 		}
 	}
@@ -1495,7 +1474,7 @@ w83781d_init_client(struct i2c_client *c
 		}
 
 		/* Enable temp3 */
-		if (type != w83783s && type != w83697hf) {
+		if (type != w83783s) {
 			tmp = w83781d_read_value(client,
 				W83781D_REG_TEMP3_CONFIG);
 			if (tmp & 0x01) {
@@ -1536,8 +1515,7 @@ static struct w83781d_data *w83781d_upda
 		dev_dbg(dev, "Starting device update\n");
 
 		for (i = 0; i <= 8; i++) {
-			if ((data->type == w83783s || data->type == w83697hf)
-			    && (i == 1))
+			if (data->type == w83783s && i == 1)
 				continue;	/* 783S has no in1 */
 			data->in[i] =
 			    w83781d_read_value(client, W83781D_REG_IN(i));
@@ -1545,7 +1523,7 @@ static struct w83781d_data *w83781d_upda
 			    w83781d_read_value(client, W83781D_REG_IN_MIN(i));
 			data->in_max[i] =
 			    w83781d_read_value(client, W83781D_REG_IN_MAX(i));
-			if ((data->type != w83782d) && (data->type != w83697hf)
+			if ((data->type != w83782d)
 			    && (data->type != w83627hf) && (i == 6))
 				break;
 		}
@@ -1581,7 +1559,7 @@ static struct w83781d_data *w83781d_upda
 		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(2));
 		data->temp_max_hyst_add[0] =
 		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(2));
-		if (data->type != w83783s && data->type != w83697hf) {
+		if (data->type != w83783s) {
 			data->temp_add[1] =
 			    w83781d_read_value(client, W83781D_REG_TEMP(3));
 			data->temp_max_add[1] =
@@ -1592,26 +1570,18 @@ static struct w83781d_data *w83781d_upda
 					       W83781D_REG_TEMP_HYST(3));
 		}
 		i = w83781d_read_value(client, W83781D_REG_VID_FANDIV);
-		if (data->type != w83697hf) {
-			data->vid = i & 0x0f;
-			data->vid |=
-			    (w83781d_read_value(client, W83781D_REG_CHIPID) &
-			     0x01)
-			    << 4;
-		}
+		data->vid = i & 0x0f;
+		data->vid |= (w83781d_read_value(client,
+					W83781D_REG_CHIPID) & 0x01) << 4;
 		data->fan_div[0] = (i >> 4) & 0x03;
 		data->fan_div[1] = (i >> 6) & 0x03;
-		if (data->type != w83697hf) {
-			data->fan_div[2] = (w83781d_read_value(client,
-							       W83781D_REG_PIN)
-					    >> 6) & 0x03;
-		}
+		data->fan_div[2] = (w83781d_read_value(client,
+					W83781D_REG_PIN) >> 6) & 0x03;
 		if ((data->type != w83781d) && (data->type != as99127f)) {
 			i = w83781d_read_value(client, W83781D_REG_VBAT);
 			data->fan_div[0] |= (i >> 3) & 0x04;
 			data->fan_div[1] |= (i >> 4) & 0x04;
-			if (data->type != w83697hf)
-				data->fan_div[2] |= (i >> 5) & 0x04;
+			data->fan_div[2] |= (i >> 5) & 0x04;
 		}
 		data->alarms =
 		    w83781d_read_value(client,

