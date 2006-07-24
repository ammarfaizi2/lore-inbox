Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWGXVX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWGXVX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 17:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWGXVX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 17:23:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:20913 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751452AbWGXVX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 17:23:57 -0400
Subject: [PATCH] [coda] Remove incorrect unlock_kernel from allocation
	failure path in coda_open
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
       coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu
Content-Type: text/plain
Date: Mon, 24 Jul 2006 14:23:58 -0700
Message-Id: <1153776238.4931.11.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 398c53a757702e1e3a7a2c24860c7ad26acb53ed (in the historical GIT tree)
moved the lock_kernel() in coda_open after the allocation of a coda_file_info
struct, but left an unlock_kernel() in the allocation failure error path;
remove it.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 fs/coda/file.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index cc66c68..dbfbcfa 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -136,10 +136,8 @@ int coda_open(struct inode *coda_inode, 
 	coda_vfs_stat.open++;
 
 	cfi = kmalloc(sizeof(struct coda_file_info), GFP_KERNEL);
-	if (!cfi) {
-		unlock_kernel();
+	if (!cfi)
 		return -ENOMEM;
-	}
 
 	lock_kernel();
 


