Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWDSRus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWDSRus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWDSRur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:50:47 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:28589 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751015AbWDSRur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:50:47 -0400
From: Arnaud MAZIN <arnaud.mazin@free.fr>
Subject: [patch] sonypi: correct detection of new ICH7-based laptops
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Message-Id: <20060419175001.09E0E262AF@smtp5-g19.free.fr>
Date: Wed, 19 Apr 2006 19:50:01 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simply adds the test to detect the ICH7 based Core Duo SONY laptops (such as the SZ1) as type3 models.
Tested against 2.6.16.9 vanilla.

Signed-off-by: Arnaud MAZIN < arnaud.mazin@free.fr>
Acked-by: Stelian Pop <stelian@poppies.net>

--- linux-2.6.16.9/drivers/char/sonypi.c~       2006-04-19 11:12:01.342086250 +0200
+++ linux-2.6.16.9/drivers/char/sonypi.c        2006-04-19 12:26:16.953139500 +0200
@@ -1341,6 +1341,9 @@ static int __devinit sonypi_probe(struct
        else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
                                          PCI_DEVICE_ID_INTEL_ICH6_1, NULL)))
                sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE3;
+       else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+                                         PCI_DEVICE_ID_INTEL_ICH7_1, NULL)))
+               sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE3;
        else
                sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
 
