Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261443AbTCYNsx>; Tue, 25 Mar 2003 08:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262651AbTCYNsH>; Tue, 25 Mar 2003 08:48:07 -0500
Received: from holomorphy.com ([66.224.33.161]:49313 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262652AbTCYNrf>;
	Tue, 25 Mar 2003 08:47:35 -0500
Date: Tue, 25 Mar 2003 05:58:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: init_inode_once() wants sizeof(struct hlist_head)
Message-ID: <20030325135825.GJ30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	akpm@zip.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inode_init() wants to deal with things in in units of the size of
struct hlist_head, not struct list_head.


diff -urpN merge-2.5.66-7/fs/inode.c merge-2.5.66-8/fs/inode.c
--- merge-2.5.66-7/fs/inode.c	2003-03-24 14:01:48.000000000 -0800
+++ merge-2.5.66-8/fs/inode.c	2003-03-25 05:41:18.000000000 -0800
@@ -1260,7 +1260,7 @@ void __init inode_init(unsigned long mem
 		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
 
 	mempages >>= (14 - PAGE_SHIFT);
-	mempages *= sizeof(struct list_head);
+	mempages *= sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
 		;
 
