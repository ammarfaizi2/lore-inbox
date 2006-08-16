Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWHPMFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWHPMFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWHPMFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:05:34 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:59486 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751126AbWHPMFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:05:33 -0400
Date: Wed, 16 Aug 2006 14:05:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: dasd slab cache alignment.
Message-ID: <20060816120530.GB24551@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] dasd slab cache alignment.

The dasd_page_cache should return page addresses and therefore the
cache must be created with an alignment of PAGE_SIZE.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-08-16 13:36:32.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-08-16 13:36:32.000000000 +0200
@@ -264,8 +264,9 @@ dasd_parse_keyword( char *parsestring ) 
 		if (dasd_page_cache)
 			return residual_str;
 		dasd_page_cache =
-			kmem_cache_create("dasd_page_cache", PAGE_SIZE, 0,
-					  SLAB_CACHE_DMA, NULL, NULL );
+			kmem_cache_create("dasd_page_cache", PAGE_SIZE,
+					  PAGE_SIZE, SLAB_CACHE_DMA,
+					  NULL, NULL );
 		if (!dasd_page_cache)
 			MESSAGE(KERN_WARNING, "%s", "Failed to create slab, "
 				"fixed buffer mode disabled.");
