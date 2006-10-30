Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161431AbWJ3UHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161431AbWJ3UHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161451AbWJ3UHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:07:00 -0500
Received: from mail.parknet.jp ([210.171.160.80]:50183 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932478AbWJ3UFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:05:52 -0500
X-AuthUser: hirofumi@parknet.jp
To: akpm@osdl.org, cluster-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] gfs2: ->readpages() fixes
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 31 Oct 2006 05:05:47 +0900
Message-ID: <87slh5lgbo.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just ignore the remaining pages, and remove unneeded unlock_pages().

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/gfs2/ops_address.c |    7 -------
 1 file changed, 7 deletions(-)

diff -puN fs/gfs2/ops_address.c~readpages-fixes-gfs2 fs/gfs2/ops_address.c
--- linux-2.6/fs/gfs2/ops_address.c~readpages-fixes-gfs2	2006-10-31 04:26:20.000000000 +0900
+++ linux-2.6-hirofumi/fs/gfs2/ops_address.c	2006-10-31 04:26:20.000000000 +0900
@@ -337,13 +337,6 @@ out:
 out_noerror:
 	ret = 0;
 out_unlock:
-	/* unlock all pages, we can't do any I/O right now */
-	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
-		struct page *page = list_entry(pages->prev, struct page, lru);
-		list_del(&page->lru);
-		unlock_page(page);
-		page_cache_release(page);
-	}
 	if (do_unlock)
 		gfs2_holder_uninit(&gh);
 	goto out;
_
