Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263279AbVCDVr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbVCDVr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbVCDVpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:45:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:36001 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263109AbVCDUyQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:16 -0500
Cc: bjorn.helgaas@hp.com
Subject: [PATCH] PCI: NUMA-Q PCI config access arg validation
In-Reply-To: <11099696363673@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:56 -0800
Message-Id: <11099696361594@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.12, 2005/02/07 16:20:50-08:00, bjorn.helgaas@hp.com

[PATCH] PCI: NUMA-Q PCI config access arg validation

Fix NUMA-Q PCI config access bus validation.  "bus" indexes
into BUS2QUAD, which is mp_bus_id_to_node[MAX_MP_BUSSES].

This depends on the "pci_raw_ops should use unsigned args"
patch I posted earlier today (no functional dependency; it
just happens to be very close textually).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Martin J. Bligh <mbligh@aracnet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 arch/i386/pci/numa.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/arch/i386/pci/numa.c b/arch/i386/pci/numa.c
--- a/arch/i386/pci/numa.c	2005-03-04 12:42:52 -08:00
+++ b/arch/i386/pci/numa.c	2005-03-04 12:42:52 -08:00
@@ -18,7 +18,7 @@
 {
 	unsigned long flags;
 
-	if (!value || (bus > MAX_MP_BUSSES) || (devfn > 255) || (reg > 255))
+	if (!value || (bus >= MAX_MP_BUSSES) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
@@ -46,7 +46,7 @@
 {
 	unsigned long flags;
 
-	if ((bus > MAX_MP_BUSSES) || (devfn > 255) || (reg > 255)) 
+	if ((bus >= MAX_MP_BUSSES) || (devfn > 255) || (reg > 255)) 
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);

