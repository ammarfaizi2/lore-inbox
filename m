Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbVIMWtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbVIMWtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbVIMWtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:49:12 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:42744 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964915AbVIMWtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:49:10 -0400
Date: Tue, 13 Sep 2005 19:17:58 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: kristen.c.accardi@intel.com
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] shpchp: Use dword accessors for PCI_ROM_ADDRESS
Message-ID: <20050913191758.D10911@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-reply-to: <20050913182550.A10911@mail.kroptech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI_ROM_ADDRESS is a 32 bit register and as such should be accessed
using pci_bus_{read,write}_config_dword(). A recent audit of drivers/
turned up several cases of byte- and word-sized accesses. The harmful
ones were fixed by Linus directly. This patches up one of the remaining
harmless-but-still-wrong cases caught in the dragnet.

Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>

--- linux-2.6.14-rc1.orig/drivers/pci/hotplug/shpchp_ctrl.c	2005-08-29 09:04:07.000000000 -0400
+++ linux-2.6.14-rc1/drivers/pci/hotplug/shpchp_ctrl.c	2005-09-13 11:50:34.000000000 -0400
@@ -2824,8 +2824,7 @@
 		}
 #endif
 		/* Disable ROM base Address */
-		temp_word = 0x00L;
-		rc = pci_bus_write_config_word (pci_bus, devfn, PCI_ROM_ADDRESS, temp_word);
+		rc = pci_bus_write_config_dword (pci_bus, devfn, PCI_ROM_ADDRESS, 0x00);
 
 		/* Set HP parameters (Cache Line Size, Latency Timer) */
 		rc = shpchprm_set_hpp(ctrl, func, PCI_HEADER_TYPE_NORMAL);
