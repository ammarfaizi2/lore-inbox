Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVCVCbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVCVCbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVCVCbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:31:12 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:58507 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262355AbVCVBgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:38 -0500
Message-Id: <20050322013459.231628000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:09 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-kfree-null.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 36/48] frontends: kfree() cleanup
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kfree(NULL) is safe (Kenneth Aafloy)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 bt8xx/dst.c               |    2 +-
 dvb-core/dvb_ca_en50221.c |    3 +--
 dvb-core/dvb_frontend.c   |    3 +--
 dvb-core/dvbdev.c         |    4 +---
 frontends/at76c651.c      |    2 +-
 frontends/cx22700.c       |    2 +-
 frontends/cx22702.c       |    2 +-
 frontends/cx24110.c       |    2 +-
 frontends/dib3000mb.c     |    3 +--
 frontends/dib3000mc.c     |    3 +--
 frontends/dvb_dummy_fe.c  |    2 +-
 frontends/l64781.c        |    2 +-
 frontends/mt312.c         |    3 +--
 frontends/mt352.c         |    2 +-
 frontends/nxt2002.c       |    2 +-
 frontends/nxt6000.c       |    2 +-
 frontends/or51211.c       |    2 +-
 frontends/sp8870.c        |    2 +-
 frontends/sp887x.c        |    2 +-
 frontends/stv0297.c       |    3 +--
 frontends/stv0299.c       |    2 +-
 frontends/tda10021.c      |    2 +-
 frontends/tda1004x.c      |    2 +-
 frontends/tda8083.c       |    2 +-
 frontends/tda80xx.c       |    2 +-
 frontends/ves1820.c       |    2 +-
 frontends/ves1x93.c       |    2 +-
 ttusb-dec/ttusbdecfe.c    |    4 ++--
 28 files changed, 29 insertions(+), 37 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/bt8xx/dst.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/bt8xx/dst.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/bt8xx/dst.c	2005-03-22 00:27:13.000000000 +0100
