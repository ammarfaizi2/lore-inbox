Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVALT2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVALT2v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVALTZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:25:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9906 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261351AbVALTWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:22:01 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050112004147.GA22156@kroah.com> 
References: <20050112004147.GA22156@kroah.com>  <20050108055142.GB8571@kroah.com> <20050106123710.GA8125@dominikbrodowski.de> <9726.1105105388@redhat.com> <26980.1105357916@redhat.com> 
To: Greg KH <greg@kroah.com>, torvalds@osdl.org
Cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Downgrade printk that complains about unsupported PCI PM caps
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 12 Jan 2005 19:21:36 +0000
Message-ID: <15971.1105557696@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch downgrades to KERN_DEBUG level the printk that issues a
notification that an unsupported version of the PCI power management registers
has been encountered by pci_set_power_state().

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 pci-pm-printk-2611rc1.diff 
 drivers/pci/pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc1/drivers/pci/pci.c linux-2.6.11-rc1-frv/drivers/pci/pci.c
--- /warthog/kernels/linux-2.6.11-rc1/drivers/pci/pci.c	2005-01-12 19:08:56.272808059 +0000
+++ linux-2.6.11-rc1-frv/drivers/pci/pci.c	2005-01-12 19:12:43.944820438 +0000
@@ -269,7 +269,7 @@ pci_set_power_state(struct pci_dev *dev,
 
 	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
 	if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
-		printk(KERN_WARNING
+		printk(KERN_DEBUG
 		       "PCI: %s has unsupported PM cap regs version (%u)\n",
 		       dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
 		return -EIO;
