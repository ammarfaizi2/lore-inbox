Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265147AbUF1Ttg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbUF1Ttg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbUF1Ttg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:49:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:50354 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265147AbUF1Ttf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:49:35 -0400
Date: Mon, 28 Jun 2004 12:49:34 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [PATCH] remove extraneous security_inode_setattr call in hugetlbfs
Message-ID: <20040628124934.B1973@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove extraneous security_inode_setattr call in hugetlbfs, it's already
done by VFS.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/hugetlbfs/inode.c 1.47 vs edited =====
--- 1.47/fs/hugetlbfs/inode.c	2004-05-22 14:56:28 -07:00
+++ edited/fs/hugetlbfs/inode.c	2004-06-25 19:37:34 -07:00
@@ -329,9 +329,6 @@
 	if (error)
 		goto out;
 
-	error = security_inode_setattr(dentry, attr);
-	if (error)
-		goto out;
 	if (ia_valid & ATTR_SIZE) {
 		error = -EINVAL;
 		if (!(attr->ia_size & ~HPAGE_MASK))
