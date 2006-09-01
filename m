Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWIABjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWIABjf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWIABjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:39:35 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:30086 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932354AbWIABje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:39:34 -0400
Date: Thu, 31 Aug 2006 21:39:17 -0400
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 02/22][RFC] Unionfs: Kconfig and Makefile
Message-ID: <20060901013917.GC5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Quigley <dquigley@fsl.cs.sunysb.edu>

This patch contains the changes to fs Kconfig file, Makefiles, and Maintainers
file for Unionfs.

Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

 MAINTAINERS         |    7 +++++++
 fs/Kconfig          |   10 ++++++++++
 fs/Makefile         |    1 +
 fs/unionfs/Makefile |    5 +++++
 4 files changed, 23 insertions(+)

diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/Kconfig linux-2.6-git-unionfs/fs/Kconfig
--- linux-2.6-git/fs/Kconfig	2006-08-31 18:43:47.000000000 -0400
+++ linux-2.6-git-unionfs/fs/Kconfig	2006-08-31 19:04:00.000000000 -0400
@@ -1394,6 +1394,16 @@
 	  Y here.  This will result in _many_ additional debugging messages to be
 	  written to the system log.
 
+config UNION_FS
+	tristate "Stackable namespace unification file system"
+	depends on EXPERIMENTAL
+	help
+	  Unionfs is a stackable unification file system, which appears to
+	  merge the contents of several directories (branches), while keeping
+	  their physical content separate.
+
+	  See <http://www.unionfs.org> for details
+
 endmenu
 
 menu "Network File Systems"
diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/Makefile linux-2.6-git-unionfs/fs/Makefile
--- linux-2.6-git/fs/Makefile	2006-08-31 18:43:47.000000000 -0400
+++ linux-2.6-git-unionfs/fs/Makefile	2006-08-31 19:04:00.000000000 -0400
@@ -102,3 +102,4 @@
 obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
+obj-$(CONFIG_UNION_FS)		+= unionfs/
diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/unionfs/Makefile linux-2.6-git-unionfs/fs/unionfs/Makefile
--- linux-2.6-git/fs/unionfs/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-git-unionfs/fs/unionfs/Makefile	2006-08-31 19:04:00.000000000 -0400
@@ -0,0 +1,5 @@
+obj-$(CONFIG_UNION_FS) += unionfs.o
+
+unionfs-objs := subr.o dentry.o file.o inode.o main.o super.o \
+	stale_inode.o branchman.o rdstate.o copyup.o dirhelper.o \
+	rename.o unlink.o lookup.o commonfops.o dirfops.o sioq.o
diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/MAINTAINERS linux-2.6-git-unionfs/MAINTAINERS
--- linux-2.6-git/MAINTAINERS	2006-08-31 18:43:38.000000000 -0400
+++ linux-2.6-git-unionfs/MAINTAINERS	2006-08-31 19:03:49.000000000 -0400
@@ -2921,6 +2921,13 @@
 W:	http://www.kernel.dk
 S:	Maintained
 
+UNIONFS
+P:	Josef "Jeff" Sipek
+M:	jsipek@cs.sunysb.edu
+L:	unionfs@filesystems.org
+W:	http://www.unionfs.org
+S:	Maintained
+
 USB ACM DRIVER
 P:	Oliver Neukum
 M:	oliver@neukum.name
