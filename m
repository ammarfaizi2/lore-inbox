Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbRGOXow>; Sun, 15 Jul 2001 19:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267127AbRGOXom>; Sun, 15 Jul 2001 19:44:42 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:54034 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267124AbRGOXod>; Sun, 15 Jul 2001 19:44:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Missed a page_address cleanup
Date: Mon, 16 Jul 2001 01:48:25 +0200
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com (Linus Torvalds),
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Message-Id: <01071601482503.06482@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up one instance of (char *) page_address that was missed in
the recent round of cleanups.

--- 2.4.6.clean/fs/ext2/dir.c	Wed Jun 20 20:40:14 2001
+++ 2.4.6/fs/ext2/dir.c	Sun Jul 15 23:03:41 2001
@@ -363,7 +363,7 @@
 void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
 			struct page *page, struct inode *inode)
 {
-	unsigned from = (char *)de-(char*)page_address(page);
+	unsigned from = (char *) de - page_address(page);
 	unsigned to = from + le16_to_cpu(de->rec_len);
 	int err;
 
