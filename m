Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUC3WzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUC3Wwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:52:54 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:33655 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261685AbUC3Wtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:49:33 -0500
Date: Tue, 30 Mar 2004 23:49:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] mremap rmap comment
In-Reply-To: <Pine.LNX.4.44.0403302340220.24019-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403302348380.24019-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmap's try_to_unmap_one comments on find_vma failure, that a page may
temporarily be absent from a vma during mremap: no longer, though it
is still possible for this find_vma to fail, while unmap_vmas drops
page_table_lock (but that is no problem for file truncation).

--- mremap5/mm/rmap.c	2004-03-30 13:04:19.449545248 +0100
+++ mremap6/mm/rmap.c	2004-03-30 21:25:22.961196784 +0100
@@ -315,8 +315,7 @@ static int fastcall try_to_unmap_one(str
 		return SWAP_AGAIN;
 	}
 
-
-	/* During mremap, it's possible pages are not in a VMA. */
+	/* unmap_vmas drops page_table_lock with vma unlinked */
 	vma = find_vma(mm, address);
 	if (!vma) {
 		ret = SWAP_FAIL;

