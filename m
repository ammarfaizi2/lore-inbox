Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbTI1Xbh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTI1X35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:29:57 -0400
Received: from hera.cwi.nl ([192.16.191.8]:37870 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262787AbTI1X3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:29:08 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 01:29:05 +0200 (MEST)
Message-Id: <UTC200309282329.h8SNT5I29917.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] fat sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/fat/dir.c b/fs/fat/dir.c
--- a/fs/fat/dir.c	Mon Sep 29 01:05:41 2003
+++ b/fs/fat/dir.c	Mon Sep 29 01:11:39 2003
@@ -630,7 +630,7 @@
 		    put_user(slen, &d1->d_reclen))
 			goto efault;
 	} else {
-		if (put_user(0, d2->d_name)			||
+		if (put_user(0, d2->d_name+0)			||
 		    put_user(0, &d2->d_reclen)			||
 		    copy_to_user(d1->d_name, name, len)		||
 		    put_user(0, d1->d_name+len)			||
@@ -663,7 +663,7 @@
 		return -EINVAL;
 	}
 
-	d1 = (struct dirent *)arg;
+	d1 = (struct dirent __user *)arg;
 	if (!access_ok(VERIFY_WRITE, d1, sizeof(struct dirent[2])))
 		return -EFAULT;
 	/*
