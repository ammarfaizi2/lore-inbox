Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268048AbUJCScI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268048AbUJCScI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUJCSaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:30:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:60971 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268048AbUJCS23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:28:29 -0400
Date: Sun, 3 Oct 2004 19:28:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] vmtrunc: bug if page_mapped
In-Reply-To: <Pine.LNX.4.44.0410031914480.2739-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410031927240.2755-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If unmap_mapping_range (and mapping->truncate_count) are doing their
jobs right, truncate_complete_page should never find the page mapped:
add BUG_ON for our immediate testing, but this patch should probably
not go to mainline - a mapped page here is not a catastrophe.

Unsigned-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/truncate.c |    1 +
 1 files changed, 1 insertion(+)

--- trunc5/mm/truncate.c	2004-10-02 18:22:29.000000000 +0100
+++ trunc6/mm/truncate.c	2004-10-03 16:37:39.677144808 +0100
@@ -45,6 +45,7 @@ static inline void truncate_partial_page
 static void
 truncate_complete_page(struct address_space *mapping, struct page *page)
 {
+	BUG_ON(page_mapped(page));
 	if (page->mapping != mapping)
 		return;
 

