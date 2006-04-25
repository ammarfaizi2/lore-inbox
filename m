Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWDYExA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWDYExA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 00:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWDYEw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 00:52:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:401 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751134AbWDYEw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 00:52:59 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>
Message-Id: <20060303174228.10573.37986.sendpatchset@linux.site>
In-Reply-To: <20060303174218.10573.71812.sendpatchset@linux.site>
References: <20060303174218.10573.71812.sendpatchset@linux.site>
Subject: [patch 2/2] radix-tree: small
Date: Tue, 25 Apr 2006 06:52:55 +0200 (CEST)
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
