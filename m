Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVIMWmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVIMWmo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVIMWmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:42:44 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:60327 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932208AbVIMWmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:42:43 -0400
Date: Tue, 13 Sep 2005 19:11:26 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: gregkh@suse.de
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] ibmphp: Use dword accessors for PCI_ROM_ADDRESS
Message-ID: <20050913191126.B10911@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050913182550.A10911@mail.kroptech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI_ROM_ADDRESS is a 32 bit register and as such should be accessed
using pci_bus_{read,write}_config_dword(). A recent audit of drivers/
turned up several cases of byte- and word-sized accesses. The harmful
ones were fixed by Linus directly. This patches up one of the remaining
harmless-but-still-wrong cases caught in the dragnet.

Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>

--- linux-2.6.14-rc1.orig/drivers/pci/hotplug/ibmphp_pci.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.14-rc1/drivers/pci/hotplug/ibmphp_pci.c	2005-09-13 11:49:10.000000000 -0400
@@ -558,7 +558,7 @@
 	pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_CACHE_LINE_SIZE, CACHE);
 	pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_LATENCY_TIMER, LATENCY);
 
-	pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_ROM_ADDRESS, 0x00L);
+	pci_bus_write_config_dword (ibmphp_pci_bus, devfn, PCI_ROM_ADDRESS, 0x00L);
 	pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_COMMAND, DEVICEENABLE);
 
 	return 0;

