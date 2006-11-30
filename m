Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936386AbWK3M0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936386AbWK3M0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936388AbWK3M0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:26:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9361 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936397AbWK3MZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:25:17 -0500
Subject: [GFS2] Add a comment about reading the super block [69/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Srinivasa Ds <srinivasa@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:24:05 +0000
Message-Id: <1164889445.3752.447.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From aac1a3c77a46c2d06f297641760dd740ac2a84af Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Thu, 30 Nov 2006 10:02:19 -0500
Subject: [PATCH] [GFS2] Add a comment about reading the super block

The comment explains why we use the bio functions to read
the super block.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Srinivasa Ds <srinivasa@in.ibm.com>
---
 fs/gfs2/super.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 3b22727..43a24f2 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -180,6 +180,24 @@ static int end_bio_io_page(struct bio *b
 	return 0;
 }
 
+/**
+ * gfs2_read_super - Read the gfs2 super block from disk
+ * @sb: The VFS super block
+ * @sector: The location of the super block
+ *
+ * This uses the bio functions to read the super block from disk
+ * because we want to be 100% sure that we never read cached data.
+ * A super block is read twice only during each GFS2 mount and is
+ * never written to by the filesystem. The first time its read no
+ * locks are held, and the only details which are looked at are those
+ * relating to the locking protocol. Once locking is up and working,
+ * the sb is read again under the lock to establish the location of
+ * the master directory (contains pointers to journals etc) and the
+ * root directory.
+ *
+ * Returns: A page containing the sb or NULL
+ */
+
 struct page *gfs2_read_super(struct super_block *sb, sector_t sector)
 {
 	struct page *page;
-- 
1.4.1



