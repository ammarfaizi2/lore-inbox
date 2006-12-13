Return-Path: <linux-kernel-owner+w=401wt.eu-S964908AbWLMMNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWLMMNF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWLMMNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:13:04 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.16]:65114 "EHLO
	amsfep11-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S964885AbWLMMND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:13:03 -0500
Subject: [PATCH] nfs: fix NR_FILE_DIRTY underflow
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 13:12:38 +0100
Message-Id: <1166011958.32332.97.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still testing this patch, but it looks good so far.

---
Just setting PG_dirty can cause NR_FILE_DIRTY to underflow
which is bad (TM).

Use set_page_dirty() which will do the right thing.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/nfs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-git2/fs/nfs/file.c
===================================================================
--- linux-2.6-git2.orig/fs/nfs/file.c	2006-12-13 12:54:55.000000000 +0100
+++ linux-2.6-git2/fs/nfs/file.c	2006-12-13 12:55:12.000000000 +0100
@@ -321,7 +321,7 @@ static int nfs_release_page(struct page 
 	if (!(gfp & __GFP_FS))
 		return 0;
 	/* Hack... Force nfs_wb_page() to write out the page */
-	SetPageDirty(page);
+	set_page_dirty(page);
 	return !nfs_wb_page(page->mapping->host, page);
 }
 


