Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTJBQQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 12:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbTJBQQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 12:16:57 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:34274 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263397AbTJBQQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 12:16:54 -0400
Date: Thu, 2 Oct 2003 18:16:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Russell King <rmk@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] remove unnecessary #includes from <linux/fs.h>
Message-ID: <20031002161639.GF10382@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928204224.G1428@flint.arm.linux.org.uk> <20030928200001.GC16921@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030928200001.GC16921@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 September 2003 22:00:01 +0200, Jörn Engel wrote:
> On Sun, 28 September 2003 20:42:24 +0100, Russell King wrote:
> > 
> > and that will prevent the #include maze of 2.4, which resulted in
> > everything being rebuilt just because one header file was touched.
> 
> Ok, how about this:
> 
> for each header file {
> 	make header.o
> 1)	if it doesn't build {
> 		print out a warning
> 		continue
> 	}
> 	for each #include line {
> 		remove the #include line
> 		make header.o
> 2)		if it build {
> 			print out a warning
> 		}
> 3)		if there are less than x gcc warnings {
> 			print out a warning
> 		}
> 	}
> }

You didn't comment on my suggestion, so I've done it manually once for
linux/fs.h and was shocked.  It still passes my compile-standalone
test after removing 11! #include lines.

Another one was a false hit, because I compiled UP only, and some of
the remaining may be as well, but it looks like we recompile way too
much after changes to a random header.

Russell, can you comment this time, or should I shove the patch to
Linus and wait if anyone starts screaming?

Jörn

-- 
Sometimes, asking the right question is already the answer.
-- Unknown

--- linux-2.6.0-test5/include/linux/fs.h~include_prune	2003-10-02 18:07:20.000000000 +0200
+++ linux-2.6.0-test5/include/linux/fs.h	2003-10-02 18:09:41.000000000 +0200
@@ -6,20 +6,11 @@
  * structures etc.
  */
 
-#include <linux/config.h>
-#include <linux/linkage.h>
-#include <linux/limits.h>
-#include <linux/wait.h>
-#include <linux/types.h>
 #include <linux/kdev_t.h>
-#include <linux/ioctl.h>
-#include <linux/list.h>
 #include <linux/dcache.h>
 #include <linux/stat.h>
-#include <linux/cache.h>
 #include <linux/radix-tree.h>
 #include <linux/kobject.h>
-#include <asm/atomic.h>
 
 struct iovec;
 struct nameidata;
@@ -208,7 +199,6 @@
 #ifdef __KERNEL__
 
 #include <asm/semaphore.h>
-#include <asm/byteorder.h>
 
 /* Used to be a macro which just called the function, now just a function */
 extern void update_atime (struct inode *);
@@ -1236,8 +1226,6 @@
 extern int is_subdir(struct dentry *, struct dentry *);
 extern ino_t find_inode_number(struct dentry *, struct qstr *);
 
-#include <linux/err.h>
-
 /* needed for stackable file system support */
 extern loff_t default_llseek(struct file *file, loff_t offset, int origin);
 
