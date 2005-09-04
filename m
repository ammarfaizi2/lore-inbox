Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVIDXfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVIDXfW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVIDXeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:34:50 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:56961 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932114AbVIDXbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:07 -0400
Message-Id: <20050904232336.465603000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:51 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Karl Herz <karl.herz@gmx.de>
Content-Disposition: inline; filename=dvb-ttpci-av7110-add-tt-pci-ids.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 52/54] ttpci: add PCI ids for old Siemens/TT DVB-C card
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karl Herz <karl.herz@gmx.de>

Add PCI-ids of Siemens-DVB-C card with Technotrend manufacturer id.

Signed-off-by: Karl Herz <karl.herz@gmx.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110.c	2005-09-04 22:31:00.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110.c	2005-09-04 22:31:02.000000000 +0200
@@ -168,7 +168,9 @@ static void init_av7110_av(struct av7110
 		if (ret < 0)
 			printk("dvb-ttpci:cannot switch on SCART(AD):%d\n",ret);
 		if (rgb_on &&
-		    (av7110->dev->pci->subsystem_vendor == 0x110a) && (av7110->dev->pci->subsystem_device == 0x0000)) {
+		    ((av7110->dev->pci->subsystem_vendor == 0x110a) || 
+		     (av7110->dev->pci->subsystem_vendor == 0x13c2)) && 
+		     (av7110->dev->pci->subsystem_device == 0x0000)) {
 			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // RGB on, SCART pin 16
 			//saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO); // SCARTpin 8
 		}
@@ -2868,7 +2870,7 @@ static struct saa7146_pci_extension_data
 	.ext_priv = x_name, \
 	.ext = &av7110_extension }
 
-MAKE_AV7110_INFO(tts_1_X,    "Technotrend/Hauppauge WinTV DVB-S rev1.X");
+MAKE_AV7110_INFO(tts_1_X_fsc,"Technotrend/Hauppauge WinTV DVB-S rev1.X or Fujitsu Siemens DVB-C");
 MAKE_AV7110_INFO(ttt_1_X,    "Technotrend/Hauppauge WinTV DVB-T rev1.X");
 MAKE_AV7110_INFO(ttc_1_X,    "Technotrend/Hauppauge WinTV Nexus-CA rev1.X");
 MAKE_AV7110_INFO(ttc_2_X,    "Technotrend/Hauppauge WinTV DVB-C rev2.X");
@@ -2880,16 +2882,16 @@ MAKE_AV7110_INFO(fsc,        "Fujitsu Si
 MAKE_AV7110_INFO(fss,        "Fujitsu Siemens DVB-S rev1.6");
 
 static struct pci_device_id pci_tbl[] = {
-	MAKE_EXTENSION_PCI(fsc,       0x110a, 0x0000),
-	MAKE_EXTENSION_PCI(tts_1_X,   0x13c2, 0x0000),
-	MAKE_EXTENSION_PCI(ttt_1_X,   0x13c2, 0x0001),
-	MAKE_EXTENSION_PCI(ttc_2_X,   0x13c2, 0x0002),
-	MAKE_EXTENSION_PCI(tts_2_X,   0x13c2, 0x0003),
-	MAKE_EXTENSION_PCI(fss,       0x13c2, 0x0006),
-	MAKE_EXTENSION_PCI(ttt,       0x13c2, 0x0008),
-	MAKE_EXTENSION_PCI(ttc_1_X,   0x13c2, 0x000a),
-	MAKE_EXTENSION_PCI(tts_2_3,   0x13c2, 0x000e),
-	MAKE_EXTENSION_PCI(tts_1_3se, 0x13c2, 0x1002),
+	MAKE_EXTENSION_PCI(fsc,         0x110a, 0x0000),
+	MAKE_EXTENSION_PCI(tts_1_X_fsc, 0x13c2, 0x0000),
+	MAKE_EXTENSION_PCI(ttt_1_X,     0x13c2, 0x0001),
+	MAKE_EXTENSION_PCI(ttc_2_X,     0x13c2, 0x0002),
+	MAKE_EXTENSION_PCI(tts_2_X,     0x13c2, 0x0003),
+	MAKE_EXTENSION_PCI(fss,         0x13c2, 0x0006),
+	MAKE_EXTENSION_PCI(ttt,         0x13c2, 0x0008),
+	MAKE_EXTENSION_PCI(ttc_1_X,     0x13c2, 0x000a),
+	MAKE_EXTENSION_PCI(tts_2_3,     0x13c2, 0x000e),
+	MAKE_EXTENSION_PCI(tts_1_3se,   0x13c2, 0x1002),
 
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0004), UNDEFINED CARD */ // Galaxis DVB PC-Sat-Carte
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0005), UNDEFINED CARD */ // Technisat SkyStar1

--

