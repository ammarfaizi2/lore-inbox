Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262947AbVEHUhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbVEHUhD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVEHUUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:20:42 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:663 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262931AbVEHTKH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:07 -0400
Message-Id: <20050508184348.468995000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:54 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-cleanup2.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 25/37] frontends: misc. minor cleanups
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

misc. minor cleanups, select FW_LOADER and add a help text to DVB_OR51132

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/Kconfig   |   22 +++++++++++++---------
 drivers/media/dvb/frontends/mt352.h   |    6 ------
 drivers/media/dvb/frontends/nxt2002.c |    2 --
 drivers/media/dvb/frontends/tda80xx.c |    2 +-
 4 files changed, 14 insertions(+), 18 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/Kconfig
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/Kconfig	2005-05-08 15:55:37.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/Kconfig	2005-05-08 16:33:48.000000000 +0200
@@ -12,10 +12,10 @@ config DVB_STV0299
 
 config DVB_CX24110
 	tristate "Conexant CX24110 based"
- 	depends on DVB_CORE
- 	help
+	depends on DVB_CORE
+	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
- 
+
 config DVB_TDA8083
 	tristate "Philips TDA8083 based"
 	depends on DVB_CORE
@@ -127,8 +127,8 @@ comment "DVB-C (cable) frontends"
 config DVB_ATMEL_AT76C651
 	tristate "Atmel AT76C651 based"
 	depends on DVB_CORE
-        help
- 	  A DVB-C tuner module. Say Y when you want to support this frontend.
+	help
+	  A DVB-C tuner module. Say Y when you want to support this frontend.
 
 config DVB_VES1820
 	tristate "VLSI VES1820 based"
@@ -158,10 +158,6 @@ config DVB_NXT2002
 	help
 	  An ATSC 8VSB tuner module. Say Y when you want to support this frontend.
 
-config DVB_OR51132
-	tristate "OR51132 based (pcHDTV)"
-	depends on DVB_CORE
-
 config DVB_OR51211
 	tristate "or51211 based (pcHDTV HD2000 card)"
 	depends on DVB_CORE
@@ -169,4 +165,12 @@ config DVB_OR51211
 	help
 	  An ATSC 8VSB tuner module. Say Y when you want to support this frontend.
 
+config DVB_OR51132
+	tristate "OR51132 based (pcHDTV HD3000 card)"
+	depends on DVB_CORE
+	select FW_LOADER
+	help
+	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want
+	  to support this frontend.
+
 endmenu
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/mt352.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/mt352.h	2005-05-08 16:32:39.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/mt352.h	2005-05-08 16:33:48.000000000 +0200
@@ -63,9 +63,3 @@ extern struct dvb_frontend* mt352_attach
 extern int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen);
 
 #endif // MT352_H
-
-/*
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/tda80xx.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/tda80xx.c	2005-05-08 16:21:47.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/tda80xx.c	2005-05-08 16:33:48.000000000 +0200
@@ -27,7 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/threads.h>
 #include <linux/interrupt.h>
-#include <asm/irq.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/nxt2002.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/nxt2002.c	2005-05-08 16:21:47.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/nxt2002.c	2005-05-08 16:33:48.000000000 +0200
@@ -343,8 +343,6 @@ static int nxt2002_setup_frontend_parame
 	/* reset the agc now that tuning has been completed */
 	nxt2002_agc_reset(state);
 
-
-
 	/* set target power level */
 	switch (p->u.vsb.modulation) {
 		case QAM_64:

--

