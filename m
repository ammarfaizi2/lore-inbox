Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWJTJKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWJTJKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWJTJKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:10:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29581 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751689AbWJTJKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:10:20 -0400
Subject: [PATCH 3/8] [GFS2] gfs2 endianness bug: be16 assigned to be32 field
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: Al Viro <viro@ftp.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 20 Oct 2006 10:18:25 +0100
Message-Id: <1161335905.27980.186.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From a2d7d021d78dbc00d24d9c809c64a7f3e61fa773 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 14 Oct 2006 16:49:30 +0100
Subject: [GFS2] gfs2 endianness bug: be16 assigned to be32 field

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 459498c..d43caf0 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -815,7 +815,7 @@ static struct gfs2_leaf *new_leaf(struct
 	leaf = (struct gfs2_leaf *)bh->b_data;
 	leaf->lf_depth = cpu_to_be16(depth);
 	leaf->lf_entries = 0;
-	leaf->lf_dirent_format = cpu_to_be16(GFS2_FORMAT_DE);
+	leaf->lf_dirent_format = cpu_to_be32(GFS2_FORMAT_DE);
 	leaf->lf_next = 0;
 	memset(leaf->lf_reserved, 0, sizeof(leaf->lf_reserved));
 	dent = (struct gfs2_dirent *)(leaf+1);
-- 
1.4.1



