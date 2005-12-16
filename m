Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVLPAEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVLPAEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVLPAEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:04:46 -0500
Received: from cantor.suse.de ([195.135.220.2]:53903 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750885AbVLPAEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:04:46 -0500
Date: Fri, 16 Dec 2005 01:04:45 +0100
From: Andi Kleen <ak@suse.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [for 2.6.15] Fix dumb bug in mmconfig fix
Message-ID: <20051216000445.GN15804@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use correct address when referencing mmconfig aperture while checking
for broken MCFG.  This was a typo when porting the code from 64bit to 
32bit.  It caused oopses at boot on some ThinkPads. 

Should definitely go into 2.6.15.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/pci/mmconfig.c
===================================================================
--- linux.orig/arch/i386/pci/mmconfig.c
+++ linux/arch/i386/pci/mmconfig.c
@@ -155,7 +155,7 @@ static __init void unreachable_devices(v
 		addr = get_base_addr(0, 0, PCI_DEVFN(i, 0));
 		if (addr != 0)
 			pci_exp_set_dev_base(addr, 0, PCI_DEVFN(i, 0));
-		if (addr == 0 || readl((u32 *)addr) != val1)
+		if (addr == 0 || readl((u32 *)mmcfg_virt_addr) != val1)
 			set_bit(i, fallback_slots);
 		spin_unlock_irqrestore(&pci_config_lock, flags);
 	}

