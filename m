Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWBBATL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWBBATL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 19:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWBBATL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 19:19:11 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:31390 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751404AbWBBATJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 19:19:09 -0500
Date: Wed, 1 Feb 2006 18:19:06 -0600
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Dave Jones <davej@redhat.com>,
       linuxppc64-dev@ozlabs.org
Subject: [PATCH 1/2]: PowerPC/PCI Hotplug build break
Message-ID: <20060202001906.GA24916@austin.ibm.com>
References: <1138833335.6933.5.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138833335.6933.5.camel@sinatra.austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply ASAP:

Build break: Building PCI hotplug on PowerPC results in 
a build break, due to failure to export symbols.

Reported today by Dave Jones <davej@redhat.com>:
drivers/pci/hotplug/rpaphp.ko needs unknown symbol pcibios_add_pci_devices

This patch fixes the break in the arch/powerpc tree.
Next patch fixes same problem in drivers/pci tree

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

---
 pci_dlpar.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.16-rc1-git5/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- linux-2.6.16-rc1-git5.orig/arch/powerpc/platforms/pseries/pci_dlpar.c	2006-02-01 18:06:12.380829512 -0600
+++ linux-2.6.16-rc1-git5/arch/powerpc/platforms/pseries/pci_dlpar.c	2006-02-01 18:11:41.040673750 -0600
@@ -58,6 +58,7 @@
 
 	return find_bus_among_children(pdn->phb->bus, dn);
 }
+EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
 
 /**
  * pcibios_remove_pci_devices - remove all devices under this bus
@@ -106,6 +107,7 @@
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(pcibios_fixup_new_pci_devices);
 
 static int
 pcibios_pci_config_bridge(struct pci_dev *dev)
@@ -172,3 +174,4 @@
 			pcibios_pci_config_bridge(dev);
 	}
 }
+EXPORT_SYMBOL_GPL(pcibios_add_pci_devices);
