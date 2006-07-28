Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161213AbWG1SYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161213AbWG1SYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWG1SYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:24:53 -0400
Received: from hera.kernel.org ([140.211.167.34]:25008 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1161215AbWG1SYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:24:52 -0400
Date: Fri, 28 Jul 2006 18:24:21 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200607281824.k6SIOLfq013114@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] 9p: fix marshalling bug in tcreate with empty extension field
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From c4610f24dbaa1fbd2e1c15162b76200a2ac40204 Mon Sep 17 00:00:00 2001
From: Eric Van Hensbergen <ericvh@ericvh-laptop.(none)>
Date: Fri, 28 Jul 2006 13:18:35 -0500
Subject: [PATCH] marshalling bug in tcreate with empty extension field

Signed-off-by: Russ Ross <russross@gmail.com>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
---
 fs/9p/conv.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/9p/conv.c b/fs/9p/conv.c
index 1e89814..56d88c1 100644
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -673,8 +673,10 @@ struct v9fs_fcall *v9fs_create_tcreate(u
 	struct cbuf *bufp = &buffer;
 
 	size = 4 + 2 + strlen(name) + 4 + 1;	/* fid[4] name[s] perm[4] mode[1] */
-	if (extended && extension!=NULL)
-		size += 2 + strlen(extension);	/* extension[s] */
+	if (extended) {
+		size += 2 +			/* extension[s] */
+		    (extension == NULL ? 0 : strlen(extension));
+	}
 
 	fc = v9fs_create_common(bufp, size, TCREATE);
 	if (IS_ERR(fc))
-- 
1.4.2.rc1.g83e1

