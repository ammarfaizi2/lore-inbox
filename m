Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbTEFTnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbTEFTnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:43:31 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:12481 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261292AbTEFTmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:42:45 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 6 May 2003 21:51:54 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       Frank Davis <fdavis@si.rr.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Ronald Bultje <R.S.Bultje@pharm.uu.nl>
Subject: [patch] i2c #3/3: add class field to i2c_adapter
Message-ID: <20030506195154.GC865@bytesex.org>
References: <20030506193430.GA865@bytesex.org> <20030506194018.GB865@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506194018.GB865@bytesex.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is the last of three patches for i2c.  It introduces a new field
to i2c_adapter which classifies the kind of hardware a i2c adapter
belongs to (analog tv card / dvb card / smbus / gfx card ...).  i2c chip
drivers can use this infomation to decide whenever they want to look for
hardware on that adapter or not.  It doesn't make sense to probe for a
tv tuner on a smbus for example ...

  Gerd

diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-ali15x3.c linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-ali15x3.c
--- linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-ali15x3.c	2003-05-06 10:22:40.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-ali15x3.c	2003-05-06 16:26:13.000000000 +0200
@@ -475,6 +475,7 @@
 static struct i2c_adapter ali15x3_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI15X3,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.dev		= {
 		.name	= "unset",
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-amd756.c linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-amd756.c
--- linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-amd756.c	2003-05-06 10:23:29.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-amd756.c	2003-05-06 16:26:20.000000000 +0200
@@ -313,6 +313,7 @@
 static struct i2c_adapter amd756_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.dev		= {
 		.name	= "unset",
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-amd8111.c linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-amd8111.c
--- linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-amd8111.c	2003-05-06 10:23:28.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-amd8111.c	2003-05-06 16:26:28.000000000 +0200
@@ -360,6 +360,7 @@
 	snprintf(smbus->adapter.dev.name, DEVICE_NAME_SIZE,
 		"SMBus2 AMD8111 adapter at %04x", smbus->base);
 	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD8111;
+	smbus->adapter.class = I2C_ADAP_CLASS_SMBUS;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-i801.c linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-i801.c
--- linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-i801.c	2003-05-06 10:22:39.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-i801.c	2003-05-06 16:16:02.000000000 +0200
@@ -547,6 +547,7 @@
 static struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_I801,
+	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.dev		= {
 		.name	= "unset",
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-isa.c linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-isa.c
--- linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-isa.c	2003-05-06 10:22:56.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-isa.c	2003-05-06 16:16:32.000000000 +0200
@@ -40,6 +40,7 @@
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_ISA | I2C_HW_ISA,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &isa_algorithm,
 	.dev		= {
 		.name	= "ISA main adapter",
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-piix4.c linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-piix4.c
--- linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-piix4.c	2003-05-06 10:22:23.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-piix4.c	2003-05-06 16:17:10.000000000 +0200
@@ -395,6 +395,7 @@
 static struct i2c_adapter piix4_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_PIIX4,
+	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.dev		= {
 		.name	= "unset",
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-viapro.c linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-viapro.c
--- linux-i2c-2-2.5.69/drivers/i2c/busses/i2c-viapro.c	2003-05-06 10:23:11.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/busses/i2c-viapro.c	2003-05-06 16:17:50.000000000 +0200
@@ -295,6 +295,7 @@
 static struct i2c_adapter vt596_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_VIA2,
+	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.dev		= {
 		.name	= "unset",
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/chips/adm1021.c linux-i2c-3-2.5.69/drivers/i2c/chips/adm1021.c
--- linux-i2c-2-2.5.69/drivers/i2c/chips/adm1021.c	2003-05-06 13:34:18.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/chips/adm1021.c	2003-05-06 16:19:02.000000000 +0200
@@ -203,6 +203,8 @@
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
 	return i2c_detect(adapter, &addr_data, adm1021_detect);
 }
 
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/chips/it87.c linux-i2c-3-2.5.69/drivers/i2c/chips/it87.c
--- linux-i2c-2-2.5.69/drivers/i2c/chips/it87.c	2003-05-06 13:34:27.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/chips/it87.c	2003-05-06 16:19:19.000000000 +0200
@@ -525,6 +525,8 @@
      * when a new adapter is inserted (and it87_driver is still present) */
 static int it87_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
 	return i2c_detect(adapter, &addr_data, it87_detect);
 }
 
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/chips/lm75.c linux-i2c-3-2.5.69/drivers/i2c/chips/lm75.c
--- linux-i2c-2-2.5.69/drivers/i2c/chips/lm75.c	2003-05-06 13:34:42.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/chips/lm75.c	2003-05-06 16:19:29.000000000 +0200
@@ -121,6 +121,8 @@
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
 	return i2c_detect(adapter, &addr_data, lm75_detect);
 }
 
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/chips/via686a.c linux-i2c-3-2.5.69/drivers/i2c/chips/via686a.c
--- linux-i2c-2-2.5.69/drivers/i2c/chips/via686a.c	2003-05-06 13:34:50.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/chips/via686a.c	2003-05-06 16:19:37.000000000 +0200
@@ -661,6 +661,8 @@
 /* This is called when the module is loaded */
 static int via686a_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
 
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/i2c/chips/w83781d.c linux-i2c-3-2.5.69/drivers/i2c/chips/w83781d.c
--- linux-i2c-2-2.5.69/drivers/i2c/chips/w83781d.c	2003-05-06 13:35:02.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/i2c/chips/w83781d.c	2003-05-06 16:19:48.000000000 +0200
@@ -1026,6 +1026,8 @@
 static int
 w83781d_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
 	return i2c_detect(adapter, &addr_data, w83781d_detect);
 }
 
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/media/video/bt832.c linux-i2c-3-2.5.69/drivers/media/video/bt832.c
--- linux-i2c-2-2.5.69/drivers/media/video/bt832.c	2003-05-06 10:23:11.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/media/video/bt832.c	2003-05-06 17:21:42.000000000 +0200
@@ -198,25 +198,9 @@
 
 static int bt832_probe(struct i2c_adapter *adap)
 {
-	int rc;
-
-	printk("bt832_probe\n");
-
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
-		printk("bt832: probing %s i2c adapter [id=0x%x]\n",
-		       adap->name,adap->id);
-		rc = i2c_probe(adap, &addr_data, bt832_attach);
-		break;
-	default:
-		printk("bt832: ignoring %s i2c adapter [id=0x%x]\n",
-		       adap->name,adap->id);
-		rc = 0;
-		/* nothing */
-	}
-	return rc;
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+		return i2c_probe(adap, &addr_data, bt832_attach);
+	return 0;
 }
 
 static int bt832_detach(struct i2c_client *client)
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/media/video/bttv-if.c linux-i2c-3-2.5.69/drivers/media/video/bttv-if.c
--- linux-i2c-2-2.5.69/drivers/media/video/bttv-if.c	2003-05-06 16:57:13.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/media/video/bttv-if.c	2003-05-06 17:54:00.000000000 +0200
@@ -233,6 +233,7 @@
 	.owner             = THIS_MODULE,
 	I2C_DEVNAME("bt848"),
 	.id                = I2C_HW_B_BT848,
+	.class             = I2C_ADAP_CLASS_TV_ANALOG,
 	.client_register   = attach_inform,
 };
 
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/media/video/msp3400.c linux-i2c-3-2.5.69/drivers/media/video/msp3400.c
--- linux-i2c-2-2.5.69/drivers/media/video/msp3400.c	2003-05-06 13:33:40.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/media/video/msp3400.c	2003-05-06 17:21:50.000000000 +0200
@@ -1372,7 +1372,7 @@
 
 static int msp_probe(struct i2c_adapter *adap)
 {
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, msp_attach);
 	return 0;
 }
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/media/video/saa5249.c linux-i2c-3-2.5.69/drivers/media/video/saa5249.c
--- linux-i2c-2-2.5.69/drivers/media/video/saa5249.c	2003-05-06 10:23:11.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/media/video/saa5249.c	2003-05-06 17:21:57.000000000 +0200
@@ -224,12 +224,8 @@
  
 static int saa5249_probe(struct i2c_adapter *adap)
 {
-	/* Only attach these chips to the BT848 bus for now */
-	
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
-	{
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, saa5249_attach);
-	}
 	return 0;
 }
 
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/media/video/saa7134/saa7134-i2c.c linux-i2c-3-2.5.69/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-i2c-2-2.5.69/drivers/media/video/saa7134/saa7134-i2c.c	2003-05-06 16:51:55.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/media/video/saa7134/saa7134-i2c.c	2003-05-06 17:54:33.000000000 +0200
@@ -336,6 +336,7 @@
 	.owner         = THIS_MODULE,
 	I2C_DEVNAME("saa7134"),
 	.id            = I2C_ALGO_SAA7134,
