Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbWJGFyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWJGFyu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWJGFyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:54:50 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50864 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932441AbWJGFyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:54:49 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 23 of 23] Unionfs: Kconfig and Makefile
Message-Id: <81b3a65f58d6fd6827cb.1160197662@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
Date: Sat, 07 Oct 2006 01:07:42 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains the changes to fs Kconfig file, Makefiles, and Maintainers
file for Unionfs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

4 files changed, 23 insertions(+)
MAINTAINERS         |    7 +++++++
fs/Kconfig          |   10 ++++++++++
fs/Makefile         |    1 +
fs/unionfs/Makefile |    5 +++++

diff -r a20795e821a8 -r 81b3a65f58d6 MAINTAINERS
--- a/MAINTAINERS	Sat Oct 07 00:46:20 2006 -0400
+++ b/MAINTAINERS	Sat Oct 07 00:46:20 2006 -0400
@@ -3003,6 +3003,13 @@ W:	http://www.kernel.dk
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
diff -r a20795e821a8 -r 81b3a65f58d6 fs/Kconfig
--- a/fs/Kconfig	Sat Oct 07 00:46:20 2006 -0400
+++ b/fs/Kconfig	Sat Oct 07 00:46:20 2006 -0400
@@ -1453,6 +1453,16 @@ config UFS_DEBUG
 	  If you are experiencing any problems with the UFS filesystem, say
 	  Y here.  This will result in _many_ additional debugging messages to be
 	  written to the system log.
+
+config UNION_FS
+	tristate "Stackable namespace unification file system"
+	depends on EXPERIMENTAL
+	help
+	  Unionfs is a stackable unification file system, which appears to
+	  merge the contents of several directories (branches), while keeping
+	  their physical content separate.
+
+	  See <http://www.unionfs.org> for details
 
 endmenu
 
diff -r a20795e821a8 -r 81b3a65f58d6 fs/Makefile
--- a/fs/Makefile	Sat Oct 07 00:46:20 2006 -0400
+++ b/fs/Makefile	Sat Oct 07 00:46:20 2006 -0400
@@ -112,3 +112,4 @@ obj-$(CONFIG_DEBUG_FS)		+= debugfs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
 obj-$(CONFIG_GFS2_FS)           += gfs2/
+obj-$(CONFIG_UNION_FS)		+= unionfs/
diff -r a20795e821a8 -r 81b3a65f58d6 fs/unionfs/Makefile
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/fs/unionfs/Makefile	Sat Oct 07 00:46:20 2006 -0400
@@ -0,0 +1,5 @@
+obj-$(CONFIG_UNION_FS) += unionfs.o
+
+unionfs-objs := subr.o dentry.o file.o inode.o main.o super.o \
+	stale_inode.o branchman.o rdstate.o copyup.o dirhelper.o \
+	rename.o unlink.o lookup.o commonfops.o dirfops.o sioq.o


