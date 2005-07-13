Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVGMSDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVGMSDc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVGMSDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:03:14 -0400
Received: from [151.97.230.9] ([151.97.230.9]:17132 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261691AbVGMSAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:00:33 -0400
Subject: [patch 5/9] uml: fix hppfs error path
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 13 Jul 2005 20:02:27 +0200
Message-Id: <20050713180228.4582021E739@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the error message to refer to the error code, i.e. err, not count, plus
add some cosmetical fixes.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/fs/hppfs/hppfs_kern.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN fs/hppfs/hppfs_kern.c~uml-hppfs-error-case fs/hppfs/hppfs_kern.c
--- linux-2.6.git-broken/fs/hppfs/hppfs_kern.c~uml-hppfs-error-case	2005-07-13 19:41:36.000000000 +0200
+++ linux-2.6.git-broken-paolo/fs/hppfs/hppfs_kern.c	2005-07-13 19:41:36.000000000 +0200
@@ -233,7 +233,7 @@ static ssize_t read_proc(struct file *fi
 		set_fs(USER_DS);
 
 	if(ppos) *ppos = file->f_pos;
-	return(n);
+	return n;
 }
 
 static ssize_t hppfs_read_file(int fd, char *buf, ssize_t count)
@@ -254,7 +254,7 @@ static ssize_t hppfs_read_file(int fd, c
 		err = os_read_file(fd, new_buf, cur);
 		if(err < 0){
 			printk("hppfs_read : read failed, errno = %d\n",
-			       count);
+			       err);
 			n = err;
 			goto out_free;
 		}
@@ -271,7 +271,7 @@ static ssize_t hppfs_read_file(int fd, c
  out_free:
 	kfree(new_buf);
  out:
-	return(n);
+	return n;
 }
 
 static ssize_t hppfs_read(struct file *file, char *buf, size_t count,
_
