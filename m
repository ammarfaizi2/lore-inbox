Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbTD1Mmn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTD1Mmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:42:43 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:13065 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S263549AbTD1MmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:42:20 -0400
Date: Mon, 28 Apr 2003 07:54:27 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initializers for drivers/media
Message-ID: <20030428125426.GB14394@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here is a set of patches for files in drivers/media that convert the
files to use C99 initializers. The patches are against the current BK.

Art Haas

===== drivers/media/dvb/frontends/alps_bsrv2.c 1.4 vs edited =====
--- 1.4/drivers/media/dvb/frontends/alps_bsrv2.c	Mon Apr  7 15:20:02 2003
+++ edited/drivers/media/dvb/frontends/alps_bsrv2.c	Sun Apr 27 21:10:26 2003
@@ -31,20 +31,21 @@
 
 static
 struct dvb_frontend_info bsrv2_info = {
-	name: "Alps BSRV2",
-	type: FE_QPSK,
-	frequency_min: 950000,
-	frequency_max: 2150000,
-	frequency_stepsize: 250,           /* kHz for QPSK frontends */
-	frequency_tolerance: 29500,
-	symbol_rate_min: 1000000,
-	symbol_rate_max: 45000000,
-/*      symbol_rate_tolerance: ???,*/
-	notifier_delay: 50,                /* 1/20 s */
-	caps:   FE_CAN_INVERSION_AUTO |
-		FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
-		FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
-		FE_CAN_QPSK
+	.name			= "Alps BSRV2",
+	.type			= FE_QPSK,
+	.frequency_min		= 950000,
+	.frequency_max		= 2150000,
+	.frequency_stepsize	= 250,  /* kHz for QPSK frontends */
+	.frequency_tolerance	= 29500,
+	.symbol_rate_min	= 1000000,
+	.symbol_rate_max	= 45000000,
+/*      .symbol_rate_tolerance	= ???,*/
+	.notifier_delay		= 50, /* 1/20 s */
+	.caps			= FE_CAN_INVERSION_AUTO |
+				  FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 |
+				  FE_CAN_FEC_3_4 | FE_CAN_FEC_5_6 |
+				  FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+				  FE_CAN_QPSK,
 };
 
 
