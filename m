Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTDSVIV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 17:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTDSVIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 17:08:21 -0400
Received: from hera.cwi.nl ([192.16.191.8]:52210 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263468AbTDSVIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 17:08:20 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 19 Apr 2003 23:20:18 +0200 (MEST)
Message-Id: <UTC200304192120.h3JLKIn19920.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] fix slab corruption in namespace.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The
	new_ns = kmalloc(sizeof(struct namespace *), GFP_KERNEL);
was less fortunate.

Andries

----------------------------------------------------------------
diff -u --recursive --new-file -X /linux/dontdiff a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Wed Mar  5 10:47:29 2003
+++ b/fs/namespace.c	Sat Apr 19 23:17:34 2003
@@ -52,7 +52,7 @@
 		INIT_LIST_HEAD(&mnt->mnt_list);
 		if (name) {
 			int size = strlen(name)+1;
-			char * newname = kmalloc(size, GFP_KERNEL);
+			char *newname = kmalloc(size, GFP_KERNEL);
 			if (newname) {
 				memcpy(newname, name, size);
 				mnt->mnt_devname = newname;
@@ -774,7 +774,7 @@
 
 	get_namespace(namespace);
 
-	if (! (flags & CLONE_NEWNS))
+	if (!(flags & CLONE_NEWNS))
 		return 0;
 
 	if (!capable(CAP_SYS_ADMIN)) {
@@ -782,7 +782,7 @@
 		return -EPERM;
 	}
 
-	new_ns = kmalloc(sizeof(struct namespace *), GFP_KERNEL);
+	new_ns = kmalloc(sizeof(struct namespace), GFP_KERNEL);
 	if (!new_ns)
 		goto out;
 
