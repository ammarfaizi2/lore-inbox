Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbTIQCge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbTIQCge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:36:34 -0400
Received: from vena.lwn.net ([206.168.112.25]:27601 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262661AbTIQCgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:36:32 -0400
Message-ID: <20030917023630.24595.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, torvalds@osdl.org
Subject: Re: [PATCH] Export new char dev functions 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Tue, 16 Sep 2003 16:57:30 PDT."
             <20030916235729.GA6198@kroah.com> 
Date: Tue, 16 Sep 2003 20:36:30 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about just exporting them in the files where they are declared?  I
> do not think we want the ksyms.c file to grow anymore.

Hmm, I figured somebody would say something like that...grumble...mutter...
...complain...gripe...moan...new patch appended...

Of course, there are other exports from that file (i.e. register_chrdev());
are we actively trying to shrink ksyms.c?

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net

--- test5-vanilla/fs/char_dev.c	Mon Sep  8 13:50:01 2003
+++ test5/fs/char_dev.c	Wed Sep 17 10:19:18 2003
@@ -445,3 +445,16 @@
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
