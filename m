Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTFKBUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 21:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTFKBUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 21:20:25 -0400
Received: from miranda.zianet.com ([216.234.192.169]:20744 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S263922AbTFKBUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 21:20:11 -0400
Subject: [PATCH] 2.5-bk K&R to ANSI conversions for fs/jfs/jfs_dmap.c and
	jfs_xtree.c
From: Steven Cole <elenstev@mesatop.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Dave Olien <dmo@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1055295164.1983.25.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 10 Jun 2003 19:32:44 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the first of the following warnings when doing
make C=1 bzImage with the sparse checker cleverly installed as
/usr/local/bin/sparse.

  CHECK   fs/jfs/jfs_dmap.c
warning: fs/jfs/jfs_dmap.c:3053:14: non-ANSI parameter list
warning: fs/jfs/jfs_dmap.c:1315:10: not addressable
warning: fs/jfs/jfs_dmap.c:1792:8: not addressable
warning: fs/jfs/jfs_dmap.c:3441:10: not addressable
  CC      fs/jfs/jfs_dmap.o

No "non-ANSI parameter list" warnings for fs/jfs/jfs_xtree.c were
received, presumably because _JFS_WIP wasn't defined.  This patch
converts the xtGather function declaration anyway.

Steven


diff -ur bk-current/fs/jfs/jfs_dmap.c linux/fs/jfs/jfs_dmap.c
--- bk-current/fs/jfs/jfs_dmap.c	2003-06-09 18:36:51.000000000 -0600
+++ linux/fs/jfs/jfs_dmap.c	2003-06-09 22:02:27.000000000 -0600
@@ -3050,7 +3050,7 @@
  * RETURN VALUES:
  *      none
  */
-void fsDirty()
+void fsDirty(void)
 {
 	printk("fsDirty(): bye-bye\n");
 	assert(0);
diff -ur bk-current/fs/jfs/jfs_xtree.c linux/fs/jfs/jfs_xtree.c
--- bk-current/fs/jfs/jfs_xtree.c	2003-06-09 18:34:10.000000000 -0600
+++ linux/fs/jfs/jfs_xtree.c	2003-06-09 22:02:50.000000000 -0600
@@ -4225,8 +4225,7 @@
  *      at the current entry at the current subtree root page
  *
  */
-int xtGather(t)
-btree_t *t;
+int xtGather(btree_t *t)
 {
 	int rc = 0;
 	xtpage_t *p;





