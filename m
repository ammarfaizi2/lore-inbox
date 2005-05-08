Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVEHTJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVEHTJw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbVEHTJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:09:52 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:55190 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262791AbVEHTJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:32 -0400
Message-Id: <20050508184345.711414000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:34 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttpci-budget-knc1.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 05/37] add support for KNC-1 cards
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support KNC-1 Plus DVB-T and similar KNC-1 cards (Alexander Riedel)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/ttpci/budget-av.c |   14 ++++++++++++++
 drivers/media/dvb/ttpci/budget.h    |    3 +++
 2 files changed, 17 insertions(+)

Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-av.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/budget-av.c	2005-05-08 18:23:20.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-av.c	2005-05-08 20:24:44.000000000 +0200
@@ -701,7 +701,10 @@ static u8 read_pwm(struct budget_av *bud
 static void frontend_init(struct budget_av *budget_av)
 {
 	switch (budget_av->budget.dev->pci->subsystem_device) {
+	case 0x0011:		// KNC1 DVB-S Plus budget with AV IN (stv0299/Philips SU1278(tsa5059))
+		saa7146_write(budget_av->budget.dev, GPIO_CTRL, 0x50000000); // Enable / PowerON Frontend
 	case 0x4f56:		// Typhoon/KNC1 DVB-S budget (stv0299/Philips SU1278(tsa5059))
+	case 0x0010:		// KNC1 DVB-S budget (stv0299/Philips SU1278(tsa5059))
 		budget_av->budget.dvb_frontend =
 			stv0299_attach(&typhoon_config, &budget_av->budget.i2c_adap);
 		if (budget_av->budget.dvb_frontend != NULL) {
@@ -709,6 +712,8 @@ static void frontend_init(struct budget_
 		}
 		break;
 
+	case 0x0021:		// KNC1 DVB-C Plus budget with AV IN (tda10021/Philips CU1216(tua6034))
+		saa7146_write(budget_av->budget.dev, GPIO_CTRL, 0x50000000); // Enable / PowerON Frontend
 	case 0x0020:		// KNC1 DVB-C budget (tda10021/Philips CU1216(tua6034))
 		budget_av->budget.dvb_frontend =
 			tda10021_attach(&philips_cu1216_config,
@@ -718,6 +723,8 @@ static void frontend_init(struct budget_
 		}
 		break;
 
+	case 0x0031:		// KNC1 DVB-T Plus budget with AV IN (tda10046/Philips TU1216(tda6651tt))
+		saa7146_write(budget_av->budget.dev, GPIO_CTRL, 0x50000000); // Enable / PowerON Frontend
 	case 0x0030:		// KNC1 DVB-T budget (tda10046/Philips TU1216(tda6651tt))
 		budget_av->budget.dvb_frontend =
 			tda10046_attach(&philips_tu1216_config, &budget_av->budget.i2c_adap);
@@ -963,14 +970,21 @@ static struct saa7146_extension budget_e
 MAKE_BUDGET_INFO(knc1s, "KNC1 DVB-S", BUDGET_KNC1S);
 MAKE_BUDGET_INFO(knc1c, "KNC1 DVB-C", BUDGET_KNC1C);
 MAKE_BUDGET_INFO(knc1t, "KNC1 DVB-T", BUDGET_KNC1T);
+MAKE_BUDGET_INFO(knc1sp, "KNC1 DVB-S Plus", BUDGET_KNC1SP);
+MAKE_BUDGET_INFO(knc1cp, "KNC1 DVB-C Plus", BUDGET_KNC1CP);
+MAKE_BUDGET_INFO(knc1tp, "KNC1 DVB-T Plus", BUDGET_KNC1TP);
 MAKE_BUDGET_INFO(cin1200s, "TerraTec Cinergy 1200 DVB-S", BUDGET_CIN1200S);
 MAKE_BUDGET_INFO(cin1200c, "Terratec Cinergy 1200 DVB-C", BUDGET_CIN1200C);
 MAKE_BUDGET_INFO(cin1200t, "Terratec Cinergy 1200 DVB-T", BUDGET_CIN1200T);
 
 static struct pci_device_id pci_tbl[] = {
 	MAKE_EXTENSION_PCI(knc1s, 0x1131, 0x4f56),
+	MAKE_EXTENSION_PCI(knc1s, 0x1131, 0x0010),
+	MAKE_EXTENSION_PCI(knc1sp, 0x1131, 0x0011),
 	MAKE_EXTENSION_PCI(knc1c, 0x1894, 0x0020),
+	MAKE_EXTENSION_PCI(knc1cp, 0x1894, 0x0021),
 	MAKE_EXTENSION_PCI(knc1t, 0x1894, 0x0030),
+	MAKE_EXTENSION_PCI(knc1tp, 0x1894, 0x0031),
 	MAKE_EXTENSION_PCI(cin1200s, 0x153b, 0x1154),
 	MAKE_EXTENSION_PCI(cin1200c, 0x153b, 0x1156),
 	MAKE_EXTENSION_PCI(cin1200t, 0x153b, 0x1157),
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/budget.h	2005-05-08 18:23:20.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget.h	2005-05-08 20:24:44.000000000 +0200
@@ -92,6 +92,9 @@ static struct saa7146_pci_extension_data
 #define BUDGET_KNC1S		   8
 #define BUDGET_KNC1C		   9
 #define BUDGET_KNC1T		   10
+#define BUDGET_KNC1SP		   11
+#define BUDGET_KNC1CP		   12
+#define BUDGET_KNC1TP		   13
 
 #define BUDGET_VIDEO_PORTA         0
 #define BUDGET_VIDEO_PORTB         1

--