+	.class         = I2C_ADAP_CLASS_TV_ANALOG,
 	.algo          = &saa7134_algo,
 	.client_register = attach_inform,
 };
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/media/video/tda7432.c linux-i2c-3-2.5.69/drivers/media/video/tda7432.c
--- linux-i2c-2-2.5.69/drivers/media/video/tda7432.c	2003-05-06 13:33:24.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/media/video/tda7432.c	2003-05-06 17:22:02.000000000 +0200
@@ -340,7 +340,7 @@
 
 static int tda7432_probe(struct i2c_adapter *adap)
 {
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda7432_attach);
 	return 0;
 }
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/media/video/tda9875.c linux-i2c-3-2.5.69/drivers/media/video/tda9875.c
--- linux-i2c-2-2.5.69/drivers/media/video/tda9875.c	2003-05-06 13:33:14.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/media/video/tda9875.c	2003-05-06 17:22:08.000000000 +0200
@@ -273,7 +273,7 @@
 
 static int tda9875_probe(struct i2c_adapter *adap)
 {
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda9875_attach);
 	return 0;
 }
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/media/video/tda9887.c linux-i2c-3-2.5.69/drivers/media/video/tda9887.c
--- linux-i2c-2-2.5.69/drivers/media/video/tda9887.c	2003-05-06 10:21:50.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/media/video/tda9887.c	2003-05-06 17:22:15.000000000 +0200
@@ -368,23 +368,9 @@
 
 static int tda9887_probe(struct i2c_adapter *adap)
 {
-	int rc;
-
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
-		printk("tda9887: probing %s i2c adapter [id=0x%x]\n",
-		       adap->dev.name,adap->id);
-		rc = i2c_probe(adap, &addr_data, tda9887_attach);
-		break;
-	default:
-		printk("tda9887: ignoring %s i2c adapter [id=0x%x]\n",
-		       adap->dev.name,adap->id);
-		rc = 0;
-		/* nothing */
-	}
-	return rc;
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+		return i2c_probe(adap, &addr_data, tda9887_attach);
+	return 0;
 }
 
 static int tda9887_detach(struct i2c_client *client)
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/media/video/tuner.c linux-i2c-3-2.5.69/drivers/media/video/tuner.c
--- linux-i2c-2-2.5.69/drivers/media/video/tuner.c	2003-05-06 13:31:03.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/media/video/tuner.c	2003-05-06 17:22:22.000000000 +0200
@@ -817,29 +817,15 @@
 
 static int tuner_probe(struct i2c_adapter *adap)
 {
-	int rc;
-
 	if (0 != addr) {
 		normal_i2c_range[0] = addr;
 		normal_i2c_range[1] = addr;
 	}
 	this_adap = 0;
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
-	case I2C_ALGO_SAA7146:
-		printk("tuner: probing %s i2c adapter [id=0x%x]\n",
-		       adap->dev.name,adap->id);
-		rc = i2c_probe(adap, &addr_data, tuner_attach);
-		break;
-	default:
-		printk("tuner: ignoring %s i2c adapter [id=0x%x]\n",
-		       adap->dev.name,adap->id);
-		rc = 0;
-		/* nothing */
-	}
-	return rc;
+
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+		return i2c_probe(adap, &addr_data, tuner_attach);
+	return 0;
 }
 
 static int tuner_detach(struct i2c_client *client)
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/media/video/tvaudio.c linux-i2c-3-2.5.69/drivers/media/video/tvaudio.c
--- linux-i2c-2-2.5.69/drivers/media/video/tvaudio.c	2003-05-06 13:33:33.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/media/video/tvaudio.c	2003-05-06 17:22:29.000000000 +0200
@@ -1408,14 +1408,9 @@
 
 static int chip_probe(struct i2c_adapter *adap)
 {
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, chip_attach);
-	default:
-		/* ignore this i2c bus */
-		return 0;
-	}
+	return 0;
 }
 
 static int chip_detach(struct i2c_client *client)
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/drivers/media/video/tvmixer.c linux-i2c-3-2.5.69/drivers/media/video/tvmixer.c
--- linux-i2c-2-2.5.69/drivers/media/video/tvmixer.c	2003-05-06 13:49:59.000000000 +0200
+++ linux-i2c-3-2.5.69/drivers/media/video/tvmixer.c	2003-05-06 17:28:37.000000000 +0200
@@ -254,12 +254,7 @@
 	int i,minor;
 
 	/* TV card ??? */
