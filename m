Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWKFLGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWKFLGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 06:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWKFLGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 06:06:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10190 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751887AbWKFLF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 06:05:59 -0500
Subject: [GFS2] Fix OOM error handling [3/5]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 06 Nov 2006 11:08:13 +0000
Message-Id: <1162811293.18219.34.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 26d83dedf61d26d85f10bc34b92f4de7660fd746 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Mon, 30 Oct 2006 16:59:08 -0500
Subject: [PATCH] [GFS2] Fix OOM error handling

Fix the OOM error handling in inode.c where it was possible for
a NULL pointer to be dereferenced.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 57c43ac..d470e52 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -157,6 +157,9 @@ struct inode *gfs2_inode_lookup(struct s
 	struct gfs2_glock *io_gl;
 	int error;
 
+	if (!inode)
+		return ERR_PTR(-ENOBUFS);
+
 	if (inode->i_state & I_NEW) {
 		struct gfs2_sbd *sdp = GFS2_SB(inode);
 		umode_t mode = DT2IF(type);
-- 
1.4.1



