Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWCQTJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWCQTJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWCQTJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:09:32 -0500
Received: from hera.kernel.org ([140.211.167.34]:30617 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030263AbWCQTJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:09:32 -0500
Date: Fri, 17 Mar 2006 19:09:14 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200603171909.k2HJ9BiD006068@hera.kernel.org>
To: akpm@osdl.org
Subject: [RESEND][PATCH] v9fs: print v9fs module address
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] print v9fs module address
From: Latchesar Ionkov <lucho@ionkov.net>
Date: 1141313037 -0500

This patch prints v9fs module address when the module is initialized. It is
useful to have it in the logs -- if the kernel crashes the address can be
used together with the oops print to find out the exact place (presumably in
the v9fs code) that cause the oops.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/v9fs.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

3e12299e1cd1582b67aa57ff9b445e9af61a4701
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index daf623c..321989a 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -455,10 +455,15 @@ extern int v9fs_error_init(void);
 static int __init init_v9fs(void)
 {
 	int ret;
+	void *mcore;
+
+	mcore = NULL;
+	if (THIS_MODULE)
+		mcore = THIS_MODULE->module_core;
 
 	v9fs_error_init();
 
-	printk(KERN_INFO "Installing v9fs 9P2000 file system support\n");
+	printk(KERN_INFO "Installing v9fs 9P2000 file system support %p\n", mcore);
 
 	ret = v9fs_mux_global_init();
 	if (!ret)
-- 
1.1.0
