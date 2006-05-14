Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWENAHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWENAHE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 20:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWENAHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 20:07:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:63751 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964819AbWENAHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 20:07:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cS4KOjOUl1J1LLz23jd7EWcjz2cVUBHL0GufF9nseF8jMaK4xJYGQINUVXaAjzG9JdhezazlJBiP9k+n7Gddd1uD7oOr1jmTIPL7EIQqiYkvb2x4DR3Holy+ZGTUp8whdvUhgmswKOVbLC+w4aNCgpRxN+8gnLeT8XnZmNwSrko=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] panic() instead of crashing on a null pointer deref in mount_block_root()
Date: Sun, 14 May 2006 02:07:51 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605140207.52035.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If __getname() fails in mount_block_root() we are dead in the water, but
a panic() seems a little nicer than crashing due to a NULL pointer deref.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 init/do_mounts.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


--- linux-2.6.17-rc4-git2-orig/init/do_mounts.c	2006-05-13 21:28:53.000000000 +0200
+++ linux-2.6.17-rc4-git2/init/do_mounts.c	2006-05-14 02:05:52.000000000 +0200
@@ -286,6 +286,8 @@ void __init mount_block_root(char *name,
 	char *p;
 	char b[BDEVNAME_SIZE];
 
+	if (!fs_names)
+		panic("VFS: Failed memory allocation in mount_block_root()");
 	get_fs_names(fs_names);
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
@@ -425,4 +427,3 @@ out:
 	security_sb_post_mountroot();
 	mount_devfs_fs ();
 }
-




