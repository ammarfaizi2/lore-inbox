Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933676AbWKWNOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933676AbWKWNOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933685AbWKWNOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:14:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30877 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933683AbWKWNOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:14:01 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Subject: [PATCH 27/19] FS-Cache: Apply the PG_checked -> PG_fs_misc conversion to Ext4
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 23 Nov 2006 13:10:59 +0000
Message-ID: <27699.1164287459@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apply the PG_checked -> PG_fs_misc conversion to Ext4 [patch 02/19].

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/ext4/inode.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0a60ec5..4846bb9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1530,12 +1530,12 @@ static int ext4_journalled_writepage(str
 		goto no_write;
 	}
 
-	if (!page_has_buffers(page) || PageChecked(page)) {
+	if (!page_has_buffers(page) || PageFsMisc(page)) {
 		/*
 		 * It's mmapped pagecache.  Add buffers and journal it.  There
 		 * doesn't seem much point in redirtying the page here.
 		 */
-		ClearPageChecked(page);
+		ClearPageFsMisc(page);
 		ret = block_prepare_write(page, 0, PAGE_CACHE_SIZE,
 					ext4_get_block);
 		if (ret != 0) {
@@ -1592,7 +1592,7 @@ static void ext4_invalidatepage(struct p
 	 * If it's a full truncate we just forget about the pending dirtying
 	 */
 	if (offset == 0)
-		ClearPageChecked(page);
+		ClearPageFsMisc(page);
 
 	jbd2_journal_invalidatepage(journal, page, offset);
 }
@@ -1601,7 +1601,7 @@ static int ext4_releasepage(struct page 
 {
 	journal_t *journal = EXT4_JOURNAL(page->mapping->host);
 
-	WARN_ON(PageChecked(page));
+	WARN_ON(PageFsMisc(page));
 	if (!page_has_buffers(page))
 		return 0;
 	return jbd2_journal_try_to_free_buffers(journal, page, wait);
@@ -1697,7 +1697,7 @@ out:
  */
 static int ext4_journalled_set_page_dirty(struct page *page)
 {
-	SetPageChecked(page);
+	SetPageFsMisc(page);
 	return __set_page_dirty_nobuffers(page);
 }
 
