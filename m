Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTLOGIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 01:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTLOGIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 01:08:42 -0500
Received: from dp.samba.org ([66.70.73.150]:57788 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263172AbTLOGIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 01:08:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Wrong request_module line in genhd.c
Date: Mon, 15 Dec 2003 11:50:14 +1100
Message-Id: <20031215060838.8AC932C06A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one was missed somehow.  Fixes autoloading of loop devices.

Cheers,
Rusty.

Name: Block Alias Fix in genhd.c
Author: Rusty Russell
Status: Trivial

D: MODULE_ALIAS_BLOCK and genhd.c's request_module() don't match,
D: which breaks autoloading of loop devices.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2035-linux-2.6.0-test8-bk2/drivers/block/genhd.c .2035-linux-2.6.0-test8-bk2.updated/drivers/block/genhd.c
--- .2035-linux-2.6.0-test8-bk2/drivers/block/genhd.c	2003-10-09 18:02:51.000000000 +1000
+++ .2035-linux-2.6.0-test8-bk2.updated/drivers/block/genhd.c	2003-10-23 14:09:35.000000000 +1000
@@ -296,7 +296,7 @@ extern int blk_dev_init(void);
 
 static struct kobject *base_probe(dev_t dev, int *part, void *data)
 {
-	request_module("block-major-%d", MAJOR(dev));
+	request_module("block-major-%d-%d", MAJOR(dev), MINOR(dev));
 	return NULL;
 }
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
