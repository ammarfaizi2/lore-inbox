Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbTEYVim (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 17:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTEYVim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 17:38:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8842 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263781AbTEYVil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 17:38:41 -0400
Date: Sun, 25 May 2003 22:51:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
   AlexanderOD Viro <aviro@redhat.com>
Subject: [PATCH] Re: oops with bk kernel as of 2003-05-25T13:00:00-07
Message-ID: <20030525215150.GI6270@parcelfarce.linux.theplanet.co.uk>
References: <3ED12727.1080907@redhat.com> <20030525213040.GH6270@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525213040.GH6270@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 10:30:40PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:

> Guess which one wins...  What a mess...  How about the following (untested,
> but AFAICS should work)

[snip]

or, to make it compile, the following:

diff -urN linux/fs/char_dev.c linux2/fs/char_dev.c
--- linux/fs/char_dev.c	Sun May 25 08:01:46 2003
+++ linux2/fs/char_dev.c	Sun May 25 17:26:04 2003
@@ -457,11 +457,9 @@
 	return NULL;
 }
 
-static int __init chrdev_init(void)
+void __init chrdev_init(void)
 {
 	subsystem_register(&cdev_subsys);
 	kset_register(&kset_dynamic);
 	cdev_map = kobj_map_init(base_probe, &cdev_subsys);
-	return 0;
 }
-subsys_initcall(chrdev_init);
diff -urN linux/fs/dcache.c linux2/fs/dcache.c
--- linux/fs/dcache.c	Sat May 24 18:49:58 2003
+++ linux2/fs/dcache.c	Sun May 25 17:25:40 2003
@@ -1606,6 +1606,7 @@
 EXPORT_SYMBOL(d_genocide);
 
 extern void bdev_cache_init(void);
+extern void chrdev_init(void);
 
 void __init vfs_caches_init(unsigned long mempages)
 {
@@ -1626,4 +1627,5 @@
 	files_init(mempages); 
 	mnt_init(mempages);
 	bdev_cache_init();
+	chrdev_init();
 }

