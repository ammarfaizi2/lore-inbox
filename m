Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVCVELP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVCVELP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVCVCUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:20:01 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:54154 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262310AbVCVBeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:36 -0500
Message-Id: <20050322013455.108785000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:39 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttpci-activy-budget.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 06/48] support Activy Budget card
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

support Activy Budget with ALPS BSRU6 tuner
submitted by Andreas 'randy' Weinberger.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 budget.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/budget.c	2005-03-21 23:27:59.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget.c	2005-03-22 00:14:50.000000000 +0100
@@ -444,9 +444,15 @@ static void frontend_init(struct budget 
 		if (budget->dvb_frontend) break;
 		break;
 
-	case 0x4f61: // Fujitsu Siemens Activy Budget-S PCI (tda8083/Grundig 29504-451(tsa5522))
+	case 0x4f60: // Fujitsu Siemens Activy Budget-S PCI rev AL (stv0299/ALPS BSRU6(tsa5059))
+		budget->dvb_frontend = stv0299_attach(&alps_bsru6_config, &budget->i2c_adap);
+		if (budget->dvb_frontend) {
+			budget->dvb_frontend->ops->set_voltage = siemens_budget_set_voltage;
+			break;
+		}
+		break;
 
-		// grundig 29504-451
+	case 0x4f61: // Fujitsu Siemens Activy Budget-S PCI rev GR (tda8083/Grundig 29504-451(tsa5522))
 		budget->dvb_frontend = tda8083_attach(&grundig_29504_451_config, &budget->i2c_adap);
 		if (budget->dvb_frontend) {
 			budget->dvb_frontend->ops->set_voltage = siemens_budget_set_voltage;
@@ -518,14 +524,16 @@ MAKE_BUDGET_INFO(ttbs,	"TT-Budget/WinTV-
 MAKE_BUDGET_INFO(ttbc,	"TT-Budget/WinTV-NOVA-C  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbt,	"TT-Budget/WinTV-NOVA-T  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(satel,	"SATELCO Multimedia PCI",	BUDGET_TT_HW_DISEQC);
-MAKE_BUDGET_INFO(fsacs, "Fujitsu Siemens Activy Budget-S PCI", BUDGET_FS_ACTIVY);
+MAKE_BUDGET_INFO(fsacs0, "Fujitsu Siemens Activy Budget-S PCI (rev GR/grundig frontend)", BUDGET_FS_ACTIVY);
+MAKE_BUDGET_INFO(fsacs1, "Fujitsu Siemens Activy Budget-S PCI (rev AL/alps frontend)", BUDGET_FS_ACTIVY);
 
 static struct pci_device_id pci_tbl[] = {
 	MAKE_EXTENSION_PCI(ttbs,  0x13c2, 0x1003),
 	MAKE_EXTENSION_PCI(ttbc,  0x13c2, 0x1004),
 	MAKE_EXTENSION_PCI(ttbt,  0x13c2, 0x1005),
 	MAKE_EXTENSION_PCI(satel, 0x13c2, 0x1013),
-	MAKE_EXTENSION_PCI(fsacs, 0x1131, 0x4f61),
+	MAKE_EXTENSION_PCI(fsacs1,0x1131, 0x4f60),
+	MAKE_EXTENSION_PCI(fsacs0,0x1131, 0x4f61),
 	{
 		.vendor    = 0,
 	}

--

