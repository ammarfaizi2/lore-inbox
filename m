Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbTAICsu>; Wed, 8 Jan 2003 21:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTAICrC>; Wed, 8 Jan 2003 21:47:02 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:16100 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261523AbTAICqk>;
	Wed, 8 Jan 2003 21:46:40 -0500
Date: Wed, 8 Jan 2003 18:55:20 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : IrCOMM status init fixes
Message-ID: <20030109025520.GF19178@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir254_ircomm_dce.diff :
---------------------
		<Patch from Jan Kiszka>
	o [CORRECT] Properly initialise IrCOMM status line (DCE settings)


diff -u -p linux/net/irda/ircomm/ircomm_param.d5.c linux/net/irda/ircomm/ircomm_param.c
--- linux/net/irda/ircomm/ircomm_param.d5.c	Wed Jan  8 17:40:08 2003
+++ linux/net/irda/ircomm/ircomm_param.c	Wed Jan  8 17:51:19 2003
@@ -442,7 +442,9 @@ static int ircomm_param_dte(void *instan
 		param->pv.i = self->settings.dte;
 	else {
 		dte = (__u8) param->pv.i;
-		
+
+		self->settings.dce = 0;
+				
 		if (dte & IRCOMM_DELTA_DTR)
 			self->settings.dce |= (IRCOMM_DELTA_DSR|
 					      IRCOMM_DELTA_RI |
diff -u -p linux/net/irda/ircomm/ircomm_tty.d5.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d5.c	Wed Jan  8 17:40:17 2003
+++ linux/net/irda/ircomm/ircomm_tty.c	Wed Jan  8 17:53:22 2003
@@ -490,7 +490,8 @@ static int ircomm_tty_open(struct tty_st
 	if (line < 0x10) {
 		self->service_type = IRCOMM_3_WIRE | IRCOMM_9_WIRE;
 		self->settings.service_type = IRCOMM_9_WIRE; /* 9 wire as default */
-		self->settings.dce = IRCOMM_CTS | IRCOMM_CD; /* Default line settings */
+		/* Jan Kiszka -> add DSR/RI -> Conform to IrCOMM spec */
+		self->settings.dce = IRCOMM_CTS | IRCOMM_CD | IRCOMM_DSR | IRCOMM_RI; /* Default line settings */
 		IRDA_DEBUG(2, "%s(), IrCOMM device\n", __FUNCTION__ );
 	} else {
 		IRDA_DEBUG(2, "%s(), IrLPT device\n", __FUNCTION__ );
