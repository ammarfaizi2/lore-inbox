Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262815AbSJFABq>; Sat, 5 Oct 2002 20:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262817AbSJFABq>; Sat, 5 Oct 2002 20:01:46 -0400
Received: from holomorphy.com ([66.224.33.161]:61651 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262815AbSJFABp>;
	Sat, 5 Oct 2002 20:01:45 -0400
Date: Sat, 5 Oct 2002 17:05:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@zip.com.au
Subject: 2.5.40 snapshot ia32 discontig compilefix
Message-ID: <20021006000533.GE12432@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@zip.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Encountered while attempting to compile a recent snapshot.
MAP_NR_DENSE() is not currently used so either of ->spanned_pages
or ->present_pages would be acceptable, and they should hopefully be
identical -- if not so, then other setup code is incorrect.

akpm, I'm not sure of the state of your pending queue, so if this is
already fixed there just ignore it.


Bill

--- linux-old/arch/i386/mm/discontig.c	Thu Sep 19 14:26:01 2002
+++ linux-wli/arch/i386/mm/discontig.c	Sat Oct  5 16:54:46 2002
@@ -258,7 +258,7 @@
 		unsigned long node_pfn, node_high_size, zone_start_pfn;
 		struct page * zone_mem_map;
 		
-		node_high_size = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].size;
+		node_high_size = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].spanned_pages;
 		zone_mem_map = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_mem_map;
 		zone_start_pfn = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_start_pfn;
 
