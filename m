Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWBGPkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWBGPkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWBGPki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:40:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45724 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751124AbWBGPkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:40:25 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 08/16] Support for Galaxis DVB-S rev1.3
Date: Tue, 07 Feb 2006 13:33:32 -0200
Message-id: <20060207153332.PS07433200008@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Endriss <o.endriss@gmx.de>

support for Galaxis DVB-S rev1.3 (subsystem 13c2:0004)

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/ttpci/av7110.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
index 2749490..d36369e 100644
--- a/drivers/media/dvb/ttpci/av7110.c
+++ b/drivers/media/dvb/ttpci/av7110.c
@@ -2329,6 +2329,17 @@ static int frontend_init(struct av7110 *
 			av7110->fe = ves1820_attach(&alps_tdbe2_config, &av7110->i2c_adap, read_pwm(av7110));
 			break;
 
+		case 0x0004: // Galaxis DVB-S rev1.3
+			/* ALPS BSRV2 */
+			av7110->fe = ves1x93_attach(&alps_bsrv2_config, &av7110->i2c_adap);
+			if (av7110->fe) {
+				av7110->fe->ops->diseqc_send_master_cmd = av7110_diseqc_send_master_cmd;
+				av7110->fe->ops->diseqc_send_burst = av7110_diseqc_send_burst;
+				av7110->fe->ops->set_tone = av7110_set_tone;
+				av7110->recover = dvb_s_recover;
+			}
+			break;
+
 		case 0x0006: /* Fujitsu-Siemens DVB-S rev 1.6 */
 			/* Grundig 29504-451 */
 			av7110->fe = tda8083_attach(&grundig_29504_451_config, &av7110->i2c_adap);
@@ -2930,6 +2941,7 @@ MAKE_AV7110_INFO(tts_1_3se,  "Technotren
 MAKE_AV7110_INFO(ttt,        "Technotrend/Hauppauge DVB-T");
 MAKE_AV7110_INFO(fsc,        "Fujitsu Siemens DVB-C");
 MAKE_AV7110_INFO(fss,        "Fujitsu Siemens DVB-S rev1.6");
+MAKE_AV7110_INFO(gxs_1_3,    "Galaxis DVB-S rev1.3");
 
 static struct pci_device_id pci_tbl[] = {
 	MAKE_EXTENSION_PCI(fsc,         0x110a, 0x0000),
@@ -2937,13 +2949,13 @@ static struct pci_device_id pci_tbl[] = 
 	MAKE_EXTENSION_PCI(ttt_1_X,     0x13c2, 0x0001),
 	MAKE_EXTENSION_PCI(ttc_2_X,     0x13c2, 0x0002),
 	MAKE_EXTENSION_PCI(tts_2_X,     0x13c2, 0x0003),
+	MAKE_EXTENSION_PCI(gxs_1_3,     0x13c2, 0x0004),
 	MAKE_EXTENSION_PCI(fss,         0x13c2, 0x0006),
 	MAKE_EXTENSION_PCI(ttt,         0x13c2, 0x0008),
 	MAKE_EXTENSION_PCI(ttc_1_X,     0x13c2, 0x000a),
 	MAKE_EXTENSION_PCI(tts_2_3,     0x13c2, 0x000e),
 	MAKE_EXTENSION_PCI(tts_1_3se,   0x13c2, 0x1002),
 
-/*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0004), UNDEFINED CARD */ // Galaxis DVB PC-Sat-Carte
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0005), UNDEFINED CARD */ // Technisat SkyStar1
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0009), UNDEFINED CARD */ // TT/Hauppauge WinTV Nexus-CA v????
 

