Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbVKCAz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbVKCAz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbVKCAz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:55:59 -0500
Received: from fmr18.intel.com ([134.134.136.17]:29839 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030235AbVKCAz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:55:58 -0500
Subject: Re: [patch 4/4] pci: call pci_read_irq for bridges
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
In-Reply-To: <1130977482.8321.42.camel@whizzy>
References: <20051103001540.365407000@whizzy>
	 <1130977482.8321.42.camel@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Nov 2005 16:55:49 -0800
Message-Id: <1130979349.8321.50.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 03 Nov 2005 00:55:50.0962 (UTC) FILETIME=[55DE3920:01C5E011]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call pci_read_irq() for bridges too, so that the pin value
is stored for bridges that require interrupts.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

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

