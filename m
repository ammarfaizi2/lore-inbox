Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273008AbRINS1O>; Fri, 14 Sep 2001 14:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273401AbRINS1F>; Fri, 14 Sep 2001 14:27:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59118 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273009AbRINS0v>;
	Fri, 14 Sep 2001 14:26:51 -0400
Date: Fri, 14 Sep 2001 14:27:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] inode.c cleanup
Message-ID: <Pine.GSO.4.21.0109141424510.11172-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Obvious cleanup: superblocks leave the list before they
can get ->s_dev equal to 0 and they do it under sb_lock, so test
in the chunk below is bogus.

	Please apply (it goes both for Linus' tree and -ac).

diff -urN S10-pre9/fs/inode.c S10-pre9-inode/fs/inode.c
--- S10-pre9/fs/inode.c	Fri Sep 14 12:58:45 2001
+++ S10-pre9-inode/fs/inode.c	Fri Sep 14 14:00:38 2001
@@ -405,8 +405,6 @@
 	spin_lock(&sb_lock);
 	sb = sb_entry(super_blocks.next);
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.next)) {
-		if (!sb->s_dev)
-			continue;
 		spin_unlock(&sb_lock);
 		if (!try_to_sync_unused_list(&sb->s_dirty))
 			return;

