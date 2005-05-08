Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbVEHUTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbVEHUTy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVEHUTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:19:34 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:1687 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262934AbVEHTKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:10 -0400
Message-Id: <20050508184347.234443000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:45 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 16/37] remove unnecessary casts in frontends
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary casts in frontends (Kenneth Aafloy)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/at76c651.c     |   18 +++++++-------
 drivers/media/dvb/frontends/cx22700.c      |   20 ++++++++--------
 drivers/media/dvb/frontends/cx22702.c      |   20 ++++++++--------
 drivers/media/dvb/frontends/cx24110.c      |   31 ++++++++++++------------
 drivers/media/dvb/frontends/dib3000mb.c    |   26 ++++++++++----------
 drivers/media/dvb/frontends/dib3000mc.c    |   24 +++++++++----------
 drivers/media/dvb/frontends/dvb_dummy_fe.c |    8 +++---
 drivers/media/dvb/frontends/l64781.c       |   22 ++++++++---------
 drivers/media/dvb/frontends/mt312.c        |   32 ++++++++++++-------------
 drivers/media/dvb/frontends/nxt2002.c      |   20 ++++++++--------
 drivers/media/dvb/frontends/nxt6000.c      |   18 +++++++-------
 drivers/media/dvb/frontends/or51132.c      |   14 +++++------
 drivers/media/dvb/frontends/sp8870.c       |   20 ++++++++--------
 drivers/media/dvb/frontends/sp887x.c       |   22 ++++++++---------
 drivers/media/dvb/frontends/stv0297.c      |   24 +++++++++----------
 drivers/media/dvb/frontends/stv0299.c      |   36 ++++++++++++++---------------
 drivers/media/dvb/frontends/tda10021.c     |   22 ++++++++---------
 drivers/media/dvb/frontends/tda8083.c      |   26 ++++++++++----------
 drivers/media/dvb/frontends/tda80xx.c      |   34 +++++++++++++--------------
 drivers/media/dvb/frontends/ves1820.c      |   22 ++++++++---------
 drivers/media/dvb/frontends/ves1x93.c      |   24 +++++++++----------
 21 files changed, 241 insertions(+), 242 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/at76c651.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/at76c651.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/at76c651.c	2005-05-08 16:21:47.000000000 +0200
