Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTIQQgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTIQQgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 12:36:31 -0400
Received: from vena.lwn.net ([206.168.112.25]:54501 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262034AbTIQQg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 12:36:29 -0400
Message-ID: <20030917163628.19833.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: Re: [PATCH] Export new char dev functions 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 17 Sep 2003 03:49:11 BST."
             <20030917024911.GA35464@compsoc.man.ac.uk> 
Date: Wed, 17 Sep 2003 10:36:28 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> John Levon sez:
> > Of course, there are other exports from that file (i.e. register_chrdev());
> > are we actively trying to shrink ksyms.c?
> 
> I think we are, yes. ksyms.c just makes life harder.

OK, here is a version that evacutates all of fs/char_dev.c's functions out
of ksyms.c.  And that, probably, is about all the bandwidth this little
patch is worth...

jon

diff -urN -X dontdiff test5-vanilla/fs/char_dev.c test5/fs/char_dev.c
--- test5-vanilla/fs/char_dev.c	Mon Sep  8 13:50:01 2003
+++ test5/fs/char_dev.c	Wed Sep 17 10:45:46 2003
@@ -445,3 +445,18 @@
 	kset_register(&kset_dynamic);
 	cdev_map = kobj_map_init(base_probe, &cdev_subsys);
 }
+
+
+/* Let modules do char dev stuff */
+EXPORT_SYMBOL(register_chrdev_region);
+EXPORT_SYMBOL(unregister_chrdev_region);
+EXPORT_SYMBOL(alloc_chrdev_region);
+EXPORT_SYMBOL(cdev_init);
+EXPORT_SYMBOL(cdev_alloc);
+EXPORT_SYMBOL(cdev_get);
+EXPORT_SYMBOL(cdev_put);
+EXPORT_SYMBOL(cdev_del);
+EXPORT_SYMBOL(cdev_add);
+EXPORT_SYMBOL(cdev_unmap);
+EXPORT_SYMBOL(register_chrdev);
+EXPORT_SYMBOL(unregister_chrdev);

diff -urN -X dontdiff test5-vanilla/kernel/ksyms.c test5/kernel/ksyms.c
--- test5-vanilla/kernel/ksyms.c	Wed Sep 17 01:58:05 2003
+++ test5/kernel/ksyms.c	Wed Sep 17 10:45:46 2003
@@ -348,8 +348,6 @@
 EXPORT_SYMBOL(unlock_page);
 
 /* device registration */
-EXPORT_SYMBOL(register_chrdev);
-EXPORT_SYMBOL(unregister_chrdev);
 EXPORT_SYMBOL(register_blkdev);
 EXPORT_SYMBOL(unregister_blkdev);
 EXPORT_SYMBOL(tty_register_driver);
