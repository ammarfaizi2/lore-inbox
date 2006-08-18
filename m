Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWHROuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWHROuw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWHROuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:50:52 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:57 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1030453AbWHROuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:50:51 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] PCI: fix ICH6 quirks
Date: Fri, 18 Aug 2006 16:50:40 +0200
User-Agent: KMail/1.7.2
Cc: Jean Delvare <khali@linux-fr.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-pci" <linux-pci@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181650.41869.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-01.tornado.cablecom.ch 1378;
	Body=5 Fuz1=5 Fuz2=5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: fix ICH6 quirks

- add the ICH6(R) LPC to the ICH6 ACPI quirks. currently only the ICH6-M is
  handled. [ PCI_DEVICE_ID_INTEL_ICH6_1 is the ICH6-M LPC, ICH6_0 is the ICH6(R) ]
- remove the wrong quirk calling asus_hides_smbus_lpc() for ICH6. the register
  modified in asus_hides_smbus_lpc() has a different meaning in ICH6.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Jean Delvare <khali@linux-fr.org>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index fb08bc9..e4bd137 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -438,6 +438,7 @@ static void __devinit quirk_ich6_lpc_acp
 	pci_read_config_dword(dev, 0x48, &region);
 	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1, "ICH6 GPIO");
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc_acpi );
 
 /*
@@ -1091,7 +1092,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc );
 
 static void __init asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
 {
