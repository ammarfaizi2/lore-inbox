Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVIIPx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVIIPx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVIIPx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:53:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53971 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932165AbVIIPx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:53:57 -0400
Date: Fri, 9 Sep 2005 16:53:56 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bogus cast in bio.c
Message-ID: <20050909155356.GF9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<qualifier> void * is not the same as void <qualifier> *...
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git8-base/fs/bio.c current/fs/bio.c
--- RC13-git8-base/fs/bio.c	2005-09-08 10:17:39.000000000 -0400
+++ current/fs/bio.c	2005-09-08 23:53:33.000000000 -0400
@@ -683,7 +683,7 @@
 {
 	struct sg_iovec iov;
 
-	iov.iov_base = (__user void *)uaddr;
+	iov.iov_base = (void __user *)uaddr;
 	iov.iov_len = len;
 
 	return bio_map_user_iov(q, bdev, &iov, 1, write_to_vm);
