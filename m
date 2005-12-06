Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbVLFUXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbVLFUXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbVLFUXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:23:23 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:62638 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932630AbVLFUXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:23:22 -0500
Subject: [PATCH] ext3: return FSID for statvfs
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com
Date: Tue, 06 Dec 2005 22:23:20 +0200
Message-Id: <1133900600.3279.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes ext3_statfs() to return a FSID based on least significant
64-bits of the 128-bit filesystem UUID. This patch is a partial fix for
Bugzilla Bug <http://bugzilla.kernel.org/show_bug.cgi?id=136>.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 super.c |    2 ++
 1 file changed, 2 insertions(+)

Index: 2.6/fs/ext3/super.c
===================================================================
--- 2.6.orig/fs/ext3/super.c
+++ 2.6/fs/ext3/super.c
@@ -2340,6 +2340,8 @@ static int ext3_statfs (struct super_blo
 	buf->f_files = le32_to_cpu(es->s_inodes_count);
 	buf->f_ffree = ext3_count_free_inodes (sb);
 	buf->f_namelen = EXT3_NAME_LEN;
+	buf->f_fsid.val[0] = le32_to_cpup((void *)es->s_uuid);
+	buf->f_fsid.val[1] = le32_to_cpup((void *)es->s_uuid + sizeof(u32));
 	return 0;
 }
 


