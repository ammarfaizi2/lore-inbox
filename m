Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVKCAZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVKCAZJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVKCAZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:25:09 -0500
Received: from fmr20.intel.com ([134.134.136.19]:21688 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030221AbVKCAYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:24:49 -0500
Subject: [patch 4/4] pci: call pci_read_irq for bridges
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com,
       len.brown@intel.com
References: <20051103001540.365407000@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Nov 2005 16:24:42 -0800
Message-Id: <1130977482.8321.42.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 03 Nov 2005 00:24:43.0099 (UTC) FILETIME=[FC88F2B0:01C5E00C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call pci_read_irq() for bridges too, this ensures that the pin
value is stored for later use for bridges that require interrupts.

 drivers/pci/probe.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.13/drivers/pci/probe.c
===================================================================
--- linux-2.6.13.orig/drivers/pci/probe.c
+++ linux-2.6.13/drivers/pci/probe.c
@@ -624,6 +624,7 @@ static int pci_setup_device(struct pci_d
 		/* The PCI-to-PCI bridge spec requires that subtractive
 		   decoding (i.e. transparent) bridge must have programming
 		   interface code of 0x01. */ 
+		pci_read_irq(dev);
 		dev->transparent = ((dev->class & 0xff) == 1);
 		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
 		break;

--
