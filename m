Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVEYHNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVEYHNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 03:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVEYHM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 03:12:29 -0400
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:50055 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262323AbVEYHHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 03:07:02 -0400
Message-Id: <20050525064005.843762000.dtor_core@ameritech.net>
References: <20050525063738.864916000.dtor_core@ameritech.net>
Date: Wed, 25 May 2005 01:37:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 3/9] smsc-ircc2: drop DIM macro in favor of ARRAY_SIZE
Content-Disposition: inline; filename=ircc2-remove-dim.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRDA: smsc-ircc2 - remove home-grown DIM macro, use ARRAY_SIZE intead.
      Also fix out-of-bound array access.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 smsc-ircc2.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: dtor/drivers/net/irda/smsc-ircc2.c
===================================================================
--- dtor.orig/drivers/net/irda/smsc-ircc2.c
+++ dtor/drivers/net/irda/smsc-ircc2.c
@@ -163,7 +163,6 @@ struct smsc_ircc_cb {
 /* Constants */
 
 static const char *driver_name = "smsc-ircc2";
-#define	DIM(x)	(sizeof(x)/(sizeof(*(x))))
 #define SMSC_IRCC2_C_IRDA_FALLBACK_SPEED	9600
 #define SMSC_IRCC2_C_DEFAULT_TRANSCEIVER	1
 #define SMSC_IRCC2_C_NET_TIMEOUT		0
@@ -240,7 +239,7 @@ static smsc_transceiver_t smsc_transceiv
 	{ "ATC IRMode", smsc_ircc_set_transceiver_smsc_ircc_atc, smsc_ircc_probe_transceiver_smsc_ircc_atc },
 	{ NULL, NULL }
 };
-#define SMSC_IRCC2_C_NUMBER_OF_TRANSCEIVERS (DIM(smsc_transceivers)-1)
+#define SMSC_IRCC2_C_NUMBER_OF_TRANSCEIVERS (ARRAY_SIZE(smsc_transceivers) - 1)
 
 /*  SMC SuperIO chipsets definitions */
 
@@ -400,7 +399,7 @@ static int __init smsc_ircc_open(unsigne
 		goto err_out;
 
 	err = -ENOMEM;
-	if (dev_count > DIM(dev_self)) {
+	if (dev_count >= ARRAY_SIZE(dev_self)) {
 	        IRDA_WARNING("%s(), too many devices!\n", __FUNCTION__);
 		goto err_out1;
 	}

