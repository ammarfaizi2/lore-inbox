Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVEHTV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVEHTV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbVEHTUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:20:38 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:60054 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262871AbVEHTJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:48 -0400
Message-Id: <20050508184346.984272000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:43 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-fe-tda1004x-formatting.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 14/37] tda1004x: formatting cleanups
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mostly formatting cleanups, no functional change (Andreas Oberritter)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/tda1004x.c |  246 ++++++++++++++++-----------------
 1 files changed, 125 insertions(+), 121 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/tda1004x.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/tda1004x.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/tda1004x.c	2005-05-08 16:17:19.000000000 +0200
@@ -35,9 +35,10 @@
 #include "dvb_frontend.h"
 #include "tda1004x.h"
 
-#define TDA1004X_DEMOD_TDA10045 0
-#define TDA1004X_DEMOD_TDA10046 1
-
+enum tda1004x_demod {
+	TDA1004X_DEMOD_TDA10045,
+	TDA1004X_DEMOD_TDA10046,
+};
 
 struct tda1004x_state {
 	struct i2c_adapter* i2c;
@@ -46,8 +47,8 @@ struct tda1004x_state {
 	struct dvb_frontend frontend;
 
 	/* private demod data */
-	u8 initialised:1;
-	u8 demod_type;
+	u8 initialised;
+	enum tda1004x_demod demod_type;
 };
 
 
@@ -139,7 +140,7 @@ static int tda1004x_write_byteI(struct t
 {
 	int ret;
 	u8 buf[] = { reg, data };
-	struct i2c_msg msg = { .addr=0, .flags=0, .buf=buf, .len=2 };
+	struct i2c_msg msg = { .flags = 0, .buf = buf, .len = 2 };
 
 	dprintk("%s: reg=0x%x, data=0x%x\n", __FUNCTION__, reg, data);
 
@@ -160,8 +161,8 @@ static int tda1004x_read_byte(struct tda
 	int ret;
 	u8 b0[] = { reg };
 	u8 b1[] = { 0 };
-	struct i2c_msg msg[] = {{ .addr=0, .flags=0, .buf=b0, .len=1},
-				{ .addr=0, .flags=I2C_M_RD, .buf=b1, .len = 1}};
+	struct i2c_msg msg[] = {{ .flags = 0, .buf = b0, .len = 1 },
+				{ .flags = I2C_M_RD, .buf = b1, .len = 1 }};
 
 	dprintk("%s: reg=0x%x\n", __FUNCTION__, reg);
 
@@ -294,7 +295,7 @@ static int tda1004x_do_upload(struct tda
 			      u8 dspCodeCounterReg, u8 dspCodeInReg)
 {
 	u8 buf[65];
-	struct i2c_msg fw_msg = {.addr = 0,.flags = 0,.buf = buf,.len = 0 };
+	struct i2c_msg fw_msg = { .flags = 0, .buf = buf, .len = 0 };
 	int tx_size;
 	int pos = 0;
 
@@ -304,12 +305,10 @@ static int tda1004x_do_upload(struct tda
 
 	buf[0] = dspCodeInReg;
 	while (pos != len) {
-
 		// work out how much to send this time
 		tx_size = len - pos;
-		if (tx_size > 0x10) {
+		if (tx_size > 0x10)
 			tx_size = 0x10;
-		}
 
 		// send the chunk
 		memcpy(buf + 1, mem + pos, tx_size);
@@ -322,6 +321,7 @@ static int tda1004x_do_upload(struct tda
 
 		dprintk("%s: fw_pos=0x%x\n", __FUNCTION__, pos);
 	}
+
 	return 0;
 }
 
@@ -335,9 +335,8 @@ static int tda1004x_check_upload_ok(stru
 
 	data1 = tda1004x_read_byte(state, TDA1004X_DSP_DATA1);
 	data2 = tda1004x_read_byte(state, TDA1004X_DSP_DATA2);
-	if (data1 != 0x67 || data2 != dspVersion) {
+	if ((data1 != 0x67) || (data2 != dspVersion))
 		return -EIO;
-	}
 
 	return 0;
 }
@@ -348,9 +347,9 @@ static int tda10045_fwupload(struct dvb_
 	int ret;
 	const struct firmware *fw;
 
-
 	/* don't re-upload unless necessary */
-	if (tda1004x_check_upload_ok(state, 0x2c) == 0) return 0;
+	if (tda1004x_check_upload_ok(state, 0x2c) == 0)
+		return 0;
 
 	/* request the firmware, this will block until someone uploads it */
 	printk("tda1004x: waiting for firmware upload (%s)...\n", TDA10045_DEFAULT_FIRMWARE);
@@ -394,7 +393,8 @@ static int tda10046_fwupload(struct dvb_
 	msleep(100);
 
 	/* don't re-upload unless necessary */
-	if (tda1004x_check_upload_ok(state, 0x20) == 0) return 0;
+	if (tda1004x_check_upload_ok(state, 0x20) == 0)
+		return 0;
 
 	/* request the firmware, this will block until someone uploads it */
 	printk("tda1004x: waiting for firmware upload (%s)...\n", TDA10046_DEFAULT_FIRMWARE);
@@ -419,7 +419,7 @@ static int tda10046_fwupload(struct dvb_
 
 	/* wait for DSP to initialise */
 	timeout = jiffies + HZ;
-	while(!(tda1004x_read_byte(state, TDA1004X_STATUS_CD) & 0x20)) {
+	while (!(tda1004x_read_byte(state, TDA1004X_STATUS_CD) & 0x20)) {
 		if (time_after(jiffies, timeout)) {
 			printk("tda1004x: DSP failed to initialised.\n");
 			return -EIO;
@@ -483,7 +483,8 @@ static int tda10045_init(struct dvb_fron
 
 	dprintk("%s\n", __FUNCTION__);
 
-	if (state->initialised) return 0;
+	if (state->initialised)
+		return 0;
 
 	if (tda10045_fwupload(fe)) {
 		printk("tda1004x: firmware upload failed\n");
@@ -523,7 +524,8 @@ static int tda10046_init(struct dvb_fron
 	struct tda1004x_state* state = fe->demodulator_priv;
 	dprintk("%s\n", __FUNCTION__);
 
-	if (state->initialised) return 0;
+	if (state->initialised)
+		return 0;
 
 	if (tda10046_fwupload(fe)) {
 		printk("tda1004x: firmware upload failed\n");
@@ -621,12 +623,14 @@ static int tda1004x_set_fe(struct dvb_fr
 
 		// set HP FEC
 		tmp = tda1004x_encode_fec(fe_params->u.ofdm.code_rate_HP);
-		if (tmp < 0) return tmp;
+		if (tmp < 0)
+			return tmp;
 		tda1004x_write_mask(state, TDA1004X_IN_CONF2, 7, tmp);
 
 		// set LP FEC
 		tmp = tda1004x_encode_fec(fe_params->u.ofdm.code_rate_LP);
-		if (tmp < 0) return tmp;
+		if (tmp < 0)
+			return tmp;
 		tda1004x_write_mask(state, TDA1004X_IN_CONF2, 0x38, tmp << 3);
 
 		// set constellation
@@ -671,7 +675,7 @@ static int tda1004x_set_fe(struct dvb_fr
 	}
 
 	// set bandwidth
-	switch(state->demod_type) {
+	switch (state->demod_type) {
 	case TDA1004X_DEMOD_TDA10045:
 		tda10045h_set_bandwidth(state, fe_params->u.ofdm.bandwidth);
 		break;
@@ -683,7 +687,8 @@ static int tda1004x_set_fe(struct dvb_fr
 
 	// set inversion
 	inversion = fe_params->inversion;
-	if (state->config->invert) inversion = inversion ? INVERSION_OFF : INVERSION_ON;
+	if (state->config->invert)
+		inversion = inversion ? INVERSION_OFF : INVERSION_ON;
 	switch (inversion) {
 	case INVERSION_OFF:
 		tda1004x_write_mask(state, TDA1004X_CONFC1, 0x20, 0);
@@ -750,19 +755,19 @@ static int tda1004x_set_fe(struct dvb_fr
 	}
 
 	// start the lock
-	switch(state->demod_type) {
+	switch (state->demod_type) {
 	case TDA1004X_DEMOD_TDA10045:
 		tda1004x_write_mask(state, TDA1004X_CONFC4, 8, 8);
 		tda1004x_write_mask(state, TDA1004X_CONFC4, 8, 0);
-		msleep(10);
 		break;
 
 	case TDA1004X_DEMOD_TDA10046:
 		tda1004x_write_mask(state, TDA1004X_AUTO, 0x40, 0x40);
-		msleep(10);
 		break;
 	}
 
+	msleep(10);
+
 	return 0;
 }
 
@@ -773,13 +778,13 @@ static int tda1004x_get_fe(struct dvb_fr
 
 	// inversion status
 	fe_params->inversion = INVERSION_OFF;
-	if (tda1004x_read_byte(state, TDA1004X_CONFC1) & 0x20) {
+	if (tda1004x_read_byte(state, TDA1004X_CONFC1) & 0x20)
 		fe_params->inversion = INVERSION_ON;
-	}
-	if (state->config->invert) fe_params->inversion = fe_params->inversion ? INVERSION_OFF : INVERSION_ON;
+	if (state->config->invert)
+		fe_params->inversion = fe_params->inversion ? INVERSION_OFF : INVERSION_ON;
 
 	// bandwidth
-	switch(state->demod_type) {
+	switch (state->demod_type) {
 	case TDA1004X_DEMOD_TDA10045:
 		switch (tda1004x_read_byte(state, TDA10045H_WREF_LSB)) {
 		case 0x14:
@@ -830,9 +835,8 @@ static int tda1004x_get_fe(struct dvb_fr
 
 	// transmission mode
 	fe_params->u.ofdm.transmission_mode = TRANSMISSION_MODE_2K;
-	if (tda1004x_read_byte(state, TDA1004X_OUT_CONF1) & 0x10) {
+	if (tda1004x_read_byte(state, TDA1004X_OUT_CONF1) & 0x10)
 		fe_params->u.ofdm.transmission_mode = TRANSMISSION_MODE_8K;
-	}
 
 	// guard interval
 	switch ((tda1004x_read_byte(state, TDA1004X_OUT_CONF1) & 0x0c) >> 2) {
@@ -880,30 +884,33 @@ static int tda1004x_read_status(struct d
 
 	// read status
 	status = tda1004x_read_byte(state, TDA1004X_STATUS_CD);
-	if (status == -1) {
+	if (status == -1)
 		return -EIO;
-	}
 
 	// decode
 	*fe_status = 0;
-	if (status & 4) *fe_status |= FE_HAS_SIGNAL;
-	if (status & 2) *fe_status |= FE_HAS_CARRIER;
-	if (status & 8) *fe_status |= FE_HAS_VITERBI | FE_HAS_SYNC | FE_HAS_LOCK;
+	if (status & 4)
+		*fe_status |= FE_HAS_SIGNAL;
+	if (status & 2)
+		*fe_status |= FE_HAS_CARRIER;
+	if (status & 8)
+		*fe_status |= FE_HAS_VITERBI | FE_HAS_SYNC | FE_HAS_LOCK;
 
 	// if we don't already have VITERBI (i.e. not LOCKED), see if the viterbi
 	// is getting anything valid
 	if (!(*fe_status & FE_HAS_VITERBI)) {
 		// read the CBER
 		cber = tda1004x_read_byte(state, TDA1004X_CBER_LSB);
-		if (cber == -1) return -EIO;
+		if (cber == -1)
+			return -EIO;
 		status = tda1004x_read_byte(state, TDA1004X_CBER_MSB);
-		if (status == -1) return -EIO;
+		if (status == -1)
+			return -EIO;
 		cber |= (status << 8);
 		tda1004x_read_byte(state, TDA1004X_CBER_RESET);
 
-		if (cber != 65535) {
+		if (cber != 65535)
 			*fe_status |= FE_HAS_VITERBI;
-		}
 	}
 
 	// if we DO have some valid VITERBI output, but don't already have SYNC
@@ -911,20 +918,22 @@ static int tda1004x_read_status(struct d
 	if ((*fe_status & FE_HAS_VITERBI) && (!(*fe_status & FE_HAS_SYNC))) {
 		// read the VBER
 		vber = tda1004x_read_byte(state, TDA1004X_VBER_LSB);
-		if (vber == -1) return -EIO;
+		if (vber == -1)
+			return -EIO;
 		status = tda1004x_read_byte(state, TDA1004X_VBER_MID);
-		if (status == -1) return -EIO;
+		if (status == -1)
+			return -EIO;
 		vber |= (status << 8);
 		status = tda1004x_read_byte(state, TDA1004X_VBER_MSB);
-		if (status == -1) return -EIO;
+		if (status == -1)
+			return -EIO;
 		vber |= ((status << 16) & 0x0f);
 		tda1004x_read_byte(state, TDA1004X_CVBER_LUT);
 
 		// if RS has passed some valid TS packets, then we must be
 		// getting some SYNC bytes
-		if (vber < 16632) {
+		if (vber < 16632)
 			*fe_status |= FE_HAS_SYNC;
-		}
 	}
 
 	// success
@@ -941,7 +950,7 @@ static int tda1004x_read_signal_strength
 	dprintk("%s\n", __FUNCTION__);
 
 	// determine the register to use
-	switch(state->demod_type) {
+	switch (state->demod_type) {
 	case TDA1004X_DEMOD_TDA10045:
 		reg = TDA10045H_S_AGC;
 		break;
@@ -972,9 +981,8 @@ static int tda1004x_read_snr(struct dvb_
 	tmp = tda1004x_read_byte(state, TDA1004X_SNR);
 	if (tmp < 0)
 		return -EIO;
-	if (tmp) {
+	if (tmp)
 		tmp = 255 - tmp;
-	}
 
 	*snr = ((tmp << 8) | tmp);
 	dprintk("%s: snr=0x%x\n", __FUNCTION__, *snr);
@@ -1009,11 +1017,11 @@ static int tda1004x_read_ucblocks(struct
 			break;
 	}
 
-	if (tmp != 0x7f) {
+	if (tmp != 0x7f)
 		*ucblocks = tmp;
-	} else {
+	else
 		*ucblocks = 0xffffffff;
-	}
+
 	dprintk("%s: ucblocks=0x%x\n", __FUNCTION__, *ucblocks);
 	return 0;
 }
@@ -1027,10 +1035,12 @@ static int tda1004x_read_ber(struct dvb_
 
 	// read it in
 	tmp = tda1004x_read_byte(state, TDA1004X_CBER_LSB);
-	if (tmp < 0) return -EIO;
+	if (tmp < 0)
+		return -EIO;
 	*ber = tmp << 1;
 	tmp = tda1004x_read_byte(state, TDA1004X_CBER_MSB);
-	if (tmp < 0) return -EIO;
+	if (tmp < 0)
+		return -EIO;
 	*ber |= (tmp << 9);
 	tda1004x_read_byte(state, TDA1004X_CBER_RESET);
 
@@ -1042,7 +1052,7 @@ static int tda1004x_sleep(struct dvb_fro
 {
 	struct tda1004x_state* state = fe->demodulator_priv;
 
-	switch(state->demod_type) {
+	switch (state->demod_type) {
 	case TDA1004X_DEMOD_TDA10045:
 		tda1004x_write_mask(state, TDA1004X_CONFADC1, 0x10, 0x10);
 		break;
@@ -1066,74 +1076,11 @@ static int tda1004x_get_tune_settings(st
 
 static void tda1004x_release(struct dvb_frontend* fe)
 {
-	struct tda1004x_state* state = (struct tda1004x_state*) fe->demodulator_priv;
+	struct tda1004x_state *state = fe->demodulator_priv;
 	kfree(state);
 }
 
-static struct dvb_frontend_ops tda10045_ops;
-
-struct dvb_frontend* tda10045_attach(const struct tda1004x_config* config,
-				     struct i2c_adapter* i2c)
-{
-	struct tda1004x_state* state = NULL;
-
-	/* allocate memory for the internal state */
-	state = (struct tda1004x_state*) kmalloc(sizeof(struct tda1004x_state), GFP_KERNEL);
-	if (state == NULL) goto error;
-
-	/* setup the state */
-	state->config = config;
-	state->i2c = i2c;
-	memcpy(&state->ops, &tda10045_ops, sizeof(struct dvb_frontend_ops));
-	state->initialised = 0;
-	state->demod_type = TDA1004X_DEMOD_TDA10045;
-
-	/* check if the demod is there */
-	if (tda1004x_read_byte(state, TDA1004X_CHIPID) != 0x25) goto error;
-
-	/* create dvb_frontend */
-	state->frontend.ops = &state->ops;
-	state->frontend.demodulator_priv = state;
-	return &state->frontend;
-
-error:
-	kfree(state);
-	return NULL;
-}
-
-static struct dvb_frontend_ops tda10046_ops;
-
-struct dvb_frontend* tda10046_attach(const struct tda1004x_config* config,
-				     struct i2c_adapter* i2c)
-{
-	struct tda1004x_state* state = NULL;
-
-	/* allocate memory for the internal state */
-	state = (struct tda1004x_state*) kmalloc(sizeof(struct tda1004x_state), GFP_KERNEL);
-	if (state == NULL) goto error;
-
-	/* setup the state */
-	state->config = config;
-	state->i2c = i2c;
-	memcpy(&state->ops, &tda10046_ops, sizeof(struct dvb_frontend_ops));
-	state->initialised = 0;
-	state->demod_type = TDA1004X_DEMOD_TDA10046;
-
-	/* check if the demod is there */
-	if (tda1004x_read_byte(state, TDA1004X_CHIPID) != 0x46) goto error;
-
-	/* create dvb_frontend */
-	state->frontend.ops = &state->ops;
-	state->frontend.demodulator_priv = state;
-	return &state->frontend;
-
-error:
-	if (state) kfree(state);
-	return NULL;
-}
-
 static struct dvb_frontend_ops tda10045_ops = {
-
 	.info = {
 		.name = "Philips TDA10045H DVB-T",
 		.type = FE_OFDM,
@@ -1163,8 +1110,36 @@ static struct dvb_frontend_ops tda10045_
 	.read_ucblocks = tda1004x_read_ucblocks,
 };
 
-static struct dvb_frontend_ops tda10046_ops = {
+struct dvb_frontend* tda10045_attach(const struct tda1004x_config* config,
+				     struct i2c_adapter* i2c)
+{
+	struct tda1004x_state *state;
+
+	/* allocate memory for the internal state */
+	state = kmalloc(sizeof(struct tda1004x_state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+
+	/* setup the state */
+	state->config = config;
+	state->i2c = i2c;
+	memcpy(&state->ops, &tda10045_ops, sizeof(struct dvb_frontend_ops));
+	state->initialised = 0;
+	state->demod_type = TDA1004X_DEMOD_TDA10045;
+
+	/* check if the demod is there */
+	if (tda1004x_read_byte(state, TDA1004X_CHIPID) != 0x25) {
+		kfree(state);
+		return NULL;
+	}
+
+	/* create dvb_frontend */
+	state->frontend.ops = &state->ops;
+	state->frontend.demodulator_priv = state;
+	return &state->frontend;
+}
 
+static struct dvb_frontend_ops tda10046_ops = {
 	.info = {
 		.name = "Philips TDA10046H DVB-T",
 		.type = FE_OFDM,
@@ -1194,6 +1169,35 @@ static struct dvb_frontend_ops tda10046_
 	.read_ucblocks = tda1004x_read_ucblocks,
 };
 
+struct dvb_frontend* tda10046_attach(const struct tda1004x_config* config,
+				     struct i2c_adapter* i2c)
+{
+	struct tda1004x_state *state;
+
+	/* allocate memory for the internal state */
+	state = kmalloc(sizeof(struct tda1004x_state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+
+	/* setup the state */
+	state->config = config;
+	state->i2c = i2c;
+	memcpy(&state->ops, &tda10046_ops, sizeof(struct dvb_frontend_ops));
+	state->initialised = 0;
+	state->demod_type = TDA1004X_DEMOD_TDA10046;
+
+	/* check if the demod is there */
+	if (tda1004x_read_byte(state, TDA1004X_CHIPID) != 0x46) {
+		kfree(state);
+		return NULL;
+	}
+
+	/* create dvb_frontend */
+	state->frontend.ops = &state->ops;
+	state->frontend.demodulator_priv = state;
+	return &state->frontend;
+}
+
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 

--

