Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWBBAVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWBBAVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 19:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWBBAVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 19:21:24 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:50886 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751404AbWBBAVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 19:21:23 -0500
Date: Wed, 1 Feb 2006 18:21:09 -0600
To: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Dave Jones <davej@redhat.com>,
       linuxppc64-dev@ozlabs.org
Subject: [PATCH 2/2]: PowerPC/PCI Hotplug build break
Message-ID: <20060202002109.GB24916@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply ASAP:

Build break: Building PCI hotplug on PowerPC results in
a build break, due to failure to export symbols.

Reported today by Dave Jones <davej@redhat.com>:
drivers/pci/hotplug/rpaphp.ko needs unknown symbol pcibios_add_pci_devices

This patch fixes same problem in drivers/pci tree
Previous patch fixes the break in the arch/powerpc tree.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
---
 rpaphp_slot.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.16-rc1-git5/drivers/pci/hotplug/rpaphp_slot.c
===================================================================
--- linux-2.6.16-rc1-git5.orig/drivers/pci/hotplug/rpaphp_slot.c	2006-02-01 18:06:06.022722369 -0600
+++ linux-2.6.16-rc1-git5/drivers/pci/hotplug/rpaphp_slot.c	2006-02-01 18:11:46.049970222 -0600
@@ -159,6 +159,7 @@
 	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
 	return retval;
 }
+EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
 
 int rpaphp_register_slot(struct slot *slot)
 {
