Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWFTOsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWFTOsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWFTOsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:48:43 -0400
Received: from ns2.suse.de ([195.135.220.15]:64173 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751182AbWFTOsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:48:42 -0400
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>
Message-Id: <20060408134657.22479.89589.sendpatchset@linux.site>
In-Reply-To: <20060408134635.22479.79269.sendpatchset@linux.site>
References: <20060408134635.22479.79269.sendpatchset@linux.site>
Subject: [patch 2/3] radix-tree: small
Date: Tue, 20 Jun 2006 16:48:38 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce radix tree node memory usage by about a factor of 4 for small
files (< 64K). There are pointer traversal and memory usage costs for
large files with dense pagecache.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -33,7 +33,7 @@
 
 
 #ifdef __KERNEL__
-#define RADIX_TREE_MAP_SHIFT	6
+#define RADIX_TREE_MAP_SHIFT	(CONFIG_BASE_SMALL ? 4 : 6)
 #else
 #define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
 #endif
