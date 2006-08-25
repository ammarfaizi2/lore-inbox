Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422841AbWHYTmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422841AbWHYTmj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422831AbWHYThQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:37:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30351 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422820AbWHYThN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:37:13 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 05/18] [PATCH] BLOCK: Don't call block_sync_page() from AFS [try #4]
Date: Fri, 25 Aug 2006 20:37:10 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825193709.11384.79794.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
References: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The AFS filesystem specifies block_sync_page() as its sync_page address op,
which needs to be checked, and so is commented out for the moment.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 67d6634..5ff8e3a 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -37,7 +37,9 @@ struct inode_operations afs_file_inode_o
 
 const struct address_space_operations afs_fs_aops = {
 	.readpage	= afs_file_readpage,
+#if 0 /* probably shouldn't do this - needs reconsideration */
 	.sync_page	= block_sync_page,
+#endif
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 	.releasepage	= afs_file_releasepage,
 	.invalidatepage	= afs_file_invalidatepage,
