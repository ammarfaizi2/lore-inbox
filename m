Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWG0QGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWG0QGn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWG0QGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:06:43 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:65212 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750822AbWG0QGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:06:43 -0400
Subject: [PATCH] freevxfs: Add missing lock_kernel() to vxfs_readdir
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 09:06:43 -0700
Message-Id: <1154016403.12517.84.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7b2fd697427e73c81d5fa659efd91bd07d303b0e in the historical GIT tree
stopped calling the readdir member of a file_operations struct with the big
kernel lock held, and fixed up all the readdir functions to do their own
locking.  However, that change added calls to unlock_kernel() in vxfs_readdir,
but no call to lock_kernel().  Fix this by adding a call to lock_kernel().

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 fs/freevxfs/vxfs_lookup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
index 29cce45..78deaa5 100644
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -246,6 +246,8 @@ vxfs_readdir(struct file *fp, void *retp
 	u_long			page, npages, block, pblocks, nblocks, offset;
 	loff_t			pos;
 
+	lock_kernel();
+	
 	switch ((long)fp->f_pos) {
 	case 0:
 		if (filler(retp, ".", 1, fp->f_pos, ip->i_ino, DT_DIR) < 0)


