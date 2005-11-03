Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVKCAZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVKCAZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVKCAZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:25:07 -0500
Received: from fmr19.intel.com ([134.134.136.18]:51407 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030220AbVKCAYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:24:47 -0500
Subject: [patch 3/4] pci: use pin stored in pci_dev
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com,
       len.brown@intel.com
References: <20051103001540.365407000@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Nov 2005 16:24:39 -0800
Message-Id: <1130977479.8321.41.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 03 Nov 2005 00:24:40.0569 (UTC) FILETIME=[FB06E690:01C5E00C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the stored value of the interrupt pin rather than try to read
the config again.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
 
 drivers/pci/pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13/drivers/pci/pci.c
===================================================================
--- linux-2.6.13.orig/drivers/pci/pci.c
+++ linux-2.6.13/drivers/pci/pci.c
@@ -567,7 +567,7 @@ pci_get_interrupt_pin(struct pci_dev *de
 {
 	u8 pin;
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pin = dev->pin;
 	if (!pin)
 		return -1;
 	pin--;

--
