Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936540AbWLDMne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936540AbWLDMne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936314AbWLDMnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:43:11 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:63454 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936301AbWLDMfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:35:13 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 34/35] Unionfs: Kconfig and Makefile
Date: Mon,  4 Dec 2006 07:31:07 -0500
Message-Id: <11652354733783-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains the changes to fs Kconfig file, Makefiles, and Maintainers
file for Unionfs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
---
 MAINTAINERS         |    7 +++++++
 fs/Kconfig          |   10 ++++++++++
 fs/Makefile         |    1 +
 fs/unionfs/Makefile |    5 +++++
 4 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8385a69..7d9ebb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3051,6 +3051,13 @@ L:	linux-kernel@vger.kernel.org
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
diff --git a/fs/Kconfig b/fs/Kconfig
index b3b5aa0..4b31ea4 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1557,6 +1557,16 @@ config UFS_DEBUG
 	  Y here.  This will result in _many_ additional debugging messages to be
 	  written to the system log.
 
+config UNION_FS
+	tristate "Union file system (EXPERIMENTAL)"
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
diff --git a/fs/Makefile b/fs/Makefile
index b9ffa63..76c6acc 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -115,3 +115,4 @@ obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
 obj-$(CONFIG_GFS2_FS)           += gfs2/
+obj-$(CONFIG_UNION_FS)		+= unionfs/
diff --git a/fs/unionfs/Makefile b/fs/unionfs/Makefile
new file mode 100644
index 0000000..25dd78f
--- /dev/null
+++ b/fs/unionfs/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_UNION_FS) += unionfs.o
+
+unionfs-y := subr.o dentry.o file.o inode.o main.o super.o \
+	stale_inode.o branchman.o rdstate.o copyup.o dirhelper.o \
+	rename.o unlink.o lookup.o commonfops.o dirfops.o sioq.o
-- 
1.4.3.3

