Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWHJToh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWHJToh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWHJTnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:43:09 -0400
Received: from mx1.suse.de ([195.135.220.2]:35217 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932625AbWHJThd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:33 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [132/145] x86_64: fix bus numbering format in mmconfig warning
Message-Id: <20060810193732.19AC713B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:32 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Brice Goglin <brice@myri.com>

Make an mmconfig warning print the bus id with a regular format.

Signed-off-by: Brice Goglin <brice@myri.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/x86_64/pci/mmconfig.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux/arch/x86_64/pci/mmconfig.c
===================================================================
--- linux.orig/arch/x86_64/pci/mmconfig.c
+++ linux/arch/x86_64/pci/mmconfig.c
@@ -156,9 +156,8 @@ static __init void unreachable_devices(v
 			addr = pci_dev_base(0, k, PCI_DEVFN(i, 0));
 			if (addr == NULL|| readl(addr) != val1) {
 				set_bit(i + 32*k, fallback_slots);
-				printk(KERN_NOTICE
-				"PCI: No mmconfig possible on device %x:%x\n",
-					k, i);
+				printk(KERN_NOTICE "PCI: No mmconfig possible"
+				       " on device %02x:%02x\n", k, i);
 			}
 		}
 	}
