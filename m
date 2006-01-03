Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWACOsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWACOsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWACOsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:48:37 -0500
Received: from alpha.uhasselt.be ([193.190.2.30]:12819 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S932387AbWACOsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:48:36 -0500
To: torvalds@osdl.org
Subject: [PATCH] saa71xx: kzalloc conversion
Cc: linux-kernel@vger.kernel.org
Reply-To: takis@issaris.org
Message-Id: <20060103144831.560A75BC3@localhost.localdomain>
Date: Tue,  3 Jan 2006 15:48:31 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

Conversion of kmalloc+memset to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 drivers/media/video/saa7110.c |    6 ++----
 drivers/media/video/saa7111.c |    6 ++----
 drivers/media/video/saa7114.c |    6 ++----
 drivers/media/video/saa7115.c |    6 ++----
 drivers/media/video/saa711x.c |    6 ++----
 drivers/media/video/saa7127.c |    6 ++----
 drivers/media/video/saa7185.c |    6 ++----
 drivers/media/video/saa7191.c |    7 ++-----
 8 files changed, 16 insertions(+), 33 deletions(-)

de8e11196acfc22ce3a6cfea992d8fa1f6ed6077
diff --git a/drivers/media/video/saa7110.c b/drivers/media/video/saa7110.c
index e116bdb..93270e5 100644
--- a/drivers/media/video/saa7110.c
+++ b/drivers/media/video/saa7110.c
@@ -494,22 +494,20 @@ saa7110_detect_client (struct i2c_adapte
 	     I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7110;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7110", sizeof(I2C_NAME(client)));
 
-	decoder = kmalloc(sizeof(struct saa7110), GFP_KERNEL);
+	decoder = kzalloc(sizeof(struct saa7110), GFP_KERNEL);
 	if (decoder == 0) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(decoder, 0, sizeof(struct saa7110));
 	decoder->norm = VIDEO_MODE_PAL;
 	decoder->input = 0;
 	decoder->enable = 1;
diff --git a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
index fe8a5e4..a01ce4b 100644
--- a/drivers/media/video/saa7111.c
+++ b/drivers/media/video/saa7111.c
@@ -511,22 +511,20 @@ saa7111_detect_client (struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7111;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7111", sizeof(I2C_NAME(client)));
 
-	decoder = kmalloc(sizeof(struct saa7111), GFP_KERNEL);
+	decoder = kzalloc(sizeof(struct saa7111), GFP_KERNEL);
 	if (decoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(decoder, 0, sizeof(struct saa7111));
 	decoder->norm = VIDEO_MODE_NTSC;
 	decoder->input = 0;
 	decoder->enable = 1;
diff --git a/drivers/media/video/saa7114.c b/drivers/media/video/saa7114.c
index d9f50e2..a1b1bcf 100644
--- a/drivers/media/video/saa7114.c
+++ b/drivers/media/video/saa7114.c
@@ -852,22 +852,20 @@ saa7114_detect_client (struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7114;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7114", sizeof(I2C_NAME(client)));
 
-	decoder = kmalloc(sizeof(struct saa7114), GFP_KERNEL);
+	decoder = kzalloc(sizeof(struct saa7114), GFP_KERNEL);
 	if (decoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(decoder, 0, sizeof(struct saa7114));
 	decoder->norm = VIDEO_MODE_NTSC;
 	decoder->input = -1;
 	decoder->enable = 1;
diff --git a/drivers/media/video/saa7115.c b/drivers/media/video/saa7115.c
index e717e30..c163710 100644
--- a/drivers/media/video/saa7115.c
+++ b/drivers/media/video/saa7115.c
@@ -1263,10 +1263,9 @@ static int saa7115_attach(struct i2c_ada
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7115;
@@ -1287,13 +1286,12 @@ static int saa7115_attach(struct i2c_ada
 	}
 	saa7115_info("saa711%d found @ 0x%x (%s)\n", chip_id, address << 1, adapter->name);
 
-	state = kmalloc(sizeof(struct saa7115_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct saa7115_state), GFP_KERNEL);
 	i2c_set_clientdata(client, state);
 	if (state == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(state, 0, sizeof(struct saa7115_state));
 	state->std = V4L2_STD_NTSC;
 	state->input = -1;
 	state->enable = 1;
diff --git a/drivers/media/video/saa711x.c b/drivers/media/video/saa711x.c
index 31f7b95..f0f5fb5 100644
--- a/drivers/media/video/saa711x.c
+++ b/drivers/media/video/saa711x.c
@@ -487,21 +487,19 @@ saa711x_detect_client (struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa711x;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa711x", sizeof(I2C_NAME(client)));
-	decoder = kmalloc(sizeof(struct saa711x), GFP_KERNEL);
+	decoder = kzalloc(sizeof(struct saa711x), GFP_KERNEL);
 	if (decoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(decoder, 0, sizeof(struct saa711x));
 	decoder->norm = VIDEO_MODE_NTSC;
 	decoder->input = 0;
 	decoder->enable = 1;
diff --git a/drivers/media/video/saa7127.c b/drivers/media/video/saa7127.c
index c36f014..3baf9f8 100644
--- a/drivers/media/video/saa7127.c
+++ b/drivers/media/video/saa7127.c
@@ -711,11 +711,10 @@ static int saa7127_attach(struct i2c_ada
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
 
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7127;
@@ -735,7 +734,7 @@ static int saa7127_attach(struct i2c_ada
 		kfree(client);
 		return 0;
 	}
-	state = kmalloc(sizeof(struct saa7127_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct saa7127_state), GFP_KERNEL);
 
 	if (state == NULL) {
 		kfree(client);
@@ -743,7 +742,6 @@ static int saa7127_attach(struct i2c_ada
 	}
 
 	i2c_set_clientdata(client, state);
-	memset(state, 0, sizeof(struct saa7127_state));
 
 	/* Configure Encoder */
 
diff --git a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
index 132aa79..7ac4adc 100644
--- a/drivers/media/video/saa7185.c
+++ b/drivers/media/video/saa7185.c
@@ -408,22 +408,20 @@ saa7185_detect_client (struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver_saa7185;
 	client->flags = I2C_CLIENT_ALLOW_USE;
 	strlcpy(I2C_NAME(client), "saa7185", sizeof(I2C_NAME(client)));
 
-	encoder = kmalloc(sizeof(struct saa7185), GFP_KERNEL);
+	encoder = kzalloc(sizeof(struct saa7185), GFP_KERNEL);
 	if (encoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
-	memset(encoder, 0, sizeof(struct saa7185));
 	encoder->norm = VIDEO_MODE_NTSC;
 	encoder->enable = 1;
 	i2c_set_clientdata(client, encoder);
diff --git a/drivers/media/video/saa7191.c b/drivers/media/video/saa7191.c
index cbca896..ba4c26e 100644
--- a/drivers/media/video/saa7191.c
+++ b/drivers/media/video/saa7191.c
@@ -571,18 +571,15 @@ static int saa7191_attach(struct i2c_ada
 	printk(KERN_INFO "Philips SAA7191 driver version %s\n",
 	       SAA7191_MODULE_VERSION);
 
-	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
-	decoder = kmalloc(sizeof(*decoder), GFP_KERNEL);
+	decoder = kzalloc(sizeof(*decoder), GFP_KERNEL);
 	if (!decoder) {
 		err = -ENOMEM;
 		goto out_free_client;
 	}
 
-	memset(client, 0, sizeof(struct i2c_client));
-	memset(decoder, 0, sizeof(struct saa7191));
-
 	client->addr = addr;
 	client->adapter = adap;
 	client->driver = &i2c_driver_saa7191;
-- 
0.99.9.GIT