@@ -998,7 +998,7 @@ struct dvb_frontend* dst_attach(const st
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-03-22 00:23:49.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-03-22 00:27:13.000000000 +0100
@@ -1733,8 +1733,7 @@ int dvb_ca_en50221_init(struct dvb_adapt
 	if (ca != NULL) {
 		if (ca->dvbdev != NULL)
 			dvb_unregister_device(ca->dvbdev);
-		if (ca->slot_info != NULL)
-			kfree(ca->slot_info);
+		kfree(ca->slot_info);
 		kfree(ca);
 	}
 	pubca->private = NULL;
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-03-22 00:27:13.000000000 +0100
@@ -908,8 +908,7 @@ int dvb_unregister_frontend(struct dvb_f
 	else
 		printk("dvb_frontend: Demodulator (%s) does not have a release callback!\n", fe->ops->info.name);
 	/* fe is invalid now */
-	if (fepriv)
-		kfree(fepriv);
+	kfree(fepriv);
 	up (&frontend_mutex);
 	return 0;
 }
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvbdev.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvbdev.c	2005-03-22 00:16:28.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvbdev.c	2005-03-22 00:27:13.000000000 +0100
@@ -395,9 +395,7 @@ int dvb_usercopy(struct inode *inode, st
         }
 
 out:
-        if (mbuf)
-                kfree(mbuf);
-
+        kfree(mbuf);
         return err;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/at76c651.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/at76c651.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/at76c651.c	2005-03-22 00:27:13.000000000 +0100
@@ -402,7 +402,7 @@ struct dvb_frontend* at76c651_attach(con
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/cx22700.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/cx22700.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/cx22700.c	2005-03-22 00:27:13.000000000 +0100
@@ -392,7 +392,7 @@ struct dvb_frontend* cx22700_attach(cons
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/cx22702.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/cx22702.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/cx22702.c	2005-03-22 00:27:13.000000000 +0100
@@ -476,7 +476,7 @@ struct dvb_frontend* cx22702_attach(cons
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/cx24110.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/cx24110.c	2005-03-22 00:22:33.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/cx24110.c	2005-03-22 00:27:13.000000000 +0100
@@ -608,7 +608,7 @@ struct dvb_frontend* cx24110_attach(cons
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000mb.c	2005-03-22 00:16:19.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mb.c	2005-03-22 00:27:13.000000000 +0100
@@ -738,8 +738,7 @@ struct dvb_frontend* dib3000mb_attach(co
 	return &state->frontend;
 
 error:
-	if (state)
-		kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000mc.c	2005-03-22 00:16:19.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc.c	2005-03-22 00:27:13.000000000 +0100
@@ -885,8 +885,7 @@ struct dvb_frontend* dib3000mc_attach(co
 	return &state->frontend;
 
 error:
-	if (state)
-		kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dvb_dummy_fe.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dvb_dummy_fe.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dvb_dummy_fe.c	2005-03-22 00:27:13.000000000 +0100
@@ -123,7 +123,7 @@ struct dvb_frontend* dvb_dummy_fe_ofdm_a
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/l64781.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/l64781.c	2005-03-22 00:15:55.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/l64781.c	2005-03-22 00:27:13.000000000 +0100
@@ -559,7 +559,7 @@ struct dvb_frontend* l64781_attach(const
 
 error:
 	if (reg0x3e >= 0) l64781_writereg (state, 0x3e, reg0x3e);  /* restore reg 0x3e */
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/mt312.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/mt312.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/mt312.c	2005-03-22 00:27:13.000000000 +0100
@@ -641,8 +641,7 @@ struct dvb_frontend* vp310_attach(const 
 	return &state->frontend;
 
 error:
-	if (state)
-		kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/mt352.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/mt352.c	2005-03-22 00:14:46.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/mt352.c	2005-03-22 00:27:13.000000000 +0100
@@ -581,7 +581,7 @@ struct dvb_frontend* mt352_attach(const 
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt2002.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/nxt2002.c	2005-03-22 00:17:45.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt2002.c	2005-03-22 00:27:13.000000000 +0100
@@ -661,7 +661,7 @@ struct dvb_frontend* nxt2002_attach(cons
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt6000.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/nxt6000.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt6000.c	2005-03-22 00:27:13.000000000 +0100
@@ -511,7 +511,7 @@ struct dvb_frontend* nxt6000_attach(cons
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/or51211.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/or51211.c	2005-03-22 00:18:23.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/or51211.c	2005-03-22 00:27:13.000000000 +0100
@@ -588,7 +588,7 @@ struct dvb_frontend* or51211_attach(cons
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/sp8870.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/sp8870.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/sp8870.c	2005-03-22 00:27:13.000000000 +0100
@@ -570,7 +570,7 @@ struct dvb_frontend* sp8870_attach(const
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/sp887x.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/sp887x.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/sp887x.c	2005-03-22 00:27:13.000000000 +0100
@@ -564,7 +564,7 @@ struct dvb_frontend* sp887x_attach(const
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/stv0297.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/stv0297.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/stv0297.c	2005-03-22 00:27:13.000000000 +0100
@@ -758,8 +758,7 @@ struct dvb_frontend *stv0297_attach(cons
 	return &state->frontend;
 
 error:
-	if (state)
-		kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/stv0299.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/stv0299.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/stv0299.c	2005-03-22 00:27:13.000000000 +0100
@@ -675,7 +675,7 @@ struct dvb_frontend* stv0299_attach(cons
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda10021.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/tda10021.c	2005-03-22 00:23:32.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda10021.c	2005-03-22 00:27:13.000000000 +0100
@@ -420,7 +420,7 @@ struct dvb_frontend* tda10021_attach(con
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda1004x.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/tda1004x.c	2005-03-22 00:14:18.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda1004x.c	2005-03-22 00:27:13.000000000 +0100
@@ -1097,7 +1097,7 @@ struct dvb_frontend* tda10045_attach(con
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda8083.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/tda8083.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda8083.c	2005-03-22 00:27:13.000000000 +0100
@@ -405,7 +405,7 @@ struct dvb_frontend* tda8083_attach(cons
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda80xx.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/tda80xx.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda80xx.c	2005-03-22 00:27:13.000000000 +0100
@@ -683,7 +683,7 @@ struct dvb_frontend* tda80xx_attach(cons
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/ves1820.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/ves1820.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/ves1820.c	2005-03-22 00:27:13.000000000 +0100
@@ -404,7 +404,7 @@ struct dvb_frontend* ves1820_attach(cons
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/ves1x93.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/ves1x93.c	2005-03-22 00:15:00.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/ves1x93.c	2005-03-22 00:27:13.000000000 +0100
@@ -497,7 +497,7 @@ struct dvb_frontend* ves1x93_attach(cons
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-dec/ttusbdecfe.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttusb-dec/ttusbdecfe.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-dec/ttusbdecfe.c	2005-03-22 00:27:13.000000000 +0100
@@ -169,7 +169,7 @@ struct dvb_frontend* ttusbdecfe_dvbt_att
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
@@ -195,7 +195,7 @@ struct dvb_frontend* ttusbdecfe_dvbs_att
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 

--

