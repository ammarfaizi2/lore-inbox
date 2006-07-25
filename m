Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWGYP2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWGYP2W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWGYP2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:28:22 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:58090 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964773AbWGYP2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:28:21 -0400
Subject: [PATCH v2] [hugetlbfs] Add lock annotation to
	hugetlbfs_forget_inode
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, William Irwin <wli@holomorphy.com>
In-Reply-To: <1153787570.31581.46.camel@josh-work.beaverton.ibm.com>
References: <1153787570.31581.46.camel@josh-work.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 08:27:32 -0700
Message-Id: <1153841252.12517.16.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlbfs_forget_inode releases inode_lock.  Add a lock annotation to this
function so that sparse can check callers for lock pairing, and so that sparse
will not complain about this function since it intentionally uses the lock in
this manner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
Resend with a typo fix.

 fs/hugetlbfs/inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c3920c9..89092c2 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -229,7 +229,7 @@ static void hugetlbfs_delete_inode(struc
 	clear_inode(inode);
 }
 
-static void hugetlbfs_forget_inode(struct inode *inode)
+static void hugetlbfs_forget_inode(struct inode *inode) __releases(inode_lock)
 {
 	struct super_block *sb = inode->i_sb;
 


