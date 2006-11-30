Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936358AbWK3M2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936358AbWK3M2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936336AbWK3MVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:21:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10381 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936335AbWK3MUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:20:51 -0500
Subject: [GFS2] Fix memory allocation in glock.c [47/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:20:54 +0000
Message-Id: <1164889254.3752.399.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From ab923031ceb95ec50ef33ccadf28663c660aa94c Mon Sep 17 00:00:00 2001
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
index 746347a..edc21c8 100644
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



