Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbWH2QwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbWH2QwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWH2QtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:49:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30621 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965112AbWH2QqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:46:08 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 05/19] BLOCK: Don't call block_sync_page() from AFS [try #5]
Date: Tue, 29 Aug 2006 17:46:00 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829164600.15723.44280.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
References: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The AFS filesystem no longer needs to override its sync_page() op.

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
