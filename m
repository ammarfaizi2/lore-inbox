Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUKOUlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUKOUlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbUKOUjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:39:53 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19886 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261685AbUKOUht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:37:49 -0500
Date: Mon, 15 Nov 2004 20:37:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] low discontig highmem_start_page
Message-ID: <Pine.LNX.4.44.0411152035020.4131-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of i386 CONFIG_DISCONTIGMEM CONFIG_HIGHMEM without highmem,
highmem_start_page was wrongly initialized (from a NULL zone_mem_map),
causing __change_page_attr to BUG on boot.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.10-rc2/arch/i386/mm/discontig.c	2004-11-15 16:20:26.000000000 +0000
+++ linux/arch/i386/mm/discontig.c	2004-11-15 17:01:26.000000000 +0000
@@ -468,7 +468,7 @@ void __init set_max_mapnr_init(void)
 	if (high0->spanned_pages > 0)
 	      	highmem_start_page = high0->zone_mem_map;
 	else
-		highmem_start_page = pfn_to_page(max_low_pfn+1); 
+		highmem_start_page = pfn_to_page(max_low_pfn - 1) + 1; 
 	num_physpages = highend_pfn;
 #else
 	num_physpages = max_low_pfn;

