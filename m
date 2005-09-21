Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVIUBVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVIUBVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVIUBVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:21:09 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:46793 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750896AbVIUBVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:21:08 -0400
Date: Tue, 20 Sep 2005 21:20:58 -0400
From: Latchesar Ionkov <lucho@ionkov.net>
To: linux-kernel@vger.kernel.org
Cc: v9fs-developer@lists.sourceforge.net
Subject: [PATCH] v9fs-conv-rwalk-buf-fix.patch
Message-ID: <20050921012058.GC2008@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

allocate qid array in the correct conv buf

---
commit 4f0a459f11309161616e22f4acf918eb04a9bd1a
tree a1ed10971a1d7a086feb0a3c39bbfe0b74ae8059
parent 4e674e810f621d61c8cdf35ed3306e0a6c62acb6
author Latchesar Ionkov <lucho@ionkov.net> Tue, 20 Sep 2005 19:26:23 -0400
committer Latchesar Ionkov <lucho@ionkov.net> Tue, 20 Sep 2005 19:26:23 -0400

 fs/9p/conv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/9p/conv.c b/fs/9p/conv.c
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -651,7 +651,7 @@ v9fs_deserialize_fcall(struct v9fs_sessi
 		break;
 	case RWALK:
 		rcall->params.rwalk.nwqid = buf_get_int16(bufp);
-		rcall->params.rwalk.wqids = buf_alloc(bufp,
+		rcall->params.rwalk.wqids = buf_alloc(dbufp,
 		      rcall->params.rwalk.nwqid * sizeof(struct v9fs_qid));
 		if (rcall->params.rwalk.wqids)
 			for (i = 0; i < rcall->params.rwalk.nwqid; i++) {
