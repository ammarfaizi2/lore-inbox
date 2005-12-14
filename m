Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVLNRhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVLNRhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVLNRhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:37:04 -0500
Received: from fmr19.intel.com ([134.134.136.18]:62931 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932423AbVLNRhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:37:01 -0500
Subject: Re: [Pcihpd-discuss] [PATCH] acpiphp: only size new bus
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com, greg@kroah.com
In-Reply-To: <439F9DC3.5020303@jp.fujitsu.com>
References: <1134524986.6886.77.camel@whizzy>
	 <439F9DC3.5020303@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 09:37:26 -0800
Message-Id: <1134581846.6118.1.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 14 Dec 2005 17:36:53.0533 (UTC) FILETIME=[F8E2FCD0:01C600D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only size the bus that has been added.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com> 

drivers/pci/hotplug/acpiphp_glue.c |    4 +++-
 drivers/pci/hotplug/acpiphp_glue.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc5.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-2.6.15-rc5/drivers/pci/hotplug/acpiphp_glue.c
@@ -794,12 +794,14 @@ static int enable_device(struct acpiphp_
 			if (PCI_SLOT(dev->devfn) != slot->device)
 				continue;
 			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
 				max = pci_scan_bridge(bus, dev, max, pass);
+				if (pass && dev->subordinate)
+					pci_bus_size_bridges(dev->subordinate);
+			}
 		}
 	}
 
-	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
 	acpiphp_sanitize_bus(bus);
 	pci_enable_bridges(bus);

