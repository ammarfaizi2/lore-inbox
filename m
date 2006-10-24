Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWJXMbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWJXMbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbWJXMbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:31:12 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:29668 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161029AbWJXMbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:31:10 -0400
Date: Tue, 24 Oct 2006 14:31:06 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [patch -mm] optional ZONE_DMA for s390
Message-ID: <20061024123106.GA7118@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

For non-64BIT systems all memory is DMA capable.

Cc: Christoph Lameter <clameter@sgi.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/Kconfig   |    4 ++--
 arch/s390/mm/init.c |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.19-rc2-mm2/arch/s390/Kconfig
===================================================================
--- linux-2.6.19-rc2-mm2.orig/arch/s390/Kconfig	2006-10-24 14:19:18.000000000 +0200
+++ linux-2.6.19-rc2-mm2/arch/s390/Kconfig	2006-10-24 14:19:40.000000000 +0200
@@ -8,8 +8,8 @@
 	default y
 
 config ZONE_DMA
-	bool
-	default y
+	def_bool y
+	depends on 64BIT
 
 config LOCKDEP_SUPPORT
 	bool
Index: linux-2.6.19-rc2-mm2/arch/s390/mm/init.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/arch/s390/mm/init.c	2006-10-24 14:19:32.000000000 +0200
+++ linux-2.6.19-rc2-mm2/arch/s390/mm/init.c	2006-10-24 14:19:52.000000000 +0200
@@ -106,7 +106,6 @@
 	ro_end_pfn = PFN_UP((unsigned long)&__end_rodata);
 
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-	max_zone_pfns[ZONE_DMA] = max_low_pfn;
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 	free_area_init_nodes(max_zone_pfns);
 
