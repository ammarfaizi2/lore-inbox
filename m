Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVCRWXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVCRWXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVCRWWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:22:45 -0500
Received: from fmr22.intel.com ([143.183.121.14]:22494 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262293AbVCRWQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:16:40 -0500
Date: Fri, 18 Mar 2005 14:16:30 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, tony.luck@intel.com, len.brown@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: [patch 09/12] Read bridge resources when fixing up the bus
Message-ID: <20050318141630.I1145@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Read bridge io/mem/pfmem ranges when fixing up the bus so that 
bus resources are tracked. This is required to properly support
pci end device and bridge hotplug.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
---

 linux-2.6.11-mm4-iohp-rshah1/arch/ia64/pci/pci.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN arch/ia64/pci/pci.c~ia64-read_bridge_bases arch/ia64/pci/pci.c
--- linux-2.6.11-mm4-iohp/arch/ia64/pci/pci.c~ia64-read_bridge_bases	2005-03-16 13:07:30.503257168 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/arch/ia64/pci/pci.c	2005-03-16 13:07:30.612632167 -0800
@@ -436,6 +436,10 @@ pcibios_fixup_bus (struct pci_bus *b)
 {
 	struct pci_dev *dev;
 
+	if (b->self) {
+		pci_read_bridge_bases(b);
+		pcibios_fixup_device_resources(b->self);
+	}
 	list_for_each_entry(dev, &b->devices, bus_list)
 		pcibios_fixup_device_resources(dev);
 
_
