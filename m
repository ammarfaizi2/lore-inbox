Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268893AbVBERvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268893AbVBERvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 12:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268866AbVBERvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 12:51:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:63366 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S273430AbVBERvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 12:51:21 -0500
Date: Sat, 5 Feb 2005 17:50:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove truncate mapped BUG
Message-ID: <Pine.LNX.4.61.0502051748430.16107@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's time to remove truncate_complete_page's BUG_ON(page_mapped(page)):
it was there to give confidence in the new vm_truncate_count mechanism.
Earlier releases had no such check, and it wouldn't be at all helpful
if it ever bugged up file truncation on a production system - though
we don't know of any scenario in which that could happen now.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.11-rc3/mm/truncate.c	2005-02-03 09:06:16.000000000 +0000
+++ linux/mm/truncate.c	2005-02-03 17:26:40.000000000 +0000
@@ -45,7 +45,6 @@ static inline void truncate_partial_page
 static void
 truncate_complete_page(struct address_space *mapping, struct page *page)
 {
-	BUG_ON(page_mapped(page));
 	if (page->mapping != mapping)
 		return;
 
