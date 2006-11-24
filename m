Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757663AbWKXJcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757663AbWKXJcc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757658AbWKXJca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:32:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2517 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757614AbWKXJcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:32:11 -0500
Subject: [GFS2] Fix memory allocation in glock.c [9/9]
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Nov 2006 09:34:54 +0000
Message-Id: <1164360894.3392.147.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 70411bdbedb9a2726cacd5c36879b78037153782 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 15 Nov 2006 15:17:03 -0500
Subject: [PATCH] [GFS2] Fix memory allocation in glock.c

Change from GFP_KERNEL to GFP_NOFS as this was causing a
slow down when trying to push inodes from cache.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/glock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 78fe0fa..e94e7c9 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -769,7 +769,7 @@ restart:
 	} else {
 		spin_unlock(&gl->gl_spin);
 
-		new_gh = gfs2_holder_get(gl, state, LM_FLAG_TRY, GFP_KERNEL);
+		new_gh = gfs2_holder_get(gl, state, LM_FLAG_TRY, GFP_NOFS);
 		if (!new_gh)
 			return;
 		set_bit(HIF_DEMOTE, &new_gh->gh_iflags);
-- 
1.4.1



