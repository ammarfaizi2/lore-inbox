Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267457AbUICVLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267457AbUICVLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269112AbUICVLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:11:24 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:32180 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267457AbUICVLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:11:21 -0400
Date: Fri, 3 Sep 2004 22:10:58 +0100
From: Dave Jones <davej@redhat.com>
To: greg@kroah.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Use before NULL check in shpchp_ctrl
Message-ID: <20040903211058.GW26419@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, greg@kroah.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More fun found with the coverity checker.

Signed-off-by: Dave Jones <davej@redhat.com>


--- linux-2.6.8/drivers/pci/hotplug/shpchp_ctrl.c~	2004-09-03 22:08:33.285172888 +0100
+++ linux-2.6.8/drivers/pci/hotplug/shpchp_ctrl.c	2004-09-03 22:09:41.390819256 +0100
@@ -2163,12 +2163,14 @@
 	u32 rc = 0;
 	int ret = 0;
 	unsigned int devfn;
-	struct pci_bus *pci_bus = p_slot->ctrl->pci_dev->subordinate;
+	struct pci_bus *pci_bus;
 	struct pci_func *func;
 
 	if (!p_slot->ctrl)
 		return 1;
 
+	pci_bus = p_slot->ctrl->pci_dev->subordinate;
+
 	/* Check to see if (latch closed, card present, power on) */
 	down(&p_slot->ctrl->crit_sect);
 
