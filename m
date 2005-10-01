Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVJAH0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVJAH0a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVJAH0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:26:30 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:55940 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750768AbVJAH03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:26:29 -0400
Date: Sat, 1 Oct 2005 00:26:30 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [HWMON] kmalloc + memset -> kzalloc conversion
Message-ID: <20051001072630.GJ25424@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -204,11 +204,10 @@ static int adm1021_detect(struct i2c_ada
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access adm1021_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto error0;
 	}
-	memset(data, 0, sizeof(struct adm1021_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -331,11 +331,10 @@ static int adm1025_detect(struct i2c_ada
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct adm1025_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct adm1025_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct adm1025_data));
 
 	/* The common I2C client data is placed right before the
 	   ADM1025-specific data. */
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -1470,13 +1470,11 @@ int adm1026_detect(struct i2c_adapter *a
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access adm1026_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct adm1026_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct adm1026_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
 
-	memset(data, 0, sizeof(struct adm1026_data));
-
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -740,11 +740,10 @@ static int adm1031_detect(struct i2c_ada
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct adm1031_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct adm1031_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct adm1031_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -513,11 +513,10 @@ static int adm9240_detect(struct i2c_ada
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct adm9240_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct adm9240_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct adm9240_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -629,19 +629,17 @@ static int asb100_detect_subclients(stru
 	int i, id, err;
 	struct asb100_data *data = i2c_get_clientdata(new_client);
 
-	data->lm75[0] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	data->lm75[0] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!(data->lm75[0])) {
 		err = -ENOMEM;
 		goto ERROR_SC_0;
 	}
-	memset(data->lm75[0], 0x00, sizeof(struct i2c_client));
 
-	data->lm75[1] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	data->lm75[1] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!(data->lm75[1])) {
 		err = -ENOMEM;
 		goto ERROR_SC_1;
 	}
-	memset(data->lm75[1], 0x00, sizeof(struct i2c_client));
 
 	id = i2c_adapter_id(adapter);
 
@@ -724,12 +722,11 @@ static int asb100_detect(struct i2c_adap
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access asb100_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct asb100_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct asb100_data), GFP_KERNEL))) {
 		pr_debug("asb100.o: detect failed, kmalloc failed!\n");
 		err = -ENOMEM;
 		goto ERROR0;
 	}
-	memset(data, 0, sizeof(struct asb100_data));
 
 	new_client = &data->client;
 	init_MUTEX(&data->lock);
diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -266,12 +266,11 @@ static int atxp1_detect(struct i2c_adapt
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct atxp1_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct atxp1_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
 
-	memset(data, 0, sizeof(struct atxp1_data));
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -200,11 +200,10 @@ int ds1621_detect(struct i2c_adapter *ad
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access ds1621_{read,write}_value. */
-	if (!(data = kmalloc(sizeof(struct ds1621_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct ds1621_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct ds1621_data));
 	
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -303,11 +303,10 @@ static int fscher_detect(struct i2c_adap
 	/* OK. For now, we presume we have a valid client. We now create the
 	 * client structure, even though we cannot fill it completely yet.
 	 * But it allows us to access i2c_smbus_read_byte_data. */
-	if (!(data = kmalloc(sizeof(struct fscher_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct fscher_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
   	}
-	memset(data, 0, sizeof(struct fscher_data));
 
 	/* The common I2C client data is placed right before the
 	 * Hermes-specific data. */
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -453,11 +453,10 @@ int fscpos_detect(struct i2c_adapter *ad
 	 * But it allows us to access fscpos_{read,write}_value.
 	 */
 
-	if (!(data = kmalloc(sizeof(struct fscpos_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct fscpos_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct fscpos_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -365,11 +365,10 @@ static int gl518_detect(struct i2c_adapt
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access gl518_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct gl518_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct gl518_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct gl518_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -536,11 +536,10 @@ static int gl520_detect(struct i2c_adapt
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access gl520_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct gl520_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct gl520_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct gl520_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -788,11 +788,10 @@ int it87_detect(struct i2c_adapter *adap
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access it87_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct it87_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct it87_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(data, 0, sizeof(struct it87_data));
 
 	new_client = &data->client;
 	if (is_isa)
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -375,11 +375,10 @@ static int lm63_detect(struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct lm63_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm63_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm63_data));
 
 	/* The common I2C client data is placed right before the
 	   LM63-specific data. */
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -127,11 +127,10 @@ static int lm75_detect(struct i2c_adapte
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm75_{read,write}_value. */
-	if (!(data = kmalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm75_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -226,11 +226,10 @@ static int lm77_detect(struct i2c_adapte
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm77_{read,write}_value. */
-	if (!(data = kmalloc(sizeof(struct lm77_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm77_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm77_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -540,11 +540,10 @@ int lm78_detect(struct i2c_adapter *adap
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm78_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct lm78_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm78_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(data, 0, sizeof(struct lm78_data));
 
 	new_client = &data->client;
 	if (is_isa)
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -407,11 +407,10 @@ int lm80_detect(struct i2c_adapter *adap
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm80_{read,write}_value. */
-	if (!(data = kmalloc(sizeof(struct lm80_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm80_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm80_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -230,11 +230,10 @@ static int lm83_detect(struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct lm83_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm83_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm83_data));
 
 	/* The common I2C client data is placed right after the
 	 * LM83-specific data. */
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1033,11 +1033,10 @@ int lm85_detect(struct i2c_adapter *adap
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm85_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct lm85_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm85_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
 	}
-	memset(data, 0, sizeof(struct lm85_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -554,11 +554,10 @@ static int lm87_detect(struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct lm87_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm87_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm87_data));
 
 	/* The common I2C client data is placed right before the
 	   LM87-specific data. */
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -370,11 +370,10 @@ static int lm90_detect(struct i2c_adapte
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct lm90_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm90_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm90_data));
 
 	/* The common I2C client data is placed right before the
 	   LM90-specific data. */
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -300,11 +300,10 @@ static int lm92_detect(struct i2c_adapte
 					    | I2C_FUNC_SMBUS_WORD_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct lm92_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm92_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm92_data));
 
 	/* Fill in enough client fields so that we can read from the chip,
 	   which is required for identication */
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -197,11 +197,10 @@ static int max1619_detect(struct i2c_ada
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct max1619_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct max1619_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct max1619_data));
 
 	/* The common I2C client data is placed right before the
 	   MAX1619-specific data. */
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -754,9 +754,8 @@ static int pc87360_detect(struct i2c_ada
 	const char *name = "pc87360";
 	int use_thermistors = 0;
 
-	if (!(data = kmalloc(sizeof(struct pc87360_data), GFP_KERNEL)))
+	if (!(data = kzalloc(sizeof(struct pc87360_data), GFP_KERNEL)))
 		return -ENOMEM;
-	memset(data, 0x00, sizeof(struct pc87360_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -518,11 +518,10 @@ static int sis5595_detect(struct i2c_ada
 			goto exit_release;
 	}
 
-	if (!(data = kmalloc(sizeof(struct sis5595_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct sis5595_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit_release;
 	}
-	memset(data, 0, sizeof(struct sis5595_data));
 
 	new_client = &data->client;
 	new_client->addr = address;
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -244,11 +244,10 @@ static int smsc47b397_detect(struct i2c_
 		return -EBUSY;
 	}
 
-	if (!(data = kmalloc(sizeof(struct smsc47b397_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct smsc47b397_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto error_release;
 	}
-	memset(data, 0x00, sizeof(struct smsc47b397_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -396,11 +396,10 @@ static int smsc47m1_detect(struct i2c_ad
 		return -EBUSY;
 	}
 
-	if (!(data = kmalloc(sizeof(struct smsc47m1_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct smsc47m1_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto error_release;
 	}
-	memset(data, 0x00, sizeof(struct smsc47m1_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -617,11 +617,10 @@ static int via686a_detect(struct i2c_ada
 		return -ENODEV;
 	}
 
-	if (!(data = kmalloc(sizeof(struct via686a_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct via686a_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit_release;
 	}
-	memset(data, 0, sizeof(struct via686a_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -678,11 +678,10 @@ static int w83627ehf_detect(struct i2c_a
 		goto exit;
 	}
 
-	if (!(data = kmalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit_release;
 	}
-	memset(data, 0, sizeof(struct w83627ehf_data));
 
 	client = &data->client;
 	i2c_set_clientdata(client, data);
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1041,11 +1041,10 @@ static int w83627hf_detect(struct i2c_ad
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access w83627hf_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct w83627hf_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct w83627hf_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(data, 0, sizeof(struct w83627hf_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -889,12 +889,11 @@ w83781d_detect_subclients(struct i2c_ada
 	const char *client_name = "";
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
 
-	data->lm75[0] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	data->lm75[0] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!(data->lm75[0])) {
 		err = -ENOMEM;
 		goto ERROR_SC_0;
 	}
-	memset(data->lm75[0], 0x00, sizeof (struct i2c_client));
 
 	id = i2c_adapter_id(adapter);
 
@@ -920,12 +919,11 @@ w83781d_detect_subclients(struct i2c_ada
 
 	if (kind != w83783s) {
 
-		data->lm75[1] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+		data->lm75[1] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 		if (!(data->lm75[1])) {
 			err = -ENOMEM;
 			goto ERROR_SC_1;
 		}
-		memset(data->lm75[1], 0x0, sizeof(struct i2c_client));
 
 		if (force_subclients[0] == id &&
 		    force_subclients[1] == address) {
@@ -1064,11 +1062,10 @@ w83781d_detect(struct i2c_adapter *adapt
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access w83781d_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct w83781d_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct w83781d_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(data, 0, sizeof(struct w83781d_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -1086,11 +1086,10 @@ w83792d_create_subclient(struct i2c_adap
 	int err;
 	struct i2c_client *sub_client;
 
-	(*sub_cli) = sub_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	(*sub_cli) = sub_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!(sub_client)) {
 		return -ENOMEM;
 	}
-	memset(sub_client, 0x00, sizeof(struct i2c_client));
 	sub_client->addr = 0x48 + addr;
 	i2c_set_clientdata(sub_client, NULL);
 	sub_client->adapter = adapter;
@@ -1184,11 +1183,10 @@ w83792d_detect(struct i2c_adapter *adapt
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access w83792d_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct w83792d_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct w83792d_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
 	}
-	memset(data, 0, sizeof(struct w83792d_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -158,12 +158,10 @@ static int w83l785ts_detect(struct i2c_a
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct w83l785ts_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct w83l785ts_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct w83l785ts_data));
-
 
 	/* The common I2C client data is placed right before the
 	 * W83L785TS-specific data. */
-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