@@ -75,7 +76,12 @@
 int ves1893_writereg (struct dvb_i2c_bus *i2c, u8 reg, u8 data)
 {
         u8 buf [] = { 0x00, reg, data };
-	struct i2c_msg msg = { addr: 0x08, flags: 0, buf: buf, len: 3 };
+	struct i2c_msg msg = {
+		.addr	= 0x08,
+		.flags	= 0,
+		.buf	= buf,
+		.len	= 3,
+	};
 	int err;
 
         if ((err = i2c->xfer (i2c, &msg, 1)) != 1) {
@@ -93,8 +99,20 @@
 	int ret;
 	u8 b0 [] = { 0x00, reg };
 	u8 b1 [] = { 0 };
-	struct i2c_msg msg [] = { { addr: 0x08, flags: 0, buf: b0, len: 2 },
-			   { addr: 0x08, flags: I2C_M_RD, buf: b1, len: 1 } };
+	struct i2c_msg msg [] = {
+		{
+			.addr	= 0x08,
+			.flags	= 0,
+			.buf	= b0,
+			.len	= 2,
+		},
+		{
+			.addr	= 0x08,
+			.flags	= I2C_M_RD,
+			.buf	= b1,
+			.len	= 1,
+		},
+	};
 
 	ret = i2c->xfer (i2c, msg, 2);
 
@@ -109,7 +127,12 @@
 int sp5659_write (struct dvb_i2c_bus *i2c, u8 data [4])
 {
         int ret;
-        struct i2c_msg msg = { addr: 0x61, flags: 0, buf: data, len: 4 };
+        struct i2c_msg msg = {
+		.addr	= 0x61,
+		.flags	= 0,
+		.buf	= data,
+		.len	= 4,
+	};
 
         ret = i2c->xfer (i2c, &msg, 1);
 
===== drivers/media/dvb/frontends/alps_tdlb7.c 1.3 vs edited =====
--- 1.3/drivers/media/dvb/frontends/alps_tdlb7.c	Mon Apr  7 15:20:02 2003
+++ edited/drivers/media/dvb/frontends/alps_tdlb7.c	Sun Apr 27 21:15:17 2003
@@ -72,21 +72,22 @@
 
 static
 struct dvb_frontend_info tdlb7_info = {
-	name: "Alps TDLB7",
-	type: FE_OFDM,
-	frequency_min: 470000000,
-	frequency_max: 860000000,
-	frequency_stepsize: 166666,
+	.name			= "Alps TDLB7",
+	.type			= FE_OFDM,
+	.frequency_min		= 470000000,
+	.frequency_max		= 860000000,
+	.frequency_stepsize	= 166666,
 #if 0
-    	frequency_tolerance: ???,
-	symbol_rate_min: ???,
-	symbol_rate_max: ???,
-	symbol_rate_tolerance: ???,
-	notifier_delay: 0,
+    	.frequency_tolerance	= ???,
+	.symbol_rate_min	= ???,
+	.symbol_rate_max	= ???,
+	.symbol_rate_tolerance	= ???,
+	.notifier_delay		= 0,
 #endif
-	caps: FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
-	      FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
-	      FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64
+	.caps			= FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 |
+				  FE_CAN_FEC_3_4 | FE_CAN_FEC_5_6 |
+				  FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+				  FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64,
 };
 
 
@@ -94,7 +95,12 @@
 int sp8870_writereg (struct dvb_i2c_bus *i2c, u16 reg, u16 data)
 {
         u8 buf [] = { reg >> 8, reg & 0xff, data >> 8, data & 0xff };
-	struct i2c_msg msg = { addr: 0x71, flags: 0, buf: buf, len: 4 };
+	struct i2c_msg msg = {
+		.addr	= 0x71,
+		.flags	= 0,
+		.buf	= buf,
+		.len	= 4,
+	};
 	int err;
 
         if ((err = i2c->xfer (i2c, &msg, 1)) != 1) {
@@ -112,8 +118,20 @@
 	int ret;
 	u8 b0 [] = { reg >> 8 , reg & 0xff };
 	u8 b1 [] = { 0, 0 };
-	struct i2c_msg msg [] = { { addr: 0x71, flags: 0, buf: b0, len: 2 },
-			   { addr: 0x71, flags: I2C_M_RD, buf: b1, len: 2 } };
+	struct i2c_msg msg [] = {
+		{
+			.addr	= 0x71,
+			.flags	= 0,
+			.buf	= b0,
+			.len	= 2,
+		},
+		{
+			.addr	= 0x71,
+			.flags	= I2C_M_RD,
+			.buf	= b1,
+			.len	= 2,
+		},
+	};
 
 	ret = i2c->xfer (i2c, msg, 2);
 
@@ -128,7 +146,12 @@
 int sp5659_write (struct dvb_i2c_bus *i2c, u8 data [4])
 {
         int ret;
-        struct i2c_msg msg = { addr: 0x60, flags: 0, buf: data, len: 4 };
+        struct i2c_msg msg = {
+		.addr	= 0x60,
+		.flags	= 0,
+		.buf	= data,
+		.len	= 4,
+	};
 
         ret = i2c->xfer (i2c, &msg, 1);
 
@@ -419,7 +442,12 @@
 int tdlb7_attach (struct dvb_i2c_bus *i2c)
 {
 
-	struct i2c_msg msg = { addr: 0x71, flags: 0, buf: NULL, len: 0 };
+	struct i2c_msg msg = {
+		.addr	= 0x71,
+		.flags	= 0,
+		.buf	= NULL,
+		.len	= 0,
+	};
 
 	dprintk ("%s\n", __FUNCTION__);
 
===== drivers/media/dvb/frontends/alps_tdmb7.c 1.3 vs edited =====
--- 1.3/drivers/media/dvb/frontends/alps_tdmb7.c	Mon Apr  7 15:20:02 2003
+++ edited/drivers/media/dvb/frontends/alps_tdmb7.c	Sun Apr 27 21:19:43 2003
@@ -32,22 +32,24 @@
 
 static
 struct dvb_frontend_info tdmb7_info = {
-	name: "Alps TDMB7",
-	type: FE_OFDM,
-	frequency_min: 470000000,
-	frequency_max: 860000000,
-	frequency_stepsize: 166667,
+	.name			= "Alps TDMB7",
+	.type			= FE_OFDM,
+	.frequency_min		= 470000000,
+	.frequency_max		= 860000000,
+	.frequency_stepsize	= 166667,
 #if 0
-    	frequency_tolerance: ???,
-	symbol_rate_min: ???,
-	symbol_rate_max: ???,
-	symbol_rate_tolerance: 500,  /* ppm */
-	notifier_delay: 0,
+    	.frequency_tolerance	= ???,
+	.symbol_rate_min	= ???,
+	.symbol_rate_max	= ???,
+	.symbol_rate_tolerance	= 500,  /* ppm */
+	.notifier_delay		= 0,
 #endif
-	caps: FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
-	      FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
-	      FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | 
-	      FE_CAN_CLEAN_SETUP | FE_CAN_RECOVER
+	.caps			= FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 |
+				  FE_CAN_FEC_3_4 | FE_CAN_FEC_5_6 |
+				  FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+				  FE_CAN_QPSK | FE_CAN_QAM_16 |
+				  FE_CAN_QAM_64 | FE_CAN_CLEAN_SETUP |
+				  FE_CAN_RECOVER,
 };
 
 
@@ -87,7 +89,12 @@
 {
 	int ret;
 	u8 buf [] = { reg, data };
-	struct i2c_msg msg = { addr: 0x43, flags: 0, buf: buf, len: 2 };
+	struct i2c_msg msg = {
+		.addr	= 0x43,
+		.flags	= 0,
+		.buf	= buf,
+		.len	= 2,
+	};
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -107,8 +114,20 @@
 	int ret;
 	u8 b0 [] = { reg };
 	u8 b1 [] = { 0 };
-	struct i2c_msg msg [] = { { addr: 0x43, flags: 0, buf: b0, len: 1 },
-			   { addr: 0x43, flags: I2C_M_RD, buf: b1, len: 1 } };
+	struct i2c_msg msg [] = {
+		{
+			.addr	= 0x43,
+			.flags	= 0,
+			.buf	= b0,
+			.len	= 1,
+		},
+		{
+			.addr	= 0x43,
+			.flags	= I2C_M_RD,
+			.buf	= b1,
+			.len	= 1,
+		},
+	};
         
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -124,7 +143,12 @@
 static
 int pll_write (struct dvb_i2c_bus *i2c, u8 data [4])
 {
-	struct i2c_msg msg = { addr: 0x61, flags: 0, buf: data, len: 4 };
+	struct i2c_msg msg = {
+		.addr	= 0x61,
+		.flags	= 0,
+		.buf	= data,
+		.len	= 4,
+	};
 	int ret;
 
 	cx22700_writereg (i2c, 0x0a, 0x00);  /* open i2c bus switch */
@@ -420,7 +444,12 @@
 static
 int tdmb7_attach (struct dvb_i2c_bus *i2c)
 {
-	struct i2c_msg msg = { addr: 0x43, flags: 0, buf: NULL, len: 0 };
+	struct i2c_msg msg = {
+		.addr	= 0x43,
+		.flags	= 0,
+		.buf	= NULL,
+		.len	= 0,
+	};
 
 	dprintk ("%s\n", __FUNCTION__);
 
===== drivers/media/dvb/frontends/at76c651.c 1.1 vs edited =====
--- 1.1/drivers/media/dvb/frontends/at76c651.c	Tue Apr  8 11:39:31 2003
+++ edited/drivers/media/dvb/frontends/at76c651.c	Sun Apr 27 21:22:37 2003
@@ -94,7 +94,12 @@
 
 	int ret;
 	u8 buf[] = { reg, data };
-	struct i2c_msg msg = { addr:0x1a >> 1, flags:0, buf:buf, len:2 };
+	struct i2c_msg msg = {
+		.addr	= 0x1a >> 1,
+		.flags	= 0,
+		.buf	= buf,
+		.len	= 2,
+	};
 
 	ret = i2c->xfer(i2c, &msg, 1);
 
@@ -116,8 +121,20 @@
 	int ret;
 	u8 b0[] = { reg };
 	u8 b1[] = { 0 };
-	struct i2c_msg msg[] = { {addr: 0x1a >> 1, flags: 0, buf: b0, len:1},
-			  {addr: 0x1a >> 1, flags: I2C_M_RD, buf: b1, len:1} };
+	struct i2c_msg msg[] = {
+		{
+			.addr	= 0x1a >> 1,
+			.flags	= 0,
+			.buf	= b0,
+			.len	= 1,
+		},
+		{
+			.addr	= 0x1a >> 1,
+			.flags	= I2C_M_RD,
+			.buf	= b1,
+			.len	= 1
+		},
+	};
 
 	ret = i2c->xfer(i2c, msg, 2);
 
@@ -191,8 +208,12 @@
 {
 
 	int ret;
-	struct i2c_msg msg =
-	    { addr:0xc2 >> 1, flags:0, buf:(u8 *) & tw, len:sizeof (tw) };
+	struct i2c_msg msg = {
+		.addr	= 0xc2 >> 1,
+		.flags	= 0,
+		.buf	= (u8 *) &tw,
+		.len	= sizeof(tw),
+	};
 
 	at76c651_switch_tuner_i2c(i2c, 1);
 
===== drivers/media/dvb/frontends/grundig_29504-401.c 1.3 vs edited =====
--- 1.3/drivers/media/dvb/frontends/grundig_29504-401.c	Mon Apr  7 15:20:02 2003
+++ edited/drivers/media/dvb/frontends/grundig_29504-401.c	Sun Apr 27 21:31:29 2003
@@ -33,18 +33,19 @@
 
 
 struct dvb_frontend_info grundig_29504_401_info = {
-	name: "Grundig 29504-401",
-	type: FE_OFDM,
-/*	frequency_min: ???,*/
-/*	frequency_max: ???,*/
-	frequency_stepsize: 166666,
-/*      frequency_tolerance: ???,*/
-/*      symbol_rate_tolerance: ???,*/
-	notifier_delay: 0,
-	caps: FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 | 
-	      FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
-	      FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 |
-	      FE_CAN_MUTE_TS /*| FE_CAN_CLEAN_SETUP*/
+	.name			= "Grundig 29504-401",
+	.type			= FE_OFDM,
+/*	.frequency_min		= ???,*/
+/*	.frequency_max		= ???,*/
+	.frequency_stepsize	= 166666,
+/*      .frequency_tolerance	= ???,*/
+/*      .symbol_rate_tolerance	= ???,*/
+	.notifier_delay		= 0,
+	.caps			= FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 |
+				  FE_CAN_FEC_3_4 | FE_CAN_FEC_5_6 |
+				  FE_CAN_FEC_7_8 | FE_CAN_QPSK |
+				  FE_CAN_QAM_16 | FE_CAN_QAM_64 |
+				  FE_CAN_MUTE_TS, /*| FE_CAN_CLEAN_SETUP*/
 };
 
 
@@ -53,7 +54,12 @@
 {
 	int ret;
 	u8 buf [] = { reg, data };
-	struct i2c_msg msg = { addr: 0x55, flags: 0, buf: buf, len: 2 };
+	struct i2c_msg msg = {
+		.addr	= 0x55,
+		.flags	= 0,
+		.buf	= buf,
+		.len	= 2,
+	};
 
 	if ((ret = i2c->xfer (i2c, &msg, 1)) != 1)
 		dprintk ("%s: write_reg error (reg == %02x) = %02x!\n",
@@ -69,8 +75,20 @@
 	int ret;
 	u8 b0 [] = { reg };
 	u8 b1 [] = { 0 };
-	struct i2c_msg msg [] = { { addr: 0x55, flags: 0, buf: b0, len: 1 },
-			   { addr: 0x55, flags: I2C_M_RD, buf: b1, len: 1 } };
+	struct i2c_msg msg [] = {
+		{
+			.addr	= 0x55,
+			.flags	= 0,
+			.buf	= b0,
+			.len	= 1,
+		},
+		{
+			.addr	= 0x55,
+			.flags	= I2C_M_RD,
+			.buf	= b1,
+			.len	= 1
+		},
+	};
 
 	ret = i2c->xfer (i2c, msg, 2);
 
@@ -85,7 +103,12 @@
 int tsa5060_write (struct dvb_i2c_bus *i2c, u8 data [4])
 {
 	int ret;
-	struct i2c_msg msg = { addr: 0x61, flags: 0, buf: data, len: 4 };
+	struct i2c_msg msg = {
+		.addr	= 0x61,
+		.flags	= 0,
+		.buf	= data,
+		.len	= 4,
+	};
 
 	if ((ret = i2c->xfer (i2c, &msg, 1)) != 1)
 		dprintk ("%s: write_reg error == %02x!\n", __FUNCTION__, ret);
@@ -269,7 +292,12 @@
 void reset_and_configure (struct dvb_i2c_bus *i2c)
 {
 	u8 buf [] = { 0x06 };
-	struct i2c_msg msg = { addr: 0x00, flags: 0, buf: buf, len: 1 };
+	struct i2c_msg msg = {
+		.addr	= 0x00,
+		.flags	= 0,
+		.buf	= buf,
+		.len	= 1,
+	};
 
 	i2c->xfer (i2c, &msg, 1);
 }
@@ -420,8 +448,20 @@
 {
 	u8 b0 [] = { 0x1a };
 	u8 b1 [] = { 0x00 };
-	struct i2c_msg msg [] = { { addr: 0x55, flags: 0, buf: b0, len: 1 },
-			   { addr: 0x55, flags: I2C_M_RD, buf: b1, len: 1 } };
+	struct i2c_msg msg [] = {
+		{
+			.addr	= 0x55,
+			.flags	= 0,
+			.buf	= b0,
+			.len	= 1,
+		},
+		{
+			.addr	= 0x55,
+			.flags	= I2C_M_RD,
+			.buf	= b1,
+			.len	= 1,
+		},
+	};
 
 	if (i2c->xfer (i2c, msg, 2) == 2)   /*  probably an EEPROM... */
 		return -ENODEV;
===== drivers/media/dvb/frontends/grundig_29504-491.c 1.3 vs edited =====
--- 1.3/drivers/media/dvb/frontends/grundig_29504-491.c	Mon Apr  7 15:20:02 2003
+++ edited/drivers/media/dvb/frontends/grundig_29504-491.c	Sun Apr 27 21:26:48 2003
@@ -35,22 +35,23 @@
 
 static
 struct dvb_frontend_info grundig_29504_491_info = {
-	name: "Grundig 29504-491, (TDA8083 based)",
-	type: FE_QPSK,
-	frequency_min: 950000,     /* FIXME: guessed! */
-	frequency_max: 1400000,    /* FIXME: guessed! */
-	frequency_stepsize: 125,   /* kHz for QPSK frontends */
-/*      frequency_tolerance: ???,*/
-	symbol_rate_min: 1000000,   /* FIXME: guessed! */
-	symbol_rate_max: 45000000,  /* FIXME: guessed! */
-/*      symbol_rate_tolerance: ???,*/
-	notifier_delay: 0,
-	caps:	FE_CAN_INVERSION_AUTO |
-		FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
-		FE_CAN_FEC_4_5 | FE_CAN_FEC_5_6 | FE_CAN_FEC_6_7 |
-		FE_CAN_FEC_7_8 | FE_CAN_FEC_8_9 | FE_CAN_FEC_AUTO |
-		FE_CAN_QPSK |
-		FE_CAN_MUTE_TS | FE_CAN_CLEAN_SETUP
+	.name			= "Grundig 29504-491, (TDA8083 based)",
+	.type			= FE_QPSK,
+	.frequency_min		= 950000,     /* FIXME: guessed! */
+	.frequency_max		= 1400000,    /* FIXME: guessed! */
+	.frequency_stepsize	= 125,   /* kHz for QPSK frontends */
+/*      .frequency_tolerance	= ???,*/
+	.symbol_rate_min	= 1000000,   /* FIXME: guessed! */
+	.symbol_rate_max	= 45000000,  /* FIXME: guessed! */
+/*      .symbol_rate_tolerance	= ???,*/
+	.notifier_delay		= 0,
+	.caps			= FE_CAN_INVERSION_AUTO |
+				  FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 |
+				  FE_CAN_FEC_3_4 | FE_CAN_FEC_4_5 |
+				  FE_CAN_FEC_5_6 | FE_CAN_FEC_6_7 |
+				  FE_CAN_FEC_7_8 | FE_CAN_FEC_8_9 |
+				  FE_CAN_FEC_AUTO | FE_CAN_QPSK |
+				  FE_CAN_MUTE_TS | FE_CAN_CLEAN_SETUP,
 };
 
 
@@ -72,7 +73,12 @@
 {
 	int ret;
 	u8 buf [] = { reg, data };
-	struct i2c_msg msg = { addr: 0x68, flags: 0, buf: buf, len: 2 };
+	struct i2c_msg msg = {
+		.addr	= 0x68,
+		.flags	= 0,
+		.buf	= buf,
+		.len	= 2,
+	};
 
         ret = i2c->xfer (i2c, &msg, 1);
 
@@ -88,8 +94,20 @@
 int tda8083_readregs (struct dvb_i2c_bus *i2c, u8 reg1, u8 *b, u8 len)
 {
 	int ret;
-	struct i2c_msg msg [] = { { addr: 0x68, flags: 0, buf: &reg1, len: 1 },
-			   { addr: 0x68, flags: I2C_M_RD, buf: b, len: len } };
+	struct i2c_msg msg [] = {
+		{
+			.addr	= 0x68,
+			.flags	= 0,
+			.buf	= &reg1,
+			.len	= 1,
+		},
+		{
+			.addr	= 0x68,
+			.flags	= I2C_M_RD,
+			.buf	= b,
+			.len	= len,
+		},
+	};
 
 	ret = i2c->xfer (i2c, msg, 2);
 
@@ -116,7 +134,12 @@
 int tsa5522_write (struct dvb_i2c_bus *i2c, u8 data [4])
 {
 	int ret;
-	struct i2c_msg msg = { addr: 0x61, flags: 0, buf: data, len: 4 };
+	struct i2c_msg msg = {
+		.addr	= 0x61,
+		.flags	= 0,
+		.buf	= data,
+		.len	= 4,
+	};
 
 	ret = i2c->xfer (i2c, &msg, 1);
 
===== drivers/media/dvb/frontends/stv0299.c 1.1 vs edited =====
--- 1.1/drivers/media/dvb/frontends/stv0299.c	Tue Apr  8 11:39:32 2003
+++ edited/drivers/media/dvb/frontends/stv0299.c	Sun Apr 27 21:05:29 2003
@@ -54,21 +54,21 @@
 
 static
 struct dvb_frontend_info uni0299_info = {
-	name: "STV0299/TSA5059/SL1935 based",
-	type: FE_QPSK,
-	frequency_min: 950000,
-	frequency_max: 2150000,
-	frequency_stepsize: 125,   /* kHz for QPSK frontends */
-	frequency_tolerance: M_CLK/2000,
-	symbol_rate_min: 1000000,
-	symbol_rate_max: 45000000,
-	symbol_rate_tolerance: 500,  /* ppm */
-	notifier_delay: 0,
-	caps: FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
-	      FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
-	      FE_CAN_QPSK |
-	      FE_CAN_FEC_AUTO | FE_CAN_INVERSION_AUTO |
-	      FE_CAN_CLEAN_SETUP
+	.name			= "STV0299/TSA5059/SL1935 based",
+	.type			= FE_QPSK,
+	.frequency_min		= 950000,
+	.frequency_max		= 2150000,
+	.frequency_stepsize	= 125,   /* kHz for QPSK frontends */
+	.frequency_tolerance	= M_CLK/2000,
+	.symbol_rate_min	= 1000000,
+	.symbol_rate_max	= 45000000,
+	.symbol_rate_tolerance	= 500,  /* ppm */
+	.notifier_delay		= 0,
+	.caps			= FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 |
+				  FE_CAN_FEC_3_4 | FE_CAN_FEC_5_6 |
+				  FE_CAN_FEC_7_8 | FE_CAN_QPSK |
+				  FE_CAN_FEC_AUTO | FE_CAN_INVERSION_AUTO |
+				  FE_CAN_CLEAN_SETUP,
 };
 
 
@@ -185,7 +185,12 @@
 {
 	int ret;
 	u8 buf [] = { reg, data };
-	struct i2c_msg msg = { addr: 0x68, flags: 0, buf: buf, len: 2 };
+	struct i2c_msg msg = {
+		.addr	= 0x68,
+		.flags	= 0,
+		.buf	= buf,
+		.len	= 2,
+	};
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -205,8 +210,20 @@
 	int ret;
 	u8 b0 [] = { reg };
 	u8 b1 [] = { 0 };
-	struct i2c_msg msg [] = { { addr: 0x68, flags: 0, buf: b0, len: 1 },
-			   { addr: 0x68, flags: I2C_M_RD, buf: b1, len: 1 } };
+	struct i2c_msg msg [] = {
+		{
+			.addr	= 0x68,
+			.flags	= 0,
+			.buf	= b0,
+			.len	= 1,
+		},
+		{
+			.addr	= 0x68,
+			.flags	= I2C_M_RD,
+			.buf	= b1,
+			.len	= 1,
+		},
+	};
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -223,8 +240,20 @@
 int stv0299_readregs (struct dvb_i2c_bus *i2c, u8 reg1, u8 *b, u8 len)
 {
         int ret;
-        struct i2c_msg msg [] = { { addr: 0x68, flags: 0, buf: &reg1, len: 1 },
-                           { addr: 0x68, flags: I2C_M_RD, buf: b, len: len } };
+        struct i2c_msg msg [] = {
+		{
+			.addr	= 0x68,
+			.flags	= 0,
+			.buf	= &reg1,
+			.len	= 1,
+		},
+		{
+			.addr	= 0x68,
+			.flags	= I2C_M_RD,
+			.buf	= b,
+			.len	= len,
+		},
+	};
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -244,8 +273,20 @@
 	u8 rpt1 [] = { 0x05, 0xb5 };  /*  enable i2c repeater on stv0299  */
 	/* TSA5059 i2c-bus address */
 	u8 addr = (ftype == PHILIPS_SU1278SH) ? 0x60 : 0x61;
-	struct i2c_msg msg [] = {{ addr: 0x68, flags: 0, buf: rpt1, len: 2 },
-			         { addr: addr, flags: 0, buf: data, len: 4 }};
+	struct i2c_msg msg [] = {
+		{
+			.addr	= 0x68,
+			.flags	= 0,
+			.buf	= rpt1,
+			.len	= 2,
+		},
+		{
+			.addr	= addr,
+			.flags	= 0,
+			.buf	= data,
+			.len	= 4,
+		},
+	};
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -331,8 +372,20 @@
 	u8 rpt1 [] = { 0x05, 0xb5 };
 	u8 stat [] = { 0 };
 
-	struct i2c_msg msg [] = {{ addr: 0x68, flags: 0, buf: rpt1, len: 2 },
-			  { addr: 0x60, flags: I2C_M_RD, buf: stat, len: 1 }};
+	struct i2c_msg msg [] = {
+		{
+			.addr	= 0x68,
+			.flags	= 0,
+			.buf	= rpt1,
+			.len	= 2,
+		},
+		{
+			.addr	= 0x60,
+			.flags	= I2C_M_RD,
+			.buf	= stat,
+			.len	= 1,
+		},
+	};
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -792,10 +845,34 @@
         /* read the status register of TSA5059 */
 	u8 rpt[] = { 0x05, 0xb5 };
         u8 stat [] = { 0 };
-	struct i2c_msg msg1 [] = {{ addr: 0x68, flags: 0, buf: rpt,  len: 2 },
-                           { addr: 0x60, flags: I2C_M_RD, buf: stat, len: 1 }};
-	struct i2c_msg msg2 [] = {{ addr: 0x68, flags: 0, buf: rpt,  len: 2 },
-                           { addr: 0x61, flags: I2C_M_RD, buf: stat, len: 1 }};
+	struct i2c_msg msg1 [] = {
+		{
+			.addr	= 0x68,
+			.flags	= 0,
+			.buf	= rpt,
+			.len	= 2,
+		},
+		{
+			.addr	= 0x60,
+			.flags	= I2C_M_RD,
+			.buf	= stat,
+			.len	= 1,
+		},
+	};
+	struct i2c_msg msg2 [] = {
+		{
+			.addr	= 0x68,
+			.flags	= 0,
+			.buf	= rpt,
+			.len	= 2,
+		},
+		{
+			.addr	= 0x61,
+			.flags	= I2C_M_RD,
+			.buf	= stat,
+			.len	= 1,
+		},
+	};
 
 	if (i2c->xfer(i2c, msg1, 2) == 2) {
 		type = PHILIPS_SU1278SH;
===== drivers/media/dvb/frontends/ves1820.c 1.4 vs edited =====
--- 1.4/drivers/media/dvb/frontends/ves1820.c	Mon Apr  7 15:20:02 2003
+++ edited/drivers/media/dvb/frontends/ves1820.c	Sun Apr 27 21:36:17 2003
@@ -112,7 +112,12 @@
 {
 	u8 addr = GET_DEMOD_ADDR(fe->data);
         u8 buf[] = { 0x00, reg, data };
-	struct i2c_msg msg = { addr: addr, flags: 0, buf: buf, len: 3 };
+	struct i2c_msg msg = {
+		.addr	= addr,
+		.flags	= 0,
+		.buf	= buf,
+		.len	= 3,
+	};
 	struct dvb_i2c_bus *i2c = fe->i2c;
         int ret;
 
@@ -134,8 +139,20 @@
 	u8 b0 [] = { 0x00, reg };
 	u8 b1 [] = { 0 };
 	u8 addr = GET_DEMOD_ADDR(fe->data);
-	struct i2c_msg msg [] = { { addr: addr, flags: 0, buf: b0, len: 2 },
-	                   { addr: addr, flags: I2C_M_RD, buf: b1, len: 1 } };
+	struct i2c_msg msg [] = {
+		{
+			.addr	= addr,
+			.flags	= 0,
+			.buf	= b0,
+			.len	= 2,
+		},
+		{
+			.addr	= addr,
+			.flags	= I2C_M_RD,
+			.buf	= b1,
+			.len	= 1,
+		},
+	};
 	struct dvb_i2c_bus *i2c = fe->i2c;
 	int ret;
 
@@ -152,7 +169,12 @@
 int tuner_write (struct dvb_i2c_bus *i2c, u8 addr, u8 data [4])
 {
         int ret;
-        struct i2c_msg msg = { addr: addr, flags: 0, buf: data, len: 4 };
+        struct i2c_msg msg = {
+		.addr	= addr,
+		.flags	= 0,
+		.buf	= data,
+		.len	= 4,
+	};
 
         ret = i2c->xfer (i2c, &msg, 1);
 
@@ -429,9 +451,19 @@
 int probe_tuner (struct dvb_i2c_bus *i2c)
 {
 	static const
-	struct i2c_msg msg1 = { addr: 0x61, flags: 0, buf: NULL, len: 0 };
+	struct i2c_msg msg1 = {
+		.addr	= 0x61,
+		.flags	= 0,
+		.buf	= NULL,
+		.len	= 0,
+	};
 	static const
-	struct i2c_msg msg2 = { addr: 0x62, flags: 0, buf: NULL, len: 0 };
+	struct i2c_msg msg2 = {
+		.addr	= 0x62,
+		.flags	= 0,
+		.buf	= NULL,
+		.len	= 0,
+	};
 	int type;
 
 	if (i2c->xfer(i2c, &msg1, 1) == 1) {
@@ -456,8 +488,20 @@
 {
 	u8 b = 0xff;
 	u8 pwm;
-	struct i2c_msg msg [] = { { addr: 0x50, flags: 0, buf: &b, len: 1 },
-			 { addr: 0x50, flags: I2C_M_RD, buf: &pwm, len: 1 } };
+	struct i2c_msg msg [] = {
+		{
+			.addr	= 0x50,
+			.flags	= 0,
+			.buf	= &b,
+			.len	= 1,
+		},
+		{
+			.addr	= 0x50,
+			.flags	= I2C_M_RD,
+			.buf	= &pwm,
+			.len	= 1,
+		},
+	};
 
 	i2c->xfer (i2c, msg, 2);
 
@@ -475,8 +519,20 @@
 {
 	u8 b [] = { 0x00, 0x1a };
 	u8 id;
-	struct i2c_msg msg [] = { { addr: 0x08, flags: 0, buf: b, len: 2 },
-	                   { addr: 0x08, flags: I2C_M_RD, buf: &id, len: 1 } };
+	struct i2c_msg msg [] = {
+		{
+			.addr	= 0x08,
+			.flags	= 0,
+			.buf	= b,
+			.len	= 2,
+		},
+		{
+			.addr	= 0x08,
+			.flags	= I2C_M_RD,
+			.buf	= &id,
+			.len	= 1,
+		},
+	};
 
 	if (i2c->xfer(i2c, msg, 2) == 2 && (id & 0xf0) == 0x70)
 		return msg[0].addr;
===== drivers/media/dvb/ttpci/av7110_ir.c 1.1 vs edited =====
--- 1.1/drivers/media/dvb/ttpci/av7110_ir.c	Mon Apr  7 15:20:06 2003
+++ edited/drivers/media/dvb/ttpci/av7110_ir.c	Sun Apr 27 21:37:13 2003
@@ -58,7 +58,7 @@
 
 
 static
-struct timer_list keyup_timer = { function: av7110_emit_keyup };
+struct timer_list keyup_timer = { .function = av7110_emit_keyup };
 
 
 static
===== drivers/media/video/bttv-cards.c 1.16 vs edited =====
--- 1.16/drivers/media/video/bttv-cards.c	Tue Mar 18 11:00:00 2003
+++ edited/drivers/media/video/bttv-cards.c	Wed Apr  2 07:11:12 2003
@@ -1173,7 +1173,7 @@
 	.tuner_type     = -1,
 	.pll            = PLL_28,
 	.muxsel         = { 2 },
-	gpiomask:       0
+	.gpiomask       = 0,
 },{
         /* Tomasz Pyra <hellfire@sedez.iq.pl> */
         .name           = "Prolink Pixelview PV-BT878P+ (Rev.4C,8E)",
@@ -1260,7 +1260,7 @@
 },{
         .name           = "Powercolor MTV878/ MTV878R/ MTV878F",
         .video_inputs   = 3,
-        audio_inputs:   2, 
+        .audio_inputs   = 2, 
 	.tuner		= 0,
         .svhs           = 2,
         .gpiomask       = 0x1C800F,  // Bit0-2: Audio select, 8-12:remote control 14:remote valid 15:remote reset
@@ -1300,7 +1300,7 @@
 },{
         .name           = "Jetway TV/Capture JW-TV878-FBK, Kworld KW-TV878RF",
         .video_inputs   = 4,
-        audio_inputs:   3, 
+        .audio_inputs   = 3, 
         .tuner          = 0,
         .svhs           = 2,
         .gpiomask       = 7,
===== drivers/media/video/bttv-driver.c 1.27 vs edited =====
--- 1.27/drivers/media/video/bttv-driver.c	Thu Mar 13 08:26:40 2003
+++ edited/drivers/media/video/bttv-driver.c	Wed Apr  2 07:10:09 2003
@@ -2786,8 +2786,8 @@
 static struct video_device bttv_video_template =
 {
 	.name     = "UNSET",
-	type:     VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
-	          VID_TYPE_CLIPPING|VID_TYPE_SCALES,
+	.type     = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
+	            VID_TYPE_CLIPPING|VID_TYPE_SCALES,
 	.hardware = VID_HARDWARE_BT848,
 	.fops     = &bttv_fops,
 	.minor    = -1,
===== drivers/media/video/tvaudio.c 1.17 vs edited =====
--- 1.17/drivers/media/video/tvaudio.c	Thu Apr 24 06:11:51 2003
+++ edited/drivers/media/video/tvaudio.c	Fri Apr 25 15:24:49 2003
@@ -1319,7 +1319,7 @@
 			     PIC16C54_MISC_SND_NOTMUTE},
 		.inputmute  = PIC16C54_MISC_SND_MUTE,
 	},
-	{ name: NULL } /* EOF */
+	{ .name = NULL } /* EOF */
 };
 
 
===== drivers/media/common/saa7146_video.c 1.1 vs edited =====
--- 1.1/drivers/media/common/saa7146_video.c	Mon Apr  7 15:16:30 2003
+++ edited/drivers/media/common/saa7146_video.c	Sun Apr 27 20:51:13 2003
@@ -365,41 +365,41 @@
 static
 struct v4l2_queryctrl controls[] = {
 	{
-		id:            V4L2_CID_BRIGHTNESS,
-		name:          "Brightness",
-		minimum:       0,
-		maximum:       255,
-		step:          1,
-		default_value: 128,
-		type:          V4L2_CTRL_TYPE_INTEGER,
+		.id		= V4L2_CID_BRIGHTNESS,
+		.name		= "Brightness",
+		.minimum	= 0,
+		.maximum	= 255,
+		.step		= 1,
+		.default_value	= 128,
+		.type		= V4L2_CTRL_TYPE_INTEGER,
 	},{
-		id:            V4L2_CID_CONTRAST,
-		name:          "Contrast",
-		minimum:       0,
-		maximum:       127,
-		step:          1,
-		default_value: 64,
-		type:          V4L2_CTRL_TYPE_INTEGER,
+		.id		= V4L2_CID_CONTRAST,
+		.name		= "Contrast",
+		.minimum	= 0,
+		.maximum	= 127,
+		.step		= 1,
+		.default_value	= 64,
+		.type		= V4L2_CTRL_TYPE_INTEGER,
 	},{
-		id:            V4L2_CID_SATURATION,
-		name:          "Saturation",
-		minimum:       0,
-		maximum:       127,
-		step:          1,
-		default_value: 64,
-		type:          V4L2_CTRL_TYPE_INTEGER,
+		.id		= V4L2_CID_SATURATION,
+		.name		= "Saturation",
+		.minimum	= 0,
+		.maximum	= 127,
+		.step		= 1,
+		.default_value	= 64,
+		.type		= V4L2_CTRL_TYPE_INTEGER,
 	},{
-		id:            V4L2_CID_VFLIP,
-		name:          "Vertical flip",
-		minimum:       0,
-		maximum:       1,
-		type:          V4L2_CTRL_TYPE_BOOLEAN,
+		.id		= V4L2_CID_VFLIP,
+		.name		= "Vertical flip",
+		.minimum	= 0,
+		.maximum	= 1,
+		.type		= V4L2_CTRL_TYPE_BOOLEAN,
 	},{
-		id:            V4L2_CID_HFLIP,
-		name:          "Horizontal flip",
-		minimum:       0,
-		maximum:       1,
-		type:          V4L2_CTRL_TYPE_BOOLEAN,
+		.id		= V4L2_CID_HFLIP,
+		.name		= "Horizontal flip",
+		.minimum	= 0,
+		.maximum	= 1,
+		.type		= V4L2_CTRL_TYPE_BOOLEAN,
 	},
 };
 static
===== drivers/media/common/saa7146_video.c 1.1 vs edited =====
--- 1.1/drivers/media/common/saa7146_video.c	Mon Apr  7 15:16:30 2003
+++ edited/drivers/media/common/saa7146_video.c	Sun Apr 27 20:51:13 2003
@@ -365,41 +365,41 @@
 static
 struct v4l2_queryctrl controls[] = {
 	{
-		id:            V4L2_CID_BRIGHTNESS,
-		name:          "Brightness",
-		minimum:       0,
-		maximum:       255,
-		step:          1,
-		default_value: 128,
-		type:          V4L2_CTRL_TYPE_INTEGER,
+		.id		= V4L2_CID_BRIGHTNESS,
+		.name		= "Brightness",
+		.minimum	= 0,
+		.maximum	= 255,
+		.step		= 1,
+		.default_value	= 128,
+		.type		= V4L2_CTRL_TYPE_INTEGER,
 	},{
-		id:            V4L2_CID_CONTRAST,
-		name:          "Contrast",
-		minimum:       0,
-		maximum:       127,
-		step:          1,
-		default_value: 64,
-		type:          V4L2_CTRL_TYPE_INTEGER,
+		.id		= V4L2_CID_CONTRAST,
+		.name		= "Contrast",
+		.minimum	= 0,
+		.maximum	= 127,
+		.step		= 1,
+		.default_value	= 64,
+		.type		= V4L2_CTRL_TYPE_INTEGER,
 	},{
-		id:            V4L2_CID_SATURATION,
-		name:          "Saturation",
-		minimum:       0,
-		maximum:       127,
-		step:          1,
-		default_value: 64,
-		type:          V4L2_CTRL_TYPE_INTEGER,
+		.id		= V4L2_CID_SATURATION,
+		.name		= "Saturation",
+		.minimum	= 0,
+		.maximum	= 127,
+		.step		= 1,
+		.default_value	= 64,
+		.type		= V4L2_CTRL_TYPE_INTEGER,
 	},{
-		id:            V4L2_CID_VFLIP,
-		name:          "Vertical flip",
-		minimum:       0,
-		maximum:       1,
-		type:          V4L2_CTRL_TYPE_BOOLEAN,
+		.id		= V4L2_CID_VFLIP,
+		.name		= "Vertical flip",
+		.minimum	= 0,
+		.maximum	= 1,
+		.type		= V4L2_CTRL_TYPE_BOOLEAN,
 	},{
-		id:            V4L2_CID_HFLIP,
-		name:          "Horizontal flip",
-		minimum:       0,
-		maximum:       1,
-		type:          V4L2_CTRL_TYPE_BOOLEAN,
+		.id		= V4L2_CID_HFLIP,
+		.name		= "Horizontal flip",
+		.minimum	= 0,
+		.maximum	= 1,
+		.type		= V4L2_CTRL_TYPE_BOOLEAN,
 	},
 };
 static
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
