Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271175AbUJVBFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271175AbUJVBFJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271166AbUJVBD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:03:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:63920 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S271164AbUJVBDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:03:38 -0400
Subject: [PATCH] ppc64: Fix boot on some non-LPAR pSeries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1098406963.6008.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 11:02:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes a problem when allocating the TCE tables (iommu) during
early boot on some non-LPAR machines with a lot of memory.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux-work.orig/arch/ppc64/kernel/prom_init.c	2004-10-20 18:38:08.911500096 +1000
+++ linux-work/arch/ppc64/kernel/prom_init.c	2004-10-21 11:30:23.570248584 +1000
@@ -675,7 +675,7 @@
 	if ( RELOC(of_platform) == PLATFORM_PSERIES_LPAR )
 		RELOC(alloc_top) = RELOC(rmo_top);
 	else
-		RELOC(alloc_top) = min(0x40000000ul, RELOC(ram_top));
+		RELOC(alloc_top) = RELOC(rmo_top) = min(0x40000000ul, RELOC(ram_top));
 	RELOC(alloc_bottom) = PAGE_ALIGN(RELOC(klimit) - offset + 0x4000);
 	RELOC(alloc_top_high) = RELOC(ram_top);
 


