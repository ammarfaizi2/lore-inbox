Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbULHUaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbULHUaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbULHUaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:30:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14788 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261350AbULHUaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:30:07 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Put memory in DMA zone not Normal zone in FRV arch
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.2
Date: Wed, 08 Dec 2004 20:30:02 +0000
Message-ID: <10434.1102537802@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the FR-V arch put all its memory in the DMA zone
rather than the Normal zone since all the memory is available as a DMA target.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-memzone-2610rc2mm3-3.diff 
 init.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/arch/frv/mm/init.c linux-2.6.10-rc2-mm3-shmem/arch/frv/mm/init.c
--- linux-2.6.10-rc2-mm3-mmcleanup/arch/frv/mm/init.c	2004-11-22 10:53:41.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/arch/frv/mm/init.c	2004-12-01 16:03:56.000000000 +0000
@@ -125,8 +125,8 @@ void __init paging_init(void)
 
 	/* distribute the allocatable pages across the various zones and pass them to the allocator
 	 */
-	zones_size[ZONE_DMA]     = 0 >> PAGE_SHIFT;
-	zones_size[ZONE_NORMAL]  = max_low_pfn - min_low_pfn;
+	zones_size[ZONE_DMA]     = max_low_pfn - min_low_pfn;
+	zones_size[ZONE_NORMAL]  = 0; 
 #ifdef CONFIG_HIGHMEM
 	zones_size[ZONE_HIGHMEM] = num_physpages - num_mappedpages;
 #endif
