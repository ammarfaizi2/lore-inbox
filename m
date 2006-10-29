Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965267AbWJ2P4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965267AbWJ2P4n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 10:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965269AbWJ2P4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 10:56:43 -0500
Received: from mail.parknet.jp ([210.171.160.80]:7 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S965267AbWJ2P4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 10:56:42 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] read_cache_pages() cleanup
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 30 Oct 2006 00:56:37 +0900
Message-ID: <873b97und6.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This uses put_pages_list() instead of opencoded one.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 mm/readahead.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff -puN mm/readahead.c~read_cache_pages-cleanup mm/readahead.c
--- linux-2.6/mm/readahead.c~read_cache_pages-cleanup	2006-10-30 00:12:20.000000000 +0900
+++ linux-2.6-hirofumi/mm/readahead.c	2006-10-30 00:12:20.000000000 +0900
@@ -148,13 +148,7 @@ int read_cache_pages(struct address_spac
 		if (!pagevec_add(&lru_pvec, page))
 			__pagevec_lru_add(&lru_pvec);
 		if (ret) {
-			while (!list_empty(pages)) {
-				struct page *victim;
-
-				victim = list_to_page(pages);
-				list_del(&victim->lru);
-				page_cache_release(victim);
-			}
+			put_pages_list(pages);
 			break;
 		}
 	}
_
