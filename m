Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbVLNBt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbVLNBt0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 20:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbVLNBt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 20:49:26 -0500
Received: from fmr18.intel.com ([134.134.136.17]:60117 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030414AbVLNBtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 20:49:25 -0500
Subject: [PATCH] acpiphp: only size new bus
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 17:49:46 -0800
Message-Id: <1134524986.6886.77.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 14 Dec 2005 01:49:16.0797 (UTC) FILETIME=[97A192D0:01C60050]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only size the bus that has been added.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com> 

drivers/pci/hotplug/acpiphp_glue.c |    4 +++-
 drivers/pci/hotplug/acpiphp_glue.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc5.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-2.6.15-rc5/drivers/pci/hotplug/acpiphp_glue.c
@@ -794,12 +794,15 @@ static int enable_device(struct acpiphp_
 			if (PCI_SLOT(dev->devfn) != slot->device)
 				continue;
 			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
 				max = pci_scan_bridge(bus, dev, max, pass);
+				if (pass)
+					if (dev->subordinate)
+						pci_bus_size_bridges(dev->subordinate);
+			}
 		}
 	}
 
-	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
 	acpiphp_sanitize_bus(bus);
 	pci_enable_bridges(bus);

