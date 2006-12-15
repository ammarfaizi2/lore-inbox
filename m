Return-Path: <linux-kernel-owner+w=401wt.eu-S1752819AbWLOQVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbWLOQVT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbWLOQVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:21:19 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:6266 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbWLOQVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:21:19 -0500
Date: Fri, 15 Dec 2006 17:21:08 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cborntra@de.ibm.com
Subject: [S390] hypfs fixes
Message-ID: <20061215162108.GB4920@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[S390] hypfs fixes

Correct typo to make hypfs work on systems that support only diag204
subcode 4 and fix error handling in hypfs_diag_init.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/hypfs_diag.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/hypfs/hypfs_diag.c linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c
--- linux-2.6/arch/s390/hypfs/hypfs_diag.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c	2006-12-15 16:55:06.000000000 +0100
@@ -379,7 +379,7 @@ static void *diag204_alloc_vbuf(int page
 static void *diag204_alloc_rbuf(void)
 {
 	diag204_buf = (void*)__get_free_pages(GFP_KERNEL,0);
-	if (diag204_buf)
+	if (!diag204_buf)
 		return ERR_PTR(-ENOMEM);
 	diag204_buf_pages = 1;
 	return diag204_buf;
@@ -521,7 +521,7 @@ __init int hypfs_diag_init(void)
 	}
 	rc = diag224_get_name_table();
 	if (rc) {
-		diag224_delete_name_table();
+		diag204_free_buffer();
 		printk(KERN_ERR "hypfs: could not get name table.\n");
 	}
 	return rc;
