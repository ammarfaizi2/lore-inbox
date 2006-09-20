Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWITNAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWITNAL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWITNAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:00:11 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:3298 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751185AbWITNAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:00:10 -0400
Date: Wed, 20 Sep 2006 14:59:52 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Subject: [-mm patch] Remove ZONE_DMA remains from avr32
Message-ID: <20060920145952.2ea78f17@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Put all available lowmem in ZONE_NORMAL now that ZONE_DMA can be
disabled (which is the right thing to do on AVR32.)

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---

Btw, 2.6.18-rc7-mm1 seems to boot on my board, but mdev (busybox's udev
replacement) seems to have a problem with symlinks so I don't have any
tty devices to log into. Using static /dev solves the problem for
now.

 arch/avr32/Kconfig   |    3 ---
 arch/avr32/mm/init.c |    3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

Index: linux-2.6.18-rc7-mm1/arch/avr32/mm/init.c
===================================================================
--- linux-2.6.18-rc7-mm1.orig/arch/avr32/mm/init.c	2006-09-20
14:07:17.000000000 +0200 +++
linux-2.6.18-rc7-mm1/arch/avr32/mm/init.c	2006-09-20
14:07:45.000000000 +0200 @@ -370,9 +370,8 @@ void __init
paging_init(void) start_pfn >>= PAGE_SHIFT; low =
pgdat->bdata->node_low_pfn; 
-		/* All memory is DMA-able */
 		memset(zones_size, 0, sizeof(zones_size));
-		zones_size[ZONE_DMA] = low - start_pfn;
+		zones_size[ZONE_NORMAL] = low - start_pfn;
 
 		printk("Node %u: start_pfn = 0x%lx, low = 0x%lx\n",
 		       nid, start_pfn, low);
Index: linux-2.6.18-rc7-mm1/arch/avr32/Kconfig
===================================================================
--- linux-2.6.18-rc7-mm1.orig/arch/avr32/Kconfig	2006-09-20
14:47:04.000000000 +0200 +++
linux-2.6.18-rc7-mm1/arch/avr32/Kconfig	2006-09-20
14:47:09.000000000 +0200 @@ -48,9 +48,6 @@ config
RWSEM_XCHGADD_ALGORITHM config GENERIC_BUST_SPINLOCK bool
 
-config GENERIC_ISA_DMA
-	bool
-
 config GENERIC_HWEIGHT
 	bool
 	default y
