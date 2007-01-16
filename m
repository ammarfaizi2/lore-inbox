Return-Path: <linux-kernel-owner+w=401wt.eu-S932480AbXAPJUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbXAPJUh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 04:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbXAPJUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 04:20:37 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:6941 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932480AbXAPJUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 04:20:36 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=Xbo3mr1Xwfilx6Jw6is3CgLhpNyjnB42SynFLkBueQcy+qv9Nt6jv+l4TzjS6E6Q6xxHp6qYfXeqra6j4lzgF7XsA2Lpn2NW8z7fxdgYrsj8qIxwJg4PjsqJ9Z1ut53PpZKGGTOJglrcG9tuIHSuvDfGXEUR2sO6YI+OSF/kJjY=
Date: Tue, 16 Jan 2007 11:20:06 +0200
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH 2.6.20-rc5] DVB: Use ARRAY_SIZE macro when appropriate
Message-ID: <20070116092006.GA718@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Patch uses the ARRAY_SIZE macro defined in kernel.h instead of 
reemplementing it.

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---

bt8xx/dvb-bt8xx.c   |    2 +-
frontends/cx24110.c |    4 ++--
frontends/cx24123.c |    6 +++---
3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
index 3e35931..7b76468 100644
--- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -213,7 +213,7 @@ static int cx24108_tuner_set_params(struct dvb_frontend* fe, struct dvb_frontend
 		freq = 2150000; /* satellite IF is 950..2150MHz */
 
 	/* decide which VCO to use for the input frequency */
-	for(i=1;(i<sizeof(osci)/sizeof(osci[0]))&&(osci[i]<freq);i++);
+	for(i=1;(i<ARRAY_SIZE(osci))&&(osci[i]<freq);i++);
 	printk("cx24108 debug: select vco #%d (f=%d)\n",i,freq);
 	band=bandsel[i];
 	/* the gain values must be set by SetSymbolrate */
diff --git a/drivers/media/dvb/frontends/cx24110.c b/drivers/media/dvb/frontends/cx24110.c
index ae96395..c3bf275 100644
--- a/drivers/media/dvb/frontends/cx24110.c
+++ b/drivers/media/dvb/frontends/cx24110.c
@@ -254,7 +254,7 @@ static int cx24110_set_symbolrate (struct cx24110_state* state, u32 srate)
 	if (srate<500000)
 		srate=500000;
 
-	for(i=0;(i<sizeof(bands)/sizeof(bands[0]))&&(srate>bands[i]);i++)
+	for(i = 0; (i < ARRAY_SIZE(bands)) && (srate > bands[i]); i++)
 		;
 	/* first, check which sample rate is appropriate: 45, 60 80 or 90 MHz,
 	   and set the PLL accordingly (R07[1:0] Fclk, R06[7:4] PLLmult,
@@ -361,7 +361,7 @@ static int cx24110_initfe(struct dvb_frontend* fe)
 
 	dprintk("%s: init chip\n", __FUNCTION__);
 
-	for(i=0;i<sizeof(cx24110_regdata)/sizeof(cx24110_regdata[0]);i++) {
+	for(i = 0; i < ARRAY_SIZE(cx24110_regdata); i++) {
 		cx24110_writereg(state, cx24110_regdata[i].reg, cx24110_regdata[i].data);
 	};
 
diff --git a/drivers/media/dvb/frontends/cx24123.c b/drivers/media/dvb/frontends/cx24123.c
index a356d28..732e94a 100644
--- a/drivers/media/dvb/frontends/cx24123.c
+++ b/drivers/media/dvb/frontends/cx24123.c
@@ -507,7 +507,7 @@ static int cx24123_pll_calculate(struct dvb_frontend* fe, struct dvb_frontend_pa
 	int i = 0;
 	int pump = 2;
 	int band = 0;
-	int num_bands = sizeof(cx24123_bandselect_vals) / sizeof(cx24123_bandselect_vals[0]);
+	int num_bands = ARRAY_SIZE(cx24123_bandselect_vals);
 
 	/* Defaults for low freq, low rate */
 	state->VCAarg = cx24123_AGC_vals[0].VCAprogdata;
@@ -516,7 +516,7 @@ static int cx24123_pll_calculate(struct dvb_frontend* fe, struct dvb_frontend_pa
 	vco_div = cx24123_bandselect_vals[0].VCOdivider;
 
 	/* For the given symbol rate, determine the VCA, VGA and FILTUNE programming bits */
-	for (i = 0; i < sizeof(cx24123_AGC_vals) / sizeof(cx24123_AGC_vals[0]); i++)
+	for (i = 0; i < ARRAY_SIZE(cx24123_AGC_vals); i++)
 	{
 		if ((cx24123_AGC_vals[i].symbolrate_low <= p->u.qpsk.symbol_rate) &&
 		    (cx24123_AGC_vals[i].symbolrate_high >= p->u.qpsk.symbol_rate) ) {
@@ -658,7 +658,7 @@ static int cx24123_initfe(struct dvb_frontend* fe)
 	dprintk("%s:  init frontend\n",__FUNCTION__);
 
 	/* Configure the demod to a good set of defaults */
-	for (i = 0; i < sizeof(cx24123_regdata) / sizeof(cx24123_regdata[0]); i++)
+	for (i = 0; i < ARRAY_SIZE(cx24123_regdata); i++)
 		cx24123_writereg(state, cx24123_regdata[i].reg, cx24123_regdata[i].data);
 
 	/* Set the LNB polarity */

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
