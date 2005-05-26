Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVEZUlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVEZUlv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVEZUk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:40:59 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:34214 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S261729AbVEZUkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:40:17 -0400
Message-ID: <429632FA.5060804@kromtek.com>
Date: Fri, 27 May 2005 00:35:06 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Remove unnecessary casts
Content-Type: multipart/mixed;
 boundary="------------070603060900000208090708"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070603060900000208090708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

o Cleanup unnecessary (and undesirable) casts,  demodulator_priv is
already a void*.
Suggestion from Andrew Morton

Signed-off-by: Manu Abraham <manu@kromtek.com>

dst.c |   22 +++++++++++-----------
     1 files changed, 11 insertions(+), 11 deletions(-)




--------------070603060900000208090708
Content-Type: text/x-patch;
 name="cleanup-unnecessary-casts.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cleanup-unnecessary-casts.diff"

--- linux-2.6.12-rc5.orig/drivers/media/dvb/bt8xx/dst.c	2005-05-26 10:36:37.000000000 +0400
+++ linux-2.6.12-rc5/drivers/media/dvb/bt8xx/dst.c	2005-05-26 21:38:09.000000000 +0400
@@ -978,7 +978,7 @@ static int dst_set_voltage(struct dvb_fr
 
 static int dst_write_tuna(struct dvb_frontend* fe)
 {
-	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
+	struct dst_state* state = fe->demodulator_priv;
 	int retval;
 	u8 reply;
 
@@ -1046,7 +1046,7 @@ static int dst_write_tuna(struct dvb_fro
 
 static int dst_set_diseqc(struct dvb_frontend* fe, struct dvb_diseqc_master_cmd* cmd)
 {
-	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
+	struct dst_state* state = fe->demodulator_priv;
 	u8 paket[8] = { 0x00, 0x08, 0x04, 0xe0, 0x10, 0x38, 0xf0, 0xec };
 
 	if (state->dst_type == DST_TYPE_IS_TERR)
@@ -1064,7 +1064,7 @@ static int dst_set_voltage(struct dvb_fr
 {
 	u8 *val;
 	int need_cmd;
-	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
+	struct dst_state* state = fe->demodulator_priv;
 
 	state->voltage = voltage;
 
@@ -1105,7 +1105,7 @@ static int dst_set_voltage(struct dvb_fr
 static int dst_set_tone(struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
 {
 	u8 *val;
-	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
+	struct dst_state* state = fe->demodulator_priv;
 
 	state->tone = tone;
 
@@ -1157,7 +1157,7 @@ static int dst_send_burst(struct dvb_fro
 
 static int dst_init(struct dvb_frontend* fe)
 {
-	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
+	struct dst_state* state = fe->demodulator_priv;
 	static u8 ini_satci_tuna[] = { 9, 0, 3, 0xb6, 1, 0, 0x73, 0x21, 0, 0 };
 	static u8 ini_satfta_tuna[] = { 0, 0, 3, 0xb6, 1, 0x55, 0xbd, 0x50, 0, 0 };
 	static u8 ini_tvfta_tuna[] = { 0, 0, 3, 0xb6, 1, 7, 0x0, 0x0, 0, 0 };
@@ -1189,7 +1189,7 @@ static int dst_init(struct dvb_frontend*
 
 static int dst_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
+	struct dst_state* state = fe->demodulator_priv;
 
 	*status = 0;
 	if (state->diseq_flags & HAS_LOCK) {
@@ -1203,7 +1203,7 @@ static int dst_read_status(struct dvb_fr
 
 static int dst_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
+	struct dst_state* state = fe->demodulator_priv;
 
 	dst_get_signal(state);
 	*strength = state->decode_strength;
@@ -1213,7 +1213,7 @@ static int dst_read_signal_strength(stru
 
 static int dst_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
+	struct dst_state* state = fe->demodulator_priv;
 
 	dst_get_signal(state);
 	*snr = state->decode_snr;
@@ -1223,7 +1223,7 @@ static int dst_read_snr(struct dvb_front
 
 static int dst_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
+	struct dst_state* state = fe->demodulator_priv;
 
 	dst_set_freq(state, p->frequency);
 	if (verbose > 4)
@@ -1249,7 +1249,7 @@ static int dst_set_frontend(struct dvb_f
 
 static int dst_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
-	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
+	struct dst_state* state = fe->demodulator_priv;
 
 	p->frequency = state->decode_freq;
 	p->inversion = state->inversion;
@@ -1269,7 +1269,7 @@ static int dst_get_frontend(struct dvb_f
 
 static void dst_release(struct dvb_frontend* fe)
 {
-	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
+	struct dst_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 




--------------070603060900000208090708--