@@ -259,7 +259,7 @@ static int at76c651_set_parameters(struc
 				   struct dvb_frontend_parameters *p)
 {
 	int ret;
-	struct at76c651_state* state = (struct at76c651_state*) fe->demodulator_priv;
+	struct at76c651_state* state = fe->demodulator_priv;
 
 	at76c651_writereg(state, 0x0c, 0xc3);
 	state->config->pll_set(fe, p);
@@ -276,7 +276,7 @@ static int at76c651_set_parameters(struc
 
 static int at76c651_set_defaults(struct dvb_frontend* fe)
 {
-	struct at76c651_state* state = (struct at76c651_state*) fe->demodulator_priv;
+	struct at76c651_state* state = fe->demodulator_priv;
 
 	at76c651_set_symbol_rate(state, 6900000);
 	at76c651_set_qam(state, QAM_64);
@@ -294,7 +294,7 @@ static int at76c651_set_defaults(struct 
 
 static int at76c651_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct at76c651_state* state = (struct at76c651_state*) fe->demodulator_priv;
+	struct at76c651_state* state = fe->demodulator_priv;
 	u8 sync;
 
 	/*
@@ -319,7 +319,7 @@ static int at76c651_read_status(struct d
 
 static int at76c651_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct at76c651_state* state = (struct at76c651_state*) fe->demodulator_priv;
+	struct at76c651_state* state = fe->demodulator_priv;
 
 	*ber = (at76c651_readreg(state, 0x81) & 0x0F) << 16;
 	*ber |= at76c651_readreg(state, 0x82) << 8;
@@ -331,7 +331,7 @@ static int at76c651_read_ber(struct dvb_
 
 static int at76c651_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-	struct at76c651_state* state = (struct at76c651_state*) fe->demodulator_priv;
+	struct at76c651_state* state = fe->demodulator_priv;
 
 	u8 gain = ~at76c651_readreg(state, 0x91);
 	*strength = (gain << 8) | gain;
@@ -341,7 +341,7 @@ static int at76c651_read_signal_strength
 
 static int at76c651_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct at76c651_state* state = (struct at76c651_state*) fe->demodulator_priv;
+	struct at76c651_state* state = fe->demodulator_priv;
 
 	*snr = 0xFFFF -
 	    ((at76c651_readreg(state, 0x8F) << 8) |
@@ -352,7 +352,7 @@ static int at76c651_read_snr(struct dvb_
 
 static int at76c651_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct at76c651_state* state = (struct at76c651_state*) fe->demodulator_priv;
+	struct at76c651_state* state = fe->demodulator_priv;
 
 	*ucblocks = at76c651_readreg(state, 0x82);
 
@@ -369,7 +369,7 @@ static int at76c651_get_tune_settings(st
 
 static void at76c651_release(struct dvb_frontend* fe)
 {
-	struct at76c651_state* state = (struct at76c651_state*) fe->demodulator_priv;
+	struct at76c651_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -381,7 +381,7 @@ struct dvb_frontend* at76c651_attach(con
 	struct at76c651_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct at76c651_state*) kmalloc(sizeof(struct at76c651_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct at76c651_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/cx22700.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/cx22700.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/cx22700.c	2005-05-08 16:21:47.000000000 +0200
@@ -232,7 +232,7 @@ static int cx22700_get_tps (struct cx227
 
 static int cx22700_init (struct dvb_frontend* fe)
 
-{	struct cx22700_state* state = (struct cx22700_state*) fe->demodulator_priv;
+{	struct cx22700_state* state = fe->demodulator_priv;
 	int i;
 
 	dprintk("cx22700_init: init chip\n");
@@ -258,7 +258,7 @@ static int cx22700_init (struct dvb_fron
 
 static int cx22700_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct cx22700_state* state = (struct cx22700_state*) fe->demodulator_priv;
+	struct cx22700_state* state = fe->demodulator_priv;
 
 	u16 rs_ber = (cx22700_readreg (state, 0x0d) << 9)
 		   | (cx22700_readreg (state, 0x0e) << 1);
@@ -286,7 +286,7 @@ static int cx22700_read_status(struct dv
 
 static int cx22700_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct cx22700_state* state = (struct cx22700_state*) fe->demodulator_priv;
+	struct cx22700_state* state = fe->demodulator_priv;
 
 	*ber = cx22700_readreg (state, 0x0c) & 0x7f;
 	cx22700_writereg (state, 0x0c, 0x00);
@@ -296,7 +296,7 @@ static int cx22700_read_ber(struct dvb_f
 
 static int cx22700_read_signal_strength(struct dvb_frontend* fe, u16* signal_strength)
 {
-	struct cx22700_state* state = (struct cx22700_state*) fe->demodulator_priv;
+	struct cx22700_state* state = fe->demodulator_priv;
 
 	u16 rs_ber = (cx22700_readreg (state, 0x0d) << 9)
 		   | (cx22700_readreg (state, 0x0e) << 1);
@@ -307,7 +307,7 @@ static int cx22700_read_signal_strength(
 
 static int cx22700_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct cx22700_state* state = (struct cx22700_state*) fe->demodulator_priv;
+	struct cx22700_state* state = fe->demodulator_priv;
 
 	u16 rs_ber = (cx22700_readreg (state, 0x0d) << 9)
 		   | (cx22700_readreg (state, 0x0e) << 1);
@@ -318,7 +318,7 @@ static int cx22700_read_snr(struct dvb_f
 
 static int cx22700_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct cx22700_state* state = (struct cx22700_state*) fe->demodulator_priv;
+	struct cx22700_state* state = fe->demodulator_priv;
 
 	*ucblocks = cx22700_readreg (state, 0x0f);
 	cx22700_writereg (state, 0x0f, 0x00);
@@ -328,7 +328,7 @@ static int cx22700_read_ucblocks(struct 
 
 static int cx22700_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct cx22700_state* state = (struct cx22700_state*) fe->demodulator_priv;
+	struct cx22700_state* state = fe->demodulator_priv;
 
 	cx22700_writereg (state, 0x00, 0x02); /* XXX CHECKME: soft reset*/
 	cx22700_writereg (state, 0x00, 0x00);
@@ -346,7 +346,7 @@ static int cx22700_set_frontend(struct d
 
 static int cx22700_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct cx22700_state* state = (struct cx22700_state*) fe->demodulator_priv;
+	struct cx22700_state* state = fe->demodulator_priv;
 	u8 reg09 = cx22700_readreg (state, 0x09);
 
 	p->inversion = reg09 & 0x1 ? INVERSION_ON : INVERSION_OFF;
@@ -363,7 +363,7 @@ static int cx22700_get_tune_settings(str
 
 static void cx22700_release(struct dvb_frontend* fe)
 {
-	struct cx22700_state* state = (struct cx22700_state*) fe->demodulator_priv;
+	struct cx22700_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -375,7 +375,7 @@ struct dvb_frontend* cx22700_attach(cons
 	struct cx22700_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct cx22700_state*) kmalloc(sizeof(struct cx22700_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct cx22700_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/cx22702.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/cx22702.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/cx22702.c	2005-05-08 16:21:47.000000000 +0200
@@ -200,7 +200,7 @@ static int cx22702_get_tps (struct cx227
 static int cx22702_set_tps (struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
 	u8 val;
-	struct cx22702_state* state = (struct cx22702_state*) fe->demodulator_priv;
+	struct cx22702_state* state = fe->demodulator_priv;
 
 	/* set PLL */
         cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) &0xfe);
@@ -338,7 +338,7 @@ static int cx22702_set_tps (struct dvb_f
 static int cx22702_init (struct dvb_frontend* fe)
 {
 	int i;
-	struct cx22702_state* state = (struct cx22702_state*) fe->demodulator_priv;
+	struct cx22702_state* state = fe->demodulator_priv;
 
 	cx22702_writereg (state, 0x00, 0x02);
 
@@ -360,7 +360,7 @@ static int cx22702_init (struct dvb_fron
 
 static int cx22702_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct cx22702_state* state = (struct cx22702_state*) fe->demodulator_priv;
+	struct cx22702_state* state = fe->demodulator_priv;
 	u8 reg0A;
 	u8 reg23;
 
@@ -389,7 +389,7 @@ static int cx22702_read_status(struct dv
 
 static int cx22702_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct cx22702_state* state = (struct cx22702_state*) fe->demodulator_priv;
+	struct cx22702_state* state = fe->demodulator_priv;
 
 	if(cx22702_readreg (state, 0xE4) & 0x02) {
 		/* Realtime statistics */
@@ -406,7 +406,7 @@ static int cx22702_read_ber(struct dvb_f
 
 static int cx22702_read_signal_strength(struct dvb_frontend* fe, u16* signal_strength)
 {
-	struct cx22702_state* state = (struct cx22702_state*) fe->demodulator_priv;
+	struct cx22702_state* state = fe->demodulator_priv;
 
 	*signal_strength = cx22702_readreg (state, 0x23);
 
@@ -415,7 +415,7 @@ static int cx22702_read_signal_strength(
 
 static int cx22702_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct cx22702_state* state = (struct cx22702_state*) fe->demodulator_priv;
+	struct cx22702_state* state = fe->demodulator_priv;
 
 	u16 rs_ber=0;
 	if(cx22702_readreg (state, 0xE4) & 0x02) {
@@ -434,7 +434,7 @@ static int cx22702_read_snr(struct dvb_f
 
 static int cx22702_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct cx22702_state* state = (struct cx22702_state*) fe->demodulator_priv;
+	struct cx22702_state* state = fe->demodulator_priv;
 
 	u8 _ucblocks;
 
@@ -449,7 +449,7 @@ static int cx22702_read_ucblocks(struct 
 
 static int cx22702_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct cx22702_state* state = (struct cx22702_state*) fe->demodulator_priv;
+	struct cx22702_state* state = fe->demodulator_priv;
 
 	u8 reg0C = cx22702_readreg (state, 0x0C);
 
@@ -459,7 +459,7 @@ static int cx22702_get_frontend(struct d
 
 static void cx22702_release(struct dvb_frontend* fe)
 {
-	struct cx22702_state* state = (struct cx22702_state*) fe->demodulator_priv;
+	struct cx22702_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -471,7 +471,7 @@ struct dvb_frontend* cx22702_attach(cons
 	struct cx22702_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct cx22702_state*) kmalloc(sizeof(struct cx22702_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct cx22702_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/cx24110.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/cx24110.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/cx24110.c	2005-05-08 16:21:47.000000000 +0200
@@ -315,7 +315,7 @@ dprintk("cx24110 debug: entering %s(%d)\
 
 int cx24110_pll_write (struct dvb_frontend* fe, u32 data)
 {
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 
 /* tuner data is 21 bits long, must be left-aligned in data */
 /* tuner cx24108 is written through a dedicated 3wire interface on the demod chip */
@@ -356,7 +356,7 @@ int cx24110_pll_write (struct dvb_fronte
 
 static int cx24110_initfe(struct dvb_frontend* fe)
 {
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 /* fixme (low): error handling */
         int i;
 
@@ -373,7 +373,7 @@ static int cx24110_initfe(struct dvb_fro
 
 static int cx24110_set_voltage (struct dvb_frontend* fe, fe_sec_voltage_t voltage)
 {
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 
 	switch (voltage) {
 	case SEC_VOLTAGE_13:
@@ -385,8 +385,7 @@ static int cx24110_set_voltage (struct d
 	};
 }
 
-static int cx24110_diseqc_send_burst(struct dvb_frontend* fe,
-			fe_sec_mini_cmd_t burst)
+static int cx24110_diseqc_send_burst(struct dvb_frontend* fe, fe_sec_mini_cmd_t burst)
 {
 	int rv, bit, i;
 	struct cx24110_state *state = fe->demodulator_priv;
@@ -413,7 +412,7 @@ static int cx24110_send_diseqc_msg(struc
 				   struct dvb_diseqc_master_cmd *cmd)
 {
 	int i, rv;
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 
 	for (i = 0; i < cmd->msg_len; i++)
 		cx24110_writereg(state, 0x79 + i, cmd->msg[i]);
@@ -432,7 +431,7 @@ static int cx24110_send_diseqc_msg(struc
 
 static int cx24110_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 
 	int sync = cx24110_readreg (state, 0x55);
 
@@ -460,7 +459,7 @@ static int cx24110_read_status(struct dv
 
 static int cx24110_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 
 	/* fixme (maybe): value range is 16 bit. Scale? */
 	if(cx24110_readreg(state,0x24)&0x10) {
@@ -478,7 +477,7 @@ static int cx24110_read_ber(struct dvb_f
 
 static int cx24110_read_signal_strength(struct dvb_frontend* fe, u16* signal_strength)
 {
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 
 /* no provision in hardware. Read the frontend AGC accumulator. No idea how to scale this, but I know it is 2s complement */
 	u8 signal = cx24110_readreg (state, 0x27)+128;
@@ -489,7 +488,7 @@ static int cx24110_read_signal_strength(
 
 static int cx24110_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 
 	/* no provision in hardware. Can be computed from the Es/N0 estimator, but I don't know how. */
 	if(cx24110_readreg(state,0x6a)&0x80) {
@@ -505,7 +504,7 @@ static int cx24110_read_snr(struct dvb_f
 
 static int cx24110_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 	u32 lastbyer;
 
 	if(cx24110_readreg(state,0x10)&0x40) {
@@ -527,7 +526,7 @@ static int cx24110_read_ucblocks(struct 
 
 static int cx24110_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 
 	state->config->pll_set(fe, p);
 	cx24110_set_inversion (state, p->inversion);
@@ -540,7 +539,7 @@ static int cx24110_set_frontend(struct d
 
 static int cx24110_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 	s32 afc; unsigned sclk;
 
 /* cannot read back tuner settings (freq). Need to have some private storage */
@@ -567,14 +566,14 @@ static int cx24110_get_frontend(struct d
 
 static int cx24110_set_tone(struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
 {
-	struct cx24110_state *state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state *state = fe->demodulator_priv;
 
 	return cx24110_writereg(state,0x76,(cx24110_readreg(state,0x76)&~0x10)|(((tone==SEC_TONE_ON))?0x10:0));
 }
 
 static void cx24110_release(struct dvb_frontend* fe)
 {
-	struct cx24110_state* state = (struct cx24110_state*) fe->demodulator_priv;
+	struct cx24110_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -587,7 +586,7 @@ struct dvb_frontend* cx24110_attach(cons
 	int ret;
 
 	/* allocate memory for the internal state */
-	state = (struct cx24110_state*) kmalloc(sizeof(struct cx24110_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct cx24110_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/dib3000mb.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/dib3000mb.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/dib3000mb.c	2005-05-08 16:21:47.000000000 +0200
@@ -56,7 +56,7 @@ static int dib3000mb_get_frontend(struct
 static int dib3000mb_set_frontend(struct dvb_frontend* fe,
 				  struct dvb_frontend_parameters *fep, int tuner)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
 	fe_code_rate_t fe_cr = FEC_NONE;
 	int search_state, seq;
@@ -317,7 +317,7 @@ static int dib3000mb_set_frontend(struct
 
 static int dib3000mb_fe_init(struct dvb_frontend* fe, int mobile_mode)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 
 	deb_info("dib3000mb is getting up.\n");
 	wr(DIB3000MB_REG_POWER_CONTROL, DIB3000MB_POWER_UP);
@@ -401,7 +401,7 @@ static int dib3000mb_fe_init(struct dvb_
 static int dib3000mb_get_frontend(struct dvb_frontend* fe,
 				  struct dvb_frontend_parameters *fep)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
 	fe_code_rate_t *cr;
 	u16 tps_val;
@@ -562,7 +562,7 @@ static int dib3000mb_get_frontend(struct
 
 static int dib3000mb_read_status(struct dvb_frontend* fe, fe_status_t *stat)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 
 	*stat = 0;
 
@@ -594,7 +594,7 @@ static int dib3000mb_read_status(struct 
 
 static int dib3000mb_read_ber(struct dvb_frontend* fe, u32 *ber)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 
 	*ber = ((rd(DIB3000MB_REG_BER_MSB) << 16) | rd(DIB3000MB_REG_BER_LSB));
 	return 0;
@@ -603,7 +603,7 @@ static int dib3000mb_read_ber(struct dvb
 /* see dib3000-watch dvb-apps for exact calcuations of signal_strength and snr */
 static int dib3000mb_read_signal_strength(struct dvb_frontend* fe, u16 *strength)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 
 	*strength = rd(DIB3000MB_REG_SIGNAL_POWER) * 0xffff / 0x170;
 	return 0;
@@ -611,7 +611,7 @@ static int dib3000mb_read_signal_strengt
 
 static int dib3000mb_read_snr(struct dvb_frontend* fe, u16 *snr)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 	short sigpow = rd(DIB3000MB_REG_SIGNAL_POWER);
 	int icipow = ((rd(DIB3000MB_REG_NOISE_POWER_MSB) & 0xff) << 16) |
 		rd(DIB3000MB_REG_NOISE_POWER_LSB);
@@ -621,7 +621,7 @@ static int dib3000mb_read_snr(struct dvb
 
 static int dib3000mb_read_unc_blocks(struct dvb_frontend* fe, u32 *unc)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 
 	*unc = rd(DIB3000MB_REG_UNC);
 	return 0;
@@ -629,7 +629,7 @@ static int dib3000mb_read_unc_blocks(str
 
 static int dib3000mb_sleep(struct dvb_frontend* fe)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 	deb_info("dib3000mb is going to bed.\n");
 	wr(DIB3000MB_REG_POWER_CONTROL, DIB3000MB_POWER_DOWN);
 	return 0;
@@ -656,7 +656,7 @@ static int dib3000mb_set_frontend_and_tu
 
 static void dib3000mb_release(struct dvb_frontend* fe)
 {
-	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state *state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -671,7 +671,7 @@ static int dib3000mb_pid_control(struct 
 
 static int dib3000mb_fifo_control(struct dvb_frontend *fe, int onoff)
 {
-	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state *state = fe->demodulator_priv;
 
 	deb_xfer("%s fifo\n",onoff ? "enabling" : "disabling");
 	if (onoff) {
@@ -692,7 +692,7 @@ static int dib3000mb_pid_parse(struct dv
 
 static int dib3000mb_tuner_pass_ctrl(struct dvb_frontend *fe, int onoff, u8 pll_addr)
 {
-	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state *state = fe->demodulator_priv;
 	if (onoff) {
 		wr(DIB3000MB_REG_TUNER, DIB3000_TUNER_WRITE_ENABLE(pll_addr));
 	} else {
@@ -709,7 +709,7 @@ struct dvb_frontend* dib3000mb_attach(co
 	struct dib3000_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct dib3000_state*) kmalloc(sizeof(struct dib3000_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct dib3000_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
 	memset(state,0,sizeof(struct dib3000_state));
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/dib3000mc.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/dib3000mc.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/dib3000mc.c	2005-05-08 16:21:47.000000000 +0200
@@ -297,7 +297,7 @@ static int dib3000mc_set_general_cfg(str
 static int dib3000mc_get_frontend(struct dvb_frontend* fe,
 				  struct dvb_frontend_parameters *fep)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
 	fe_code_rate_t *cr;
 	u16 tps_val,cr_val;
@@ -458,7 +458,7 @@ static int dib3000mc_get_frontend(struct
 static int dib3000mc_set_frontend(struct dvb_frontend* fe,
 				  struct dvb_frontend_parameters *fep, int tuner)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
 	int search_state,auto_val;
 	u16 val;
@@ -659,7 +659,7 @@ static int dib3000mc_fe_init(struct dvb_
 }
 static int dib3000mc_read_status(struct dvb_frontend* fe, fe_status_t *stat)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 	u16 lock = rd(DIB3000MC_REG_LOCKING);
 
 	*stat = 0;
@@ -679,14 +679,14 @@ static int dib3000mc_read_status(struct 
 
 static int dib3000mc_read_ber(struct dvb_frontend* fe, u32 *ber)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 	*ber = ((rd(DIB3000MC_REG_BER_MSB) << 16) | rd(DIB3000MC_REG_BER_LSB));
 	return 0;
 }
 
 static int dib3000mc_read_unc_blocks(struct dvb_frontend* fe, u32 *unc)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 
 	*unc = rd(DIB3000MC_REG_PACKET_ERROR_COUNT);
 	return 0;
@@ -695,7 +695,7 @@ static int dib3000mc_read_unc_blocks(str
 /* see dib3000mb.c for calculation comments */
 static int dib3000mc_read_signal_strength(struct dvb_frontend* fe, u16 *strength)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 	u16 val = rd(DIB3000MC_REG_SIGNAL_NOISE_LSB);
 	*strength = (((val >> 6) & 0xff) << 8) + (val & 0x3f);
 
@@ -706,7 +706,7 @@ static int dib3000mc_read_signal_strengt
 /* see dib3000mb.c for calculation comments */
 static int dib3000mc_read_snr(struct dvb_frontend* fe, u16 *snr)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 	u16 val = rd(DIB3000MC_REG_SIGNAL_NOISE_LSB),
 		val2 = rd(DIB3000MC_REG_SIGNAL_NOISE_MSB);
 	u16 sig,noise;
@@ -726,7 +726,7 @@ static int dib3000mc_read_snr(struct dvb
 
 static int dib3000mc_sleep(struct dvb_frontend* fe)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state* state = fe->demodulator_priv;
 
 	set_or(DIB3000MC_REG_CLK_CFG_7,DIB3000MC_CLK_CFG_7_PWR_DOWN);
 	wr(DIB3000MC_REG_CLK_CFG_1,DIB3000MC_CLK_CFG_1_POWER_DOWN);
@@ -756,7 +756,7 @@ static int dib3000mc_set_frontend_and_tu
 
 static void dib3000mc_release(struct dvb_frontend* fe)
 {
-	struct dib3000_state *state = (struct dib3000_state *) fe->demodulator_priv;
+	struct dib3000_state *state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -771,7 +771,7 @@ static int dib3000mc_pid_control(struct 
 
 static int dib3000mc_fifo_control(struct dvb_frontend *fe, int onoff)
 {
-	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state *state = fe->demodulator_priv;
 	u16 tmp = rd(DIB3000MC_REG_SMO_MODE);
 
 	deb_xfer("%s fifo\n",onoff ? "enabling" : "disabling");
@@ -803,7 +803,7 @@ static int dib3000mc_pid_parse(struct dv
 
 static int dib3000mc_tuner_pass_ctrl(struct dvb_frontend *fe, int onoff, u8 pll_addr)
 {
-	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dib3000_state *state = fe->demodulator_priv;
 	if (onoff) {
 		wr(DIB3000MC_REG_TUNER, DIB3000_TUNER_WRITE_ENABLE(pll_addr));
 	} else {
@@ -844,7 +844,7 @@ struct dvb_frontend* dib3000mc_attach(co
 	u16 devid;
 
 	/* allocate memory for the internal state */
-	state = (struct dib3000_state*) kmalloc(sizeof(struct dib3000_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct dib3000_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
 	memset(state,0,sizeof(struct dib3000_state));
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/dvb_dummy_fe.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/dvb_dummy_fe.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/dvb_dummy_fe.c	2005-05-08 16:21:47.000000000 +0200
@@ -100,7 +100,7 @@ static int dvb_dummy_fe_set_voltage(stru
 
 static void dvb_dummy_fe_release(struct dvb_frontend* fe)
 {
-	struct dvb_dummy_fe_state* state = (struct dvb_dummy_fe_state*) fe->demodulator_priv;
+	struct dvb_dummy_fe_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -111,7 +111,7 @@ struct dvb_frontend* dvb_dummy_fe_ofdm_a
 	struct dvb_dummy_fe_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct dvb_dummy_fe_state*) kmalloc(sizeof(struct dvb_dummy_fe_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct dvb_dummy_fe_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
@@ -134,7 +134,7 @@ struct dvb_frontend* dvb_dummy_fe_qpsk_a
 	struct dvb_dummy_fe_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct dvb_dummy_fe_state*) kmalloc(sizeof(struct dvb_dummy_fe_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct dvb_dummy_fe_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
@@ -157,7 +157,7 @@ struct dvb_frontend* dvb_dummy_fe_qam_at
 	struct dvb_dummy_fe_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct dvb_dummy_fe_state*) kmalloc(sizeof(struct dvb_dummy_fe_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct dvb_dummy_fe_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/l64781.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/l64781.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/l64781.c	2005-05-08 16:21:47.000000000 +0200
@@ -121,7 +121,7 @@ static int reset_and_configure (struct l
 
 static int apply_frontend_param (struct dvb_frontend* fe, struct dvb_frontend_parameters *param)
 {
-	struct l64781_state* state = (struct l64781_state*) fe->demodulator_priv;
+	struct l64781_state* state = fe->demodulator_priv;
 	/* The coderates for FEC_NONE, FEC_4_5 and FEC_FEC_6_7 are arbitrary */
 	static const u8 fec_tab[] = { 7, 0, 1, 2, 9, 3, 10, 4 };
 	/* QPSK, QAM_16, QAM_64 */
@@ -234,7 +234,7 @@ static int apply_frontend_param (struct 
 
 static int get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters* param)
 {
-	struct l64781_state* state = (struct l64781_state*) fe->demodulator_priv;
+	struct l64781_state* state = fe->demodulator_priv;
 	int tmp;
 
 
@@ -352,7 +352,7 @@ static int get_frontend(struct dvb_front
 
 static int l64781_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct l64781_state* state = (struct l64781_state*) fe->demodulator_priv;
+	struct l64781_state* state = fe->demodulator_priv;
 	int sync = l64781_readreg (state, 0x32);
 	int gain = l64781_readreg (state, 0x0e);
 
@@ -381,7 +381,7 @@ static int l64781_read_status(struct dvb
 
 static int l64781_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct l64781_state* state = (struct l64781_state*) fe->demodulator_priv;
+	struct l64781_state* state = fe->demodulator_priv;
 
 	/*   XXX FIXME: set up counting period (reg 0x26...0x28)
 	 */
@@ -393,7 +393,7 @@ static int l64781_read_ber(struct dvb_fr
 
 static int l64781_read_signal_strength(struct dvb_frontend* fe, u16* signal_strength)
 {
-	struct l64781_state* state = (struct l64781_state*) fe->demodulator_priv;
+	struct l64781_state* state = fe->demodulator_priv;
 
 	u8 gain = l64781_readreg (state, 0x0e);
 	*signal_strength = (gain << 8) | gain;
@@ -403,7 +403,7 @@ static int l64781_read_signal_strength(s
 
 static int l64781_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct l64781_state* state = (struct l64781_state*) fe->demodulator_priv;
+	struct l64781_state* state = fe->demodulator_priv;
 
 	u8 avg_quality = 0xff - l64781_readreg (state, 0x33);
 	*snr = (avg_quality << 8) | avg_quality; /* not exact, but...*/
@@ -413,7 +413,7 @@ static int l64781_read_snr(struct dvb_fr
 
 static int l64781_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct l64781_state* state = (struct l64781_state*) fe->demodulator_priv;
+	struct l64781_state* state = fe->demodulator_priv;
 
 	*ucblocks = l64781_readreg (state, 0x37)
 	   | (l64781_readreg (state, 0x38) << 8);
@@ -423,7 +423,7 @@ static int l64781_read_ucblocks(struct d
 
 static int l64781_sleep(struct dvb_frontend* fe)
 {
-	struct l64781_state* state = (struct l64781_state*) fe->demodulator_priv;
+	struct l64781_state* state = fe->demodulator_priv;
 
 	/* Power down */
 	return l64781_writereg (state, 0x3e, 0x5a);
@@ -431,7 +431,7 @@ static int l64781_sleep(struct dvb_front
 
 static int l64781_init(struct dvb_frontend* fe)
 {
-	struct l64781_state* state = (struct l64781_state*) fe->demodulator_priv;
+	struct l64781_state* state = fe->demodulator_priv;
 
         reset_and_configure (state);
 
@@ -484,7 +484,7 @@ static int l64781_get_tune_settings(stru
 
 static void l64781_release(struct dvb_frontend* fe)
 {
-	struct l64781_state* state = (struct l64781_state*) fe->demodulator_priv;
+	struct l64781_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -501,7 +501,7 @@ struct dvb_frontend* l64781_attach(const
 			   { .addr = config->demod_address, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
 
 	/* allocate memory for the internal state */
-	state = (struct l64781_state*) kmalloc(sizeof(struct l64781_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct l64781_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/mt312.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/mt312.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/mt312.c	2005-05-08 16:21:47.000000000 +0200
@@ -226,7 +226,7 @@ static int mt312_get_code_rate(struct mt
 
 static int mt312_initfe(struct dvb_frontend* fe)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	int ret;
 	u8 buf[2];
 
@@ -287,7 +287,7 @@ static int mt312_initfe(struct dvb_front
 static int mt312_send_master_cmd(struct dvb_frontend* fe,
 				 struct dvb_diseqc_master_cmd *c)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	int ret;
 	u8 diseqc_mode;
 
@@ -318,7 +318,7 @@ static int mt312_send_master_cmd(struct 
 
 static int mt312_send_burst(struct dvb_frontend* fe, const fe_sec_mini_cmd_t c)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	const u8 mini_tab[2] = { 0x02, 0x03 };
 
 	int ret;
@@ -340,7 +340,7 @@ static int mt312_send_burst(struct dvb_f
 
 static int mt312_set_tone(struct dvb_frontend* fe, const fe_sec_tone_mode_t t)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	const u8 tone_tab[2] = { 0x01, 0x00 };
 
 	int ret;
@@ -362,7 +362,7 @@ static int mt312_set_tone(struct dvb_fro
 
 static int mt312_set_voltage(struct dvb_frontend* fe, const fe_sec_voltage_t v)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	const u8 volt_tab[3] = { 0x00, 0x40, 0x00 };
 
 	if (v > SEC_VOLTAGE_OFF)
@@ -373,7 +373,7 @@ static int mt312_set_voltage(struct dvb_
 
 static int mt312_read_status(struct dvb_frontend* fe, fe_status_t *s)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	int ret;
 	u8 status[3];
 
@@ -400,7 +400,7 @@ static int mt312_read_status(struct dvb_
 
 static int mt312_read_ber(struct dvb_frontend* fe, u32 *ber)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	int ret;
 	u8 buf[3];
 
@@ -414,7 +414,7 @@ static int mt312_read_ber(struct dvb_fro
 
 static int mt312_read_signal_strength(struct dvb_frontend* fe, u16 *signal_strength)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	int ret;
 	u8 buf[3];
 	u16 agc;
@@ -435,7 +435,7 @@ static int mt312_read_signal_strength(st
 
 static int mt312_read_snr(struct dvb_frontend* fe, u16 *snr)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	int ret;
 	u8 buf[2];
 
@@ -449,7 +449,7 @@ static int mt312_read_snr(struct dvb_fro
 
 static int mt312_read_ucblocks(struct dvb_frontend* fe, u32 *ubc)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	int ret;
 	u8 buf[2];
 
@@ -464,7 +464,7 @@ static int mt312_read_ucblocks(struct dv
 static int mt312_set_frontend(struct dvb_frontend* fe,
 			      struct dvb_frontend_parameters *p)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	int ret;
 	u8 buf[5], config_val;
 	u16 sr;
@@ -560,7 +560,7 @@ static int mt312_set_frontend(struct dvb
 static int mt312_get_frontend(struct dvb_frontend* fe,
 			      struct dvb_frontend_parameters *p)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	int ret;
 
 	if ((ret = mt312_get_inversion(state, &p->inversion)) < 0)
@@ -577,7 +577,7 @@ static int mt312_get_frontend(struct dvb
 
 static int mt312_sleep(struct dvb_frontend* fe)
 {
-	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state *state = fe->demodulator_priv;
 	int ret;
 	u8 config;
 
@@ -605,7 +605,7 @@ static int mt312_get_tune_settings(struc
 
 static void mt312_release(struct dvb_frontend* fe)
 {
-	struct mt312_state* state = (struct mt312_state*) fe->demodulator_priv;
+	struct mt312_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -617,7 +617,7 @@ struct dvb_frontend* vp310_attach(const 
 	struct mt312_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct mt312_state*) kmalloc(sizeof(struct mt312_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct mt312_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
 
@@ -651,7 +651,7 @@ struct dvb_frontend* mt312_attach(const 
 	struct mt312_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct mt312_state*) kmalloc(sizeof(struct mt312_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct mt312_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
 
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/nxt2002.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/nxt2002.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/nxt2002.c	2005-05-08 16:21:47.000000000 +0200
@@ -241,7 +241,7 @@ static void nxt2002_agc_reset(struct nxt
 static int nxt2002_load_firmware (struct dvb_frontend* fe, const struct firmware *fw)
 {
 
-	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	struct nxt2002_state* state = fe->demodulator_priv;
 	u8 buf[256],written = 0,chunkpos = 0;
 	u16 rambase,position,crc = 0;
 
@@ -309,7 +309,7 @@ static int nxt2002_load_firmware (struct
 static int nxt2002_setup_frontend_parameters (struct dvb_frontend* fe,
 					     struct dvb_frontend_parameters *p)
 {
-	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	struct nxt2002_state* state = fe->demodulator_priv;
 	u32 freq = 0;
 	u16 tunerfreq = 0;
 	u8 buf[4];
@@ -453,7 +453,7 @@ static int nxt2002_setup_frontend_parame
 
 static int nxt2002_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	struct nxt2002_state* state = fe->demodulator_priv;
 	u8 lock;
 	i2c_readbytes(state,0x31,&lock,1);
 
@@ -470,7 +470,7 @@ static int nxt2002_read_status(struct dv
 
 static int nxt2002_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	struct nxt2002_state* state = fe->demodulator_priv;
 	u8 b[3];
 
 	nxt2002_readreg_multibyte(state,0xE6,b,3);
@@ -482,7 +482,7 @@ static int nxt2002_read_ber(struct dvb_f
 
 static int nxt2002_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	struct nxt2002_state* state = fe->demodulator_priv;
 	u8 b[2];
 	u16 temp = 0;
 
@@ -502,7 +502,7 @@ static int nxt2002_read_signal_strength(
 static int nxt2002_read_snr(struct dvb_frontend* fe, u16* snr)
 {
 
-	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	struct nxt2002_state* state = fe->demodulator_priv;
 	u8 b[2];
 	u16 temp = 0, temp2;
 	u32 snrdb = 0;
@@ -536,7 +536,7 @@ static int nxt2002_read_snr(struct dvb_f
 
 static int nxt2002_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	struct nxt2002_state* state = fe->demodulator_priv;
 	u8 b[3];
 
 	nxt2002_readreg_multibyte(state,0xE6,b,3);
@@ -552,7 +552,7 @@ static int nxt2002_sleep(struct dvb_fron
 
 static int nxt2002_init(struct dvb_frontend* fe)
 {
-	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	struct nxt2002_state* state = fe->demodulator_priv;
 	const struct firmware *fw;
 	int ret;
 	u8 buf[2];
@@ -624,7 +624,7 @@ static int nxt2002_get_tune_settings(str
 
 static void nxt2002_release(struct dvb_frontend* fe)
 {
-	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	struct nxt2002_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -637,7 +637,7 @@ struct dvb_frontend* nxt2002_attach(cons
 	u8 buf [] = {0,0,0,0,0};
 
 	/* allocate memory for the internal state */
-	state = (struct nxt2002_state*) kmalloc(sizeof(struct nxt2002_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct nxt2002_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/nxt6000.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/nxt6000.c	2005-05-08 16:16:25.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/nxt6000.c	2005-05-08 16:21:47.000000000 +0200
@@ -176,7 +176,7 @@ static int nxt6000_set_transmission_mode
 
 static void nxt6000_setup(struct dvb_frontend* fe)
 {
-	struct nxt6000_state* state = (struct nxt6000_state*) fe->demodulator_priv;
+	struct nxt6000_state* state = fe->demodulator_priv;
 
 	nxt6000_writereg(state, RS_COR_SYNC_PARAM, SYNC_PARAM);
 	nxt6000_writereg(state, BER_CTRL, /*(1 << 2) | */ (0x01 << 1) | 0x01);
@@ -427,7 +427,7 @@ static void nxt6000_dump_status(struct n
 static int nxt6000_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
 	u8 core_status;
-	struct nxt6000_state* state = (struct nxt6000_state*) fe->demodulator_priv;
+	struct nxt6000_state* state = fe->demodulator_priv;
 
 	*status = 0;
 
@@ -456,7 +456,7 @@ static int nxt6000_read_status(struct dv
 
 static int nxt6000_init(struct dvb_frontend* fe)
 {
-	struct nxt6000_state* state = (struct nxt6000_state*) fe->demodulator_priv;
+	struct nxt6000_state* state = fe->demodulator_priv;
 
 	nxt6000_reset(state);
 	nxt6000_setup(fe);
@@ -466,7 +466,7 @@ static int nxt6000_init(struct dvb_front
 
 static int nxt6000_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *param)
 {
-	struct nxt6000_state* state = (struct nxt6000_state*) fe->demodulator_priv;
+	struct nxt6000_state* state = fe->demodulator_priv;
 	int result;
 
 	nxt6000_writereg(state, ENABLE_TUNER_IIC, 0x01);	/* open i2c bus switch */
@@ -487,13 +487,13 @@ static int nxt6000_set_frontend(struct d
 
 static void nxt6000_release(struct dvb_frontend* fe)
 {
-	struct nxt6000_state* state = (struct nxt6000_state*) fe->demodulator_priv;
+	struct nxt6000_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
 static int nxt6000_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct nxt6000_state* state = (struct nxt6000_state*) fe->demodulator_priv;
+	struct nxt6000_state* state = fe->demodulator_priv;
 
 	*snr = nxt6000_readreg( state, OFDM_CHC_SNR) / 8;
 
@@ -502,7 +502,7 @@ static int nxt6000_read_snr(struct dvb_f
 
 static int nxt6000_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct nxt6000_state* state = (struct nxt6000_state*) fe->demodulator_priv;
+	struct nxt6000_state* state = fe->demodulator_priv;
 
 	nxt6000_writereg( state, VIT_COR_INTSTAT, 0x18 );
 
@@ -516,7 +516,7 @@ static int nxt6000_read_ber(struct dvb_f
 
 static int nxt6000_read_signal_strength(struct dvb_frontend* fe, u16* signal_strength)
 {
-	struct nxt6000_state* state = (struct nxt6000_state*) fe->demodulator_priv;
+	struct nxt6000_state* state = fe->demodulator_priv;
 
 	*signal_strength = (short) (511 -
 		(nxt6000_readreg(state, AGC_GAIN_1) +
@@ -533,7 +533,7 @@ struct dvb_frontend* nxt6000_attach(cons
 	struct nxt6000_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct nxt6000_state*) kmalloc(sizeof(struct nxt6000_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct nxt6000_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/or51132.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/or51132.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/or51132.c	2005-05-08 16:21:47.000000000 +0200
@@ -102,7 +102,7 @@ static u8 i2c_readbytes (struct or51132_
 
 static int or51132_load_firmware (struct dvb_frontend* fe, const struct firmware *fw)
 {
-	struct or51132_state* state = (struct or51132_state*) fe->demodulator_priv;
+	struct or51132_state* state = fe->demodulator_priv;
 	static u8 run_buf[] = {0x7F,0x01};
 	static u8 get_ver_buf[] = {0x04,0x00,0x30,0x00,0x00};
 	u8 rec_buf[14];
@@ -240,7 +240,7 @@ static int or51132_sleep(struct dvb_fron
 
 static int or51132_setmode(struct dvb_frontend* fe)
 {
-	struct or51132_state* state = (struct or51132_state*) fe->demodulator_priv;
+	struct or51132_state* state = fe->demodulator_priv;
 	unsigned char cmd_buf[4];
 
 	dprintk("setmode %d\n",(int)state->current_modulation);
@@ -316,7 +316,7 @@ static int or51132_set_parameters(struct
 {
 	int ret;
 	u8 buf[4];
-	struct or51132_state* state = (struct or51132_state*) fe->demodulator_priv;
+	struct or51132_state* state = fe->demodulator_priv;
 	const struct firmware *fw;
 
 	/* Change only if we are actually changing the modulation */
@@ -391,7 +391,7 @@ static int or51132_set_parameters(struct
 
 static int or51132_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct or51132_state* state = (struct or51132_state*) fe->demodulator_priv;
+	struct or51132_state* state = fe->demodulator_priv;
 	unsigned char rec_buf[2];
 	unsigned char snd_buf[2];
 	*status = 0;
@@ -464,7 +464,7 @@ static unsigned int i20Log10(unsigned sh
 
 static int or51132_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-	struct or51132_state* state = (struct or51132_state*) fe->demodulator_priv;
+	struct or51132_state* state = fe->demodulator_priv;
 	unsigned char rec_buf[2];
 	unsigned char snd_buf[2];
 	u8 rcvr_stat;
@@ -512,7 +512,7 @@ static int or51132_read_signal_strength(
 
 static int or51132_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct or51132_state* state = (struct or51132_state*) fe->demodulator_priv;
+	struct or51132_state* state = fe->demodulator_priv;
 	unsigned char rec_buf[2];
 	unsigned char snd_buf[2];
 	u16 snr_equ;
@@ -549,7 +549,7 @@ static int or51132_get_tune_settings(str
 
 static void or51132_release(struct dvb_frontend* fe)
 {
-	struct or51132_state* state = (struct or51132_state*) fe->demodulator_priv;
+	struct or51132_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/sp8870.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/sp8870.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/sp8870.c	2005-05-08 16:21:47.000000000 +0200
@@ -248,7 +248,7 @@ static int sp8870_wake_up(struct sp8870_
 static int sp8870_set_frontend_parameters (struct dvb_frontend* fe,
 					   struct dvb_frontend_parameters *p)
 {
-	struct sp8870_state* state = (struct sp8870_state*) fe->demodulator_priv;
+	struct sp8870_state* state = fe->demodulator_priv;
 	int  err;
 	u16 reg0xc05;
 
@@ -302,7 +302,7 @@ static int sp8870_set_frontend_parameter
 
 static int sp8870_init (struct dvb_frontend* fe)
 {
-	struct sp8870_state* state = (struct sp8870_state*) fe->demodulator_priv;
+	struct sp8870_state* state = fe->demodulator_priv;
         const struct firmware *fw = NULL;
 
 	sp8870_wake_up(state);
@@ -358,7 +358,7 @@ static int sp8870_init (struct dvb_front
 
 static int sp8870_read_status (struct dvb_frontend* fe, fe_status_t * fe_status)
 {
-	struct sp8870_state* state = (struct sp8870_state*) fe->demodulator_priv;
+	struct sp8870_state* state = fe->demodulator_priv;
 	int status;
 	int signal;
 
@@ -384,7 +384,7 @@ static int sp8870_read_status (struct dv
 
 static int sp8870_read_ber (struct dvb_frontend* fe, u32 * ber)
 {
-	struct sp8870_state* state = (struct sp8870_state*) fe->demodulator_priv;
+	struct sp8870_state* state = fe->demodulator_priv;
 	int ret;
 	u32 tmp;
 
@@ -412,7 +412,7 @@ static int sp8870_read_ber (struct dvb_f
 
 static int sp8870_read_signal_strength(struct dvb_frontend* fe,  u16 * signal)
 {
-	struct sp8870_state* state = (struct sp8870_state*) fe->demodulator_priv;
+	struct sp8870_state* state = fe->demodulator_priv;
 	int ret;
 	u16 tmp;
 
@@ -438,7 +438,7 @@ static int sp8870_read_signal_strength(s
 
 static int sp8870_read_uncorrected_blocks (struct dvb_frontend* fe, u32* ublocks)
 {
-	struct sp8870_state* state = (struct sp8870_state*) fe->demodulator_priv;
+	struct sp8870_state* state = fe->demodulator_priv;
 	int ret;
 
 	*ublocks = 0;
@@ -467,7 +467,7 @@ static int switches = 0;
 
 static int sp8870_set_frontend (struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct sp8870_state* state = (struct sp8870_state*) fe->demodulator_priv;
+	struct sp8870_state* state = fe->demodulator_priv;
 
 	/*
 	    The firmware of the sp8870 sometimes locks up after setting frontend parameters.
@@ -524,7 +524,7 @@ static int sp8870_set_frontend (struct d
 
 static int sp8870_sleep(struct dvb_frontend* fe)
 {
-	struct sp8870_state* state = (struct sp8870_state*) fe->demodulator_priv;
+	struct sp8870_state* state = fe->demodulator_priv;
 
 	// tristate TS output and disable interface pins
 	return sp8870_writereg(state, 0xC18, 0x000);
@@ -540,7 +540,7 @@ static int sp8870_get_tune_settings(stru
 
 static void sp8870_release(struct dvb_frontend* fe)
 {
-	struct sp8870_state* state = (struct sp8870_state*) fe->demodulator_priv;
+	struct sp8870_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -552,7 +552,7 @@ struct dvb_frontend* sp8870_attach(const
 	struct sp8870_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct sp8870_state*) kmalloc(sizeof(struct sp8870_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct sp8870_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/sp887x.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/sp887x.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/sp887x.c	2005-05-08 16:21:47.000000000 +0200
@@ -135,7 +135,7 @@ static void sp887x_setup_agc (struct sp8
  */
 static int sp887x_initial_setup (struct dvb_frontend* fe, const struct firmware *fw)
 {
-	struct sp887x_state* state = (struct sp887x_state*) fe->demodulator_priv;
+	struct sp887x_state* state = fe->demodulator_priv;
 	u8 buf [BLOCKSIZE+2];
 	int i;
 	int fw_size = fw->size;
@@ -344,7 +344,7 @@ static void sp887x_correct_offsets (stru
 static int sp887x_setup_frontend_parameters (struct dvb_frontend* fe,
 					     struct dvb_frontend_parameters *p)
 {
-	struct sp887x_state* state = (struct sp887x_state*) fe->demodulator_priv;
+	struct sp887x_state* state = fe->demodulator_priv;
 	int actual_freq, err;
 	u16 val, reg0xc05;
 
@@ -405,7 +405,7 @@ static int sp887x_setup_frontend_paramet
 
 static int sp887x_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct sp887x_state* state = (struct sp887x_state*) fe->demodulator_priv;
+	struct sp887x_state* state = fe->demodulator_priv;
 	u16 snr12 = sp887x_readreg(state, 0xf16);
 	u16 sync0x200 = sp887x_readreg(state, 0x200);
 	u16 sync0xf17 = sp887x_readreg(state, 0xf17);
@@ -439,7 +439,7 @@ static int sp887x_read_status(struct dvb
 
 static int sp887x_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct sp887x_state* state = (struct sp887x_state*) fe->demodulator_priv;
+	struct sp887x_state* state = fe->demodulator_priv;
 
 	*ber = (sp887x_readreg(state, 0xc08) & 0x3f) |
 	       (sp887x_readreg(state, 0xc07) << 6);
@@ -453,7 +453,7 @@ static int sp887x_read_ber(struct dvb_fr
 
 static int sp887x_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-	struct sp887x_state* state = (struct sp887x_state*) fe->demodulator_priv;
+	struct sp887x_state* state = fe->demodulator_priv;
 
 	u16 snr12 = sp887x_readreg(state, 0xf16);
 	u32 signal = 3 * (snr12 << 4);
@@ -464,7 +464,7 @@ static int sp887x_read_signal_strength(s
 
 static int sp887x_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct sp887x_state* state = (struct sp887x_state*) fe->demodulator_priv;
+	struct sp887x_state* state = fe->demodulator_priv;
 
 	u16 snr12 = sp887x_readreg(state, 0xf16);
 	*snr = (snr12 << 4) | (snr12 >> 8);
@@ -474,7 +474,7 @@ static int sp887x_read_snr(struct dvb_fr
 
 static int sp887x_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct sp887x_state* state = (struct sp887x_state*) fe->demodulator_priv;
+	struct sp887x_state* state = fe->demodulator_priv;
 
 	*ucblocks = sp887x_readreg(state, 0xc0c);
 	if (*ucblocks == 0xfff)
@@ -485,7 +485,7 @@ static int sp887x_read_ucblocks(struct d
 
 static int sp887x_sleep(struct dvb_frontend* fe)
 {
-	struct sp887x_state* state = (struct sp887x_state*) fe->demodulator_priv;
+	struct sp887x_state* state = fe->demodulator_priv;
 
 	/* tristate TS output and disable interface pins */
 	sp887x_writereg(state, 0xc18, 0x000);
@@ -495,7 +495,7 @@ static int sp887x_sleep(struct dvb_front
 
 static int sp887x_init(struct dvb_frontend* fe)
 {
-	struct sp887x_state* state = (struct sp887x_state*) fe->demodulator_priv;
+	struct sp887x_state* state = fe->demodulator_priv;
         const struct firmware *fw = NULL;
 	int ret;
 
@@ -534,7 +534,7 @@ static int sp887x_get_tune_settings(stru
 
 static void sp887x_release(struct dvb_frontend* fe)
 {
-	struct sp887x_state* state = (struct sp887x_state*) fe->demodulator_priv;
+	struct sp887x_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -546,7 +546,7 @@ struct dvb_frontend* sp887x_attach(const
 	struct sp887x_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct sp887x_state*) kmalloc(sizeof(struct sp887x_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct sp887x_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/stv0297.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/stv0297.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/stv0297.c	2005-05-08 16:21:47.000000000 +0200
@@ -365,7 +365,7 @@ static int stv0297_set_inversion(struct 
 
 int stv0297_enable_plli2c(struct dvb_frontend *fe)
 {
-	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	struct stv0297_state *state = fe->demodulator_priv;
 
 	stv0297_writereg(state, 0x87, 0x78);
 	stv0297_writereg(state, 0x86, 0xc8);
@@ -375,7 +375,7 @@ int stv0297_enable_plli2c(struct dvb_fro
 
 static int stv0297_init(struct dvb_frontend *fe)
 {
-	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	struct stv0297_state *state = fe->demodulator_priv;
 	int i;
 
 	/* soft reset */
@@ -416,7 +416,7 @@ static int stv0297_init(struct dvb_front
 
 static int stv0297_sleep(struct dvb_frontend *fe)
 {
-	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	struct stv0297_state *state = fe->demodulator_priv;
 
 	stv0297_writereg_mask(state, 0x80, 1, 1);
 
@@ -425,7 +425,7 @@ static int stv0297_sleep(struct dvb_fron
 
 static int stv0297_read_status(struct dvb_frontend *fe, fe_status_t * status)
 {
-	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	struct stv0297_state *state = fe->demodulator_priv;
 
 	u8 sync = stv0297_readreg(state, 0xDF);
 
@@ -438,7 +438,7 @@ static int stv0297_read_status(struct dv
 
 static int stv0297_read_ber(struct dvb_frontend *fe, u32 * ber)
 {
-	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	struct stv0297_state *state = fe->demodulator_priv;
 	u8 BER[3];
 
 	stv0297_writereg(state, 0xA0, 0x80);	// Start Counting bit errors for 4096 Bytes
@@ -453,7 +453,7 @@ static int stv0297_read_ber(struct dvb_f
 
 static int stv0297_read_signal_strength(struct dvb_frontend *fe, u16 * strength)
 {
-	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	struct stv0297_state *state = fe->demodulator_priv;
 	u8 STRENGTH[2];
 
 	stv0297_readregs(state, 0x41, STRENGTH, 2);
@@ -464,7 +464,7 @@ static int stv0297_read_signal_strength(
 
 static int stv0297_read_snr(struct dvb_frontend *fe, u16 * snr)
 {
-	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	struct stv0297_state *state = fe->demodulator_priv;
 	u8 SNR[2];
 
 	stv0297_readregs(state, 0x07, SNR, 2);
@@ -475,7 +475,7 @@ static int stv0297_read_snr(struct dvb_f
 
 static int stv0297_read_ucblocks(struct dvb_frontend *fe, u32 * ucblocks)
 {
-	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	struct stv0297_state *state = fe->demodulator_priv;
 
 	*ucblocks = (stv0297_readreg(state, 0xD5) << 8)
 		| stv0297_readreg(state, 0xD4);
@@ -485,7 +485,7 @@ static int stv0297_read_ucblocks(struct 
 
 static int stv0297_set_frontend(struct dvb_frontend *fe, struct dvb_frontend_parameters *p)
 {
-	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	struct stv0297_state *state = fe->demodulator_priv;
 	int u_threshold;
 	int initial_u;
 	int blind_u;
@@ -689,7 +689,7 @@ timeout:
 
 static int stv0297_get_frontend(struct dvb_frontend *fe, struct dvb_frontend_parameters *p)
 {
-	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	struct stv0297_state *state = fe->demodulator_priv;
 	int reg_00, reg_83;
 
 	reg_00 = stv0297_readreg(state, 0x00);
@@ -725,7 +725,7 @@ static int stv0297_get_frontend(struct d
 
 static void stv0297_release(struct dvb_frontend *fe)
 {
-	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	struct stv0297_state *state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -737,7 +737,7 @@ struct dvb_frontend *stv0297_attach(cons
 	struct stv0297_state *state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct stv0297_state *) kmalloc(sizeof(struct stv0297_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct stv0297_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
 
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/stv0299.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/stv0299.c	2005-05-08 16:20:39.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/stv0299.c	2005-05-08 16:21:47.000000000 +0200
@@ -94,7 +94,7 @@ static int stv0299_writeregI (struct stv
 
 int stv0299_writereg (struct dvb_frontend* fe, u8 reg, u8 data)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 
 	return stv0299_writeregI(state, reg, data);
 }
@@ -219,7 +219,7 @@ static int stv0299_wait_diseqc_idle (str
 
 static int stv0299_set_symbolrate (struct dvb_frontend* fe, u32 srate)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 	u64 big = srate;
 	u32 ratio;
 
@@ -270,7 +270,7 @@ static int stv0299_get_symbolrate (struc
 static int stv0299_send_diseqc_msg (struct dvb_frontend* fe,
 				    struct dvb_diseqc_master_cmd *m)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 	u8 val;
 	int i;
 
@@ -300,7 +300,7 @@ static int stv0299_send_diseqc_msg (stru
 
 static int stv0299_send_diseqc_burst (struct dvb_frontend* fe, fe_sec_mini_cmd_t burst)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 	u8 val;
 
 	dprintk ("%s\n", __FUNCTION__);
@@ -327,7 +327,7 @@ static int stv0299_send_diseqc_burst (st
 
 static int stv0299_set_tone (struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 	u8 val;
 
 	if (stv0299_wait_diseqc_idle (state, 100) < 0)
@@ -349,7 +349,7 @@ static int stv0299_set_tone (struct dvb_
 
 static int stv0299_set_voltage (struct dvb_frontend* fe, fe_sec_voltage_t voltage)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 	u8 reg0x08;
 	u8 reg0x0c;
 
@@ -471,7 +471,7 @@ static int stv0299_send_legacy_dish_cmd 
 
 static int stv0299_init (struct dvb_frontend* fe)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 	int i;
 
 	dprintk("stv0299: init chip\n");
@@ -490,7 +490,7 @@ static int stv0299_init (struct dvb_fron
 
 static int stv0299_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 
 	u8 signal = 0xff - stv0299_readreg (state, 0x18);
 	u8 sync = stv0299_readreg (state, 0x1b);
@@ -518,7 +518,7 @@ static int stv0299_read_status(struct dv
 
 static int stv0299_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 
 	if (state->errmode != STATUS_BER) return 0;
 	*ber = (stv0299_readreg (state, 0x1d) << 8) | stv0299_readreg (state, 0x1e);
@@ -528,7 +528,7 @@ static int stv0299_read_ber(struct dvb_f
 
 static int stv0299_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 
 	s32 signal =  0xffff - ((stv0299_readreg (state, 0x18) << 8)
 			       | stv0299_readreg (state, 0x19));
@@ -545,7 +545,7 @@ static int stv0299_read_signal_strength(
 
 static int stv0299_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 
 	s32 xsnr = 0xffff - ((stv0299_readreg (state, 0x24) << 8)
 			   | stv0299_readreg (state, 0x25));
@@ -557,7 +557,7 @@ static int stv0299_read_snr(struct dvb_f
 
 static int stv0299_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 
 	if (state->errmode != STATUS_UCBLOCKS) *ucblocks = 0;
 	else *ucblocks = (stv0299_readreg (state, 0x1d) << 8) | stv0299_readreg (state, 0x1e);
@@ -567,7 +567,7 @@ static int stv0299_read_ucblocks(struct 
 
 static int stv0299_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters * p)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 	int invval = 0;
 
 	dprintk ("%s : FE_SET_FRONTEND\n", __FUNCTION__);
@@ -635,7 +635,7 @@ static int stv0299_set_frontend(struct d
 
 static int stv0299_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters * p)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 	s32 derot_freq;
 	int invval;
 
@@ -660,7 +660,7 @@ static int stv0299_get_frontend(struct d
 
 static int stv0299_sleep(struct dvb_frontend* fe)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 
 	stv0299_writeregI(state, 0x02, 0x80);
 	state->initialised = 0;
@@ -670,7 +670,7 @@ static int stv0299_sleep(struct dvb_fron
 
 static int stv0299_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fesettings)
 {
-        struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+        struct stv0299_state* state = fe->demodulator_priv;
 
 	fesettings->min_delay_ms = state->config->min_delay_ms;
 	if (fesettings->parameters.u.qpsk.symbol_rate < 10000000) {
@@ -685,7 +685,7 @@ static int stv0299_get_tune_settings(str
 
 static void stv0299_release(struct dvb_frontend* fe)
 {
-	struct stv0299_state* state = (struct stv0299_state*) fe->demodulator_priv;
+	struct stv0299_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -698,7 +698,7 @@ struct dvb_frontend* stv0299_attach(cons
 	int id;
 
 	/* allocate memory for the internal state */
-	state = (struct stv0299_state*) kmalloc(sizeof(struct stv0299_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct stv0299_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/tda10021.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/tda10021.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/tda10021.c	2005-05-08 16:21:47.000000000 +0200
@@ -205,7 +205,7 @@ static int tda10021_set_symbolrate (stru
 
 static int tda10021_init (struct dvb_frontend *fe)
 {
-	struct tda10021_state* state = (struct tda10021_state*) fe->demodulator_priv;
+	struct tda10021_state* state = fe->demodulator_priv;
 	int i;
 
 	dprintk("DVB: TDA10021(%d): init chip\n", fe->adapter->num);
@@ -238,7 +238,7 @@ static int tda10021_init (struct dvb_fro
 static int tda10021_set_parameters (struct dvb_frontend *fe,
 			    struct dvb_frontend_parameters *p)
 {
-	struct tda10021_state* state = (struct tda10021_state*) fe->demodulator_priv;
+	struct tda10021_state* state = fe->demodulator_priv;
 
 	//table for QAM4-QAM256 ready  QAM4  QAM16 QAM32 QAM64 QAM128 QAM256
 	//CONF
@@ -278,7 +278,7 @@ static int tda10021_set_parameters (stru
 
 static int tda10021_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct tda10021_state* state = (struct tda10021_state*) fe->demodulator_priv;
+	struct tda10021_state* state = fe->demodulator_priv;
 	int sync;
 
 	*status = 0;
@@ -303,7 +303,7 @@ static int tda10021_read_status(struct d
 
 static int tda10021_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct tda10021_state* state = (struct tda10021_state*) fe->demodulator_priv;
+	struct tda10021_state* state = fe->demodulator_priv;
 
 	u32 _ber = tda10021_readreg(state, 0x14) |
 		(tda10021_readreg(state, 0x15) << 8) |
@@ -315,7 +315,7 @@ static int tda10021_read_ber(struct dvb_
 
 static int tda10021_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-	struct tda10021_state* state = (struct tda10021_state*) fe->demodulator_priv;
+	struct tda10021_state* state = fe->demodulator_priv;
 
 	u8 gain = tda10021_readreg(state, 0x17);
 	*strength = (gain << 8) | gain;
@@ -325,7 +325,7 @@ static int tda10021_read_signal_strength
 
 static int tda10021_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct tda10021_state* state = (struct tda10021_state*) fe->demodulator_priv;
+	struct tda10021_state* state = fe->demodulator_priv;
 
 	u8 quality = ~tda10021_readreg(state, 0x18);
 	*snr = (quality << 8) | quality;
@@ -335,7 +335,7 @@ static int tda10021_read_snr(struct dvb_
 
 static int tda10021_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct tda10021_state* state = (struct tda10021_state*) fe->demodulator_priv;
+	struct tda10021_state* state = fe->demodulator_priv;
 
 	*ucblocks = tda10021_readreg (state, 0x13) & 0x7f;
 	if (*ucblocks == 0x7f)
@@ -350,7 +350,7 @@ static int tda10021_read_ucblocks(struct
 
 static int tda10021_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct tda10021_state* state = (struct tda10021_state*) fe->demodulator_priv;
+	struct tda10021_state* state = fe->demodulator_priv;
 	int sync;
 	s8 afc = 0;
 
@@ -378,7 +378,7 @@ static int tda10021_get_frontend(struct 
 
 static int tda10021_sleep(struct dvb_frontend* fe)
 {
-	struct tda10021_state* state = (struct tda10021_state*) fe->demodulator_priv;
+	struct tda10021_state* state = fe->demodulator_priv;
 
 	tda10021_writereg (state, 0x1b, 0x02);  /* pdown ADC */
 	tda10021_writereg (state, 0x00, 0x80);  /* standby */
@@ -388,7 +388,7 @@ static int tda10021_sleep(struct dvb_fro
 
 static void tda10021_release(struct dvb_frontend* fe)
 {
-	struct tda10021_state* state = (struct tda10021_state*) fe->demodulator_priv;
+	struct tda10021_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -401,7 +401,7 @@ struct dvb_frontend* tda10021_attach(con
 	struct tda10021_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct tda10021_state*) kmalloc(sizeof(struct tda10021_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct tda10021_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/tda8083.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/tda8083.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/tda8083.c	2005-05-08 16:21:47.000000000 +0200
@@ -226,7 +226,7 @@ static int tda8083_send_diseqc_burst (st
 static int tda8083_send_diseqc_msg (struct dvb_frontend* fe,
 				    struct dvb_diseqc_master_cmd *m)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 	int i;
 
 	tda8083_writereg (state, 0x29, (m->msg_len - 3) | (1 << 2)); /* enable */
@@ -243,7 +243,7 @@ static int tda8083_send_diseqc_msg (stru
 
 static int tda8083_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 
 	u8 signal = ~tda8083_readreg (state, 0x01);
 	u8 sync = tda8083_readreg (state, 0x02);
@@ -270,7 +270,7 @@ static int tda8083_read_status(struct dv
 
 static int tda8083_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 
 	u8 signal = ~tda8083_readreg (state, 0x01);
 	*strength = (signal << 8) | signal;
@@ -280,7 +280,7 @@ static int tda8083_read_signal_strength(
 
 static int tda8083_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 
 	u8 _snr = tda8083_readreg (state, 0x08);
 	*snr = (_snr << 8) | _snr;
@@ -290,7 +290,7 @@ static int tda8083_read_snr(struct dvb_f
 
 static int tda8083_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 
 	state->config->pll_set(fe, p);
 	tda8083_set_inversion (state, p->inversion);
@@ -305,7 +305,7 @@ static int tda8083_set_frontend(struct d
 
 static int tda8083_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 
 	/*  FIXME: get symbolrate & frequency offset...*/
 	/*p->frequency = ???;*/
@@ -319,7 +319,7 @@ static int tda8083_get_frontend(struct d
 
 static int tda8083_sleep(struct dvb_frontend* fe)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 
 	tda8083_writereg (state, 0x00, 0x02);
 	return 0;
@@ -327,7 +327,7 @@ static int tda8083_sleep(struct dvb_fron
 
 static int tda8083_init(struct dvb_frontend* fe)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 	int i;
 
 	for (i=0; i<44; i++)
@@ -343,7 +343,7 @@ static int tda8083_init(struct dvb_front
 
 static int tda8083_diseqc_send_burst(struct dvb_frontend* fe, fe_sec_mini_cmd_t burst)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 
 	tda8083_send_diseqc_burst (state, burst);
 	tda8083_writereg (state, 0x00, 0x3c);
@@ -354,7 +354,7 @@ static int tda8083_diseqc_send_burst(str
 
 static int tda8083_diseqc_set_tone(struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 
 	tda8083_set_tone (state, tone);
 	tda8083_writereg (state, 0x00, 0x3c);
@@ -365,7 +365,7 @@ static int tda8083_diseqc_set_tone(struc
 
 static int tda8083_diseqc_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 
 	tda8083_set_voltage (state, voltage);
 	tda8083_writereg (state, 0x00, 0x3c);
@@ -376,7 +376,7 @@ static int tda8083_diseqc_set_voltage(st
 
 static void tda8083_release(struct dvb_frontend* fe)
 {
-	struct tda8083_state* state = (struct tda8083_state*) fe->demodulator_priv;
+	struct tda8083_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -388,7 +388,7 @@ struct dvb_frontend* tda8083_attach(cons
 	struct tda8083_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct tda8083_state*) kmalloc(sizeof(struct tda8083_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct tda8083_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/tda80xx.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/tda80xx.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/tda80xx.c	2005-05-08 16:21:47.000000000 +0200
@@ -400,7 +400,7 @@ static void tda80xx_wait_diseqc_fifo(str
 
 static int tda8044_init(struct dvb_frontend* fe)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 	int ret;
 
 	/*
@@ -432,7 +432,7 @@ static int tda8044_init(struct dvb_front
 
 static int tda8083_init(struct dvb_frontend* fe)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	tda80xx_write(state, 0x00, tda8083_inittab, sizeof(tda8083_inittab));
 
@@ -447,7 +447,7 @@ static int tda8083_init(struct dvb_front
 
 static int tda80xx_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	switch (voltage) {
 	case SEC_VOLTAGE_13:
@@ -463,7 +463,7 @@ static int tda80xx_set_voltage(struct dv
 
 static int tda80xx_set_tone(struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	switch (tone) {
 	case SEC_TONE_OFF:
@@ -477,7 +477,7 @@ static int tda80xx_set_tone(struct dvb_f
 
 static int tda80xx_send_diseqc_msg(struct dvb_frontend* fe, struct dvb_diseqc_master_cmd *cmd)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	if (cmd->msg_len > 6)
 		return -EINVAL;
@@ -492,7 +492,7 @@ static int tda80xx_send_diseqc_msg(struc
 
 static int tda80xx_send_diseqc_burst(struct dvb_frontend* fe, fe_sec_mini_cmd_t cmd)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	switch (cmd) {
 	case SEC_MINI_A:
@@ -512,7 +512,7 @@ static int tda80xx_send_diseqc_burst(str
 
 static int tda80xx_sleep(struct dvb_frontend* fe)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	tda80xx_writereg(state, 0x00, 0x02);	/* enter standby */
 
@@ -521,7 +521,7 @@ static int tda80xx_sleep(struct dvb_fron
 
 static int tda80xx_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	tda80xx_writereg(state, 0x1c, 0x80);
 	state->config->pll_set(fe, p);
@@ -537,7 +537,7 @@ static int tda80xx_set_frontend(struct d
 
 static int tda80xx_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	if (!state->config->irq)
 		tda80xx_read_status_int(state);
@@ -550,7 +550,7 @@ static int tda80xx_get_frontend(struct d
 
 static int tda80xx_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	if (!state->config->irq)
 		tda80xx_read_status_int(state);
@@ -561,7 +561,7 @@ static int tda80xx_read_status(struct dv
 
 static int tda80xx_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 	int ret;
 	u8 buf[3];
 
@@ -575,7 +575,7 @@ static int tda80xx_read_ber(struct dvb_f
 
 static int tda80xx_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	u8 gain = ~tda80xx_readreg(state, 0x01);
 	*strength = (gain << 8) | gain;
@@ -585,7 +585,7 @@ static int tda80xx_read_signal_strength(
 
 static int tda80xx_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	u8 quality = tda80xx_readreg(state, 0x08);
 	*snr = (quality << 8) | quality;
@@ -595,7 +595,7 @@ static int tda80xx_read_snr(struct dvb_f
 
 static int tda80xx_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	*ucblocks = tda80xx_readreg(state, 0x0f);
 	if (*ucblocks == 0xff)
@@ -606,7 +606,7 @@ static int tda80xx_read_ucblocks(struct 
 
 static int tda80xx_init(struct dvb_frontend* fe)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	switch(state->id) {
 	case ID_TDA8044:
@@ -620,7 +620,7 @@ static int tda80xx_init(struct dvb_front
 
 static void tda80xx_release(struct dvb_frontend* fe)
 {
-	struct tda80xx_state* state = (struct tda80xx_state*) fe->demodulator_priv;
+	struct tda80xx_state* state = fe->demodulator_priv;
 
 	if (state->config->irq)
 		free_irq(state->config->irq, &state->worklet);
@@ -637,7 +637,7 @@ struct dvb_frontend* tda80xx_attach(cons
 	int ret;
 
 	/* allocate memory for the internal state */
-	state = (struct tda80xx_state*) kmalloc(sizeof(struct tda80xx_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct tda80xx_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/ves1820.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/ves1820.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/ves1820.c	2005-05-08 16:21:47.000000000 +0200
@@ -193,7 +193,7 @@ static int ves1820_set_symbolrate(struct
 
 static int ves1820_init(struct dvb_frontend* fe)
 {
-	struct ves1820_state* state = (struct ves1820_state*) fe->demodulator_priv;
+	struct ves1820_state* state = fe->demodulator_priv;
 	int i;
 	int val;
 
@@ -214,7 +214,7 @@ static int ves1820_init(struct dvb_front
 
 static int ves1820_set_parameters(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct ves1820_state* state = (struct ves1820_state*) fe->demodulator_priv;
+	struct ves1820_state* state = fe->demodulator_priv;
 	static const u8 reg0x00[] = { 0x00, 0x04, 0x08, 0x0c, 0x10 };
 	static const u8 reg0x01[] = { 140, 140, 106, 100, 92 };
 	static const u8 reg0x05[] = { 135, 100, 70, 54, 38 };
@@ -241,7 +241,7 @@ static int ves1820_set_parameters(struct
 
 static int ves1820_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct ves1820_state* state = (struct ves1820_state*) fe->demodulator_priv;
+	struct ves1820_state* state = fe->demodulator_priv;
 	int sync;
 
 	*status = 0;
@@ -267,7 +267,7 @@ static int ves1820_read_status(struct dv
 
 static int ves1820_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct ves1820_state* state = (struct ves1820_state*) fe->demodulator_priv;
+	struct ves1820_state* state = fe->demodulator_priv;
 
 	u32 _ber = ves1820_readreg(state, 0x14) |
 			(ves1820_readreg(state, 0x15) << 8) |
@@ -279,7 +279,7 @@ static int ves1820_read_ber(struct dvb_f
 
 static int ves1820_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-	struct ves1820_state* state = (struct ves1820_state*) fe->demodulator_priv;
+	struct ves1820_state* state = fe->demodulator_priv;
 
 	u8 gain = ves1820_readreg(state, 0x17);
 	*strength = (gain << 8) | gain;
@@ -289,7 +289,7 @@ static int ves1820_read_signal_strength(
 
 static int ves1820_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct ves1820_state* state = (struct ves1820_state*) fe->demodulator_priv;
+	struct ves1820_state* state = fe->demodulator_priv;
 
 	u8 quality = ~ves1820_readreg(state, 0x18);
 	*snr = (quality << 8) | quality;
@@ -299,7 +299,7 @@ static int ves1820_read_snr(struct dvb_f
 
 static int ves1820_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct ves1820_state* state = (struct ves1820_state*) fe->demodulator_priv;
+	struct ves1820_state* state = fe->demodulator_priv;
 
 	*ucblocks = ves1820_readreg(state, 0x13) & 0x7f;
 	if (*ucblocks == 0x7f)
@@ -314,7 +314,7 @@ static int ves1820_read_ucblocks(struct 
 
 static int ves1820_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct ves1820_state* state = (struct ves1820_state*) fe->demodulator_priv;
+	struct ves1820_state* state = fe->demodulator_priv;
 	int sync;
 	s8 afc = 0;
 
@@ -345,7 +345,7 @@ static int ves1820_get_frontend(struct d
 
 static int ves1820_sleep(struct dvb_frontend* fe)
 {
-	struct ves1820_state* state = (struct ves1820_state*) fe->demodulator_priv;
+	struct ves1820_state* state = fe->demodulator_priv;
 
 	ves1820_writereg(state, 0x1b, 0x02);	/* pdown ADC */
 	ves1820_writereg(state, 0x00, 0x80);	/* standby */
@@ -364,7 +364,7 @@ static int ves1820_get_tune_settings(str
 
 static void ves1820_release(struct dvb_frontend* fe)
 {
-	struct ves1820_state* state = (struct ves1820_state*) fe->demodulator_priv;
+	struct ves1820_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -377,7 +377,7 @@ struct dvb_frontend* ves1820_attach(cons
 	struct ves1820_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct ves1820_state*) kmalloc(sizeof(struct ves1820_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct ves1820_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
 
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/ves1x93.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/ves1x93.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/ves1x93.c	2005-05-08 16:21:47.000000000 +0200
@@ -263,7 +263,7 @@ static int ves1x93_set_symbolrate (struc
 
 static int ves1x93_init (struct dvb_frontend* fe)
 {
-	struct ves1x93_state* state = (struct ves1x93_state*) fe->demodulator_priv;
+	struct ves1x93_state* state = fe->demodulator_priv;
 	int i;
 	int val;
 
@@ -289,7 +289,7 @@ static int ves1x93_init (struct dvb_fron
 
 static int ves1x93_set_voltage (struct dvb_frontend* fe, fe_sec_voltage_t voltage)
 {
-	struct ves1x93_state* state = (struct ves1x93_state*) fe->demodulator_priv;
+	struct ves1x93_state* state = fe->demodulator_priv;
 
 	switch (voltage) {
 	case SEC_VOLTAGE_13:
@@ -305,7 +305,7 @@ static int ves1x93_set_voltage (struct d
 
 static int ves1x93_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct ves1x93_state* state = (struct ves1x93_state*) fe->demodulator_priv;
+	struct ves1x93_state* state = fe->demodulator_priv;
 
 	u8 sync = ves1x93_readreg (state, 0x0e);
 
@@ -346,7 +346,7 @@ static int ves1x93_read_status(struct dv
 
 static int ves1x93_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct ves1x93_state* state = (struct ves1x93_state*) fe->demodulator_priv;
+	struct ves1x93_state* state = fe->demodulator_priv;
 
 	*ber = ves1x93_readreg (state, 0x15);
 	*ber |= (ves1x93_readreg (state, 0x16) << 8);
@@ -358,7 +358,7 @@ static int ves1x93_read_ber(struct dvb_f
 
 static int ves1x93_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-	struct ves1x93_state* state = (struct ves1x93_state*) fe->demodulator_priv;
+	struct ves1x93_state* state = fe->demodulator_priv;
 
 	u8 signal = ~ves1x93_readreg (state, 0x0b);
 	*strength = (signal << 8) | signal;
@@ -368,7 +368,7 @@ static int ves1x93_read_signal_strength(
 
 static int ves1x93_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct ves1x93_state* state = (struct ves1x93_state*) fe->demodulator_priv;
+	struct ves1x93_state* state = fe->demodulator_priv;
 
 	u8 _snr = ~ves1x93_readreg (state, 0x1c);
 	*snr = (_snr << 8) | _snr;
@@ -378,7 +378,7 @@ static int ves1x93_read_snr(struct dvb_f
 
 static int ves1x93_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct ves1x93_state* state = (struct ves1x93_state*) fe->demodulator_priv;
+	struct ves1x93_state* state = fe->demodulator_priv;
 
 	*ucblocks = ves1x93_readreg (state, 0x18) & 0x7f;
 
@@ -393,7 +393,7 @@ static int ves1x93_read_ucblocks(struct 
 
 static int ves1x93_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct ves1x93_state* state = (struct ves1x93_state*) fe->demodulator_priv;
+	struct ves1x93_state* state = fe->demodulator_priv;
 
 	ves1x93_writereg(state, 0x00, 0x11);
 	state->config->pll_set(fe, p);
@@ -408,7 +408,7 @@ static int ves1x93_set_frontend(struct d
 
 static int ves1x93_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct ves1x93_state* state = (struct ves1x93_state*) fe->demodulator_priv;
+	struct ves1x93_state* state = fe->demodulator_priv;
 	int afc;
 
 	afc = ((int)((char)(ves1x93_readreg (state, 0x0a) << 1)))/2;
@@ -431,14 +431,14 @@ static int ves1x93_get_frontend(struct d
 
 static int ves1x93_sleep(struct dvb_frontend* fe)
 {
-	struct ves1x93_state* state = (struct ves1x93_state*) fe->demodulator_priv;
+	struct ves1x93_state* state = fe->demodulator_priv;
 
 	return ves1x93_writereg (state, 0x00, 0x08);
 }
 
 static void ves1x93_release(struct dvb_frontend* fe)
 {
-	struct ves1x93_state* state = (struct ves1x93_state*) fe->demodulator_priv;
+	struct ves1x93_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -451,7 +451,7 @@ struct dvb_frontend* ves1x93_attach(cons
 	u8 identity;
 
 	/* allocate memory for the internal state */
-	state = (struct ves1x93_state*) kmalloc(sizeof(struct ves1x93_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct ves1x93_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 
 	/* setup the state */

--