-	switch (client->adapter->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-		/* ok, have a look ... */
-		break;
-	default:
+	if (!(client->adapter->class & I2C_ADAP_CLASS_TV_ANALOG)) {
 		/* ignore that one */
 		if (debug)
 			printk("tvmixer: %s is not a tv card\n",
diff -urN -X /home/kraxel/.kdontdiff linux-i2c-2-2.5.69/include/linux/i2c.h linux-i2c-3-2.5.69/include/linux/i2c.h
--- linux-i2c-2-2.5.69/include/linux/i2c.h	2003-05-06 14:03:04.000000000 +0200
+++ linux-i2c-3-2.5.69/include/linux/i2c.h	2003-05-06 16:07:50.000000000 +0200
@@ -225,6 +225,7 @@
 	struct module *owner;
 	unsigned int id;/* == is algo->id | hwdep.struct->id, 		*/
 			/* for registered values see below		*/
+	unsigned int class;
 	struct i2c_algorithm *algo;/* the algorithm to access the bus	*/
 	void *algo_data;
 
@@ -278,6 +279,12 @@
 #define I2C_CLIENT_TEN	0x10			/* we have a ten bit chip address	*/
 						/* Must equal I2C_M_TEN below */
 
+/* i2c adapter classes (bitmask) */
+#define I2C_ADAP_CLASS_SMBUS      (1<<0)        /* lm_sensors, ... */
+#define I2C_ADAP_CLASS_TV_ANALOG  (1<<1)        /* bttv + friends */
+#define I2C_ADAP_CLASS_TV_DIGINAL (1<<2)        /* dbv cards */
+#define I2C_ADAP_CLASS_DDC        (1<<3)        /* i2c-matroxfb ? */
+
 /* i2c_client_address_data is the struct for holding default client
  * addresses for a driver and for the parameters supplied on the
  * command line
