Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946517AbWKAFjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946517AbWKAFjb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946513AbWKAFjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:39:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:39569 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946270AbWKAFiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:38:54 -0500
Message-Id: <20061101053851.686622000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:02 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Dave Kleikamp <shaggy@austin.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 22/61] JFS: pageno needs to be long
Content-Disposition: inline; filename=jfs-pageno-needs-to-be-long.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Dave Kleikamp <shaggy@austin.ibm.com>

diRead and diWrite are representing the page number as an unsigned int.
This causes file system corruption on volumes larger than 16TB.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 fs/jfs/jfs_imap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.1.orig/fs/jfs/jfs_imap.c
+++ linux-2.6.18.1/fs/jfs/jfs_imap.c
@@ -318,7 +318,7 @@ int diRead(struct inode *ip)
 	struct inomap *imap;
 	int block_offset;
 	int inodes_left;
-	uint pageno;
+	unsigned long pageno;
 	int rel_inode;
 
 	jfs_info("diRead: ino = %ld", ip->i_ino);
@@ -606,7 +606,7 @@ int diWrite(tid_t tid, struct inode *ip)
 	int block_offset;
 	int inodes_left;
 	struct metapage *mp;
-	uint pageno;
+	unsigned long pageno;
 	int rel_inode;
 	int dioffset;
 	struct inode *ipimap;

--
