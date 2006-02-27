Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWB0Wb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWB0Wb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWB0Wb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:56 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:22913 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932358AbWB0Wb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:28 -0500
Message-Id: <20060227223358.884668000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:27 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, philipp.marek@bmlv.gv.at
Subject: [patch 27/39] [PATCH] ramfs: update dir mtime and ctime
Content-Disposition: inline; filename=ramfs-update-dir-mtime-and-ctime.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Phil Marek <philipp.marek@bmlv.gv.at> points out that ramfs forgets to update
a directory's mtime and ctime when it is modified.

Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 fs/ramfs/inode.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.15.4.orig/fs/ramfs/inode.c
+++ linux-2.6.15.4/fs/ramfs/inode.c
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/time.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
@@ -105,6 +106,7 @@ ramfs_mknod(struct inode *dir, struct de
 		d_instantiate(dentry, inode);
 		dget(dentry);	/* Extra count - pin the dentry in core */
 		error = 0;
+		dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	}
 	return error;
 }

--
