Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSJUQHc>; Mon, 21 Oct 2002 12:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSJUQHc>; Mon, 21 Oct 2002 12:07:32 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:20898 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261492AbSJUQHb>; Mon, 21 Oct 2002 12:07:31 -0400
Date: Mon, 21 Oct 2002 17:14:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: [PATCH] mm mremap freeze
Message-ID: <Pine.LNX.4.44.0210211708030.16869-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mremap's move_one_page tried to lock src_page twice
#ifndef CONFIG_SHAREPTE (do I hear you hissing my disloyalty?)

--- 2.5.44-mm2/mm/mremap.c	Mon Oct 21 12:57:53 2002
+++ linux/mm/mremap.c	Mon Oct 21 16:46:58 2002
@@ -43,8 +43,8 @@
 		goto out_unlock;
 
 	src_page = pmd_page(*src_pmd);
-	pte_page_lock(src_page);
 #ifdef CONFIG_SHAREPTE
+	pte_page_lock(src_page);
 	/*
 	 * Unshare if necessary.  We unmap the return
 	 * pointer because we may need to map it nested later.

