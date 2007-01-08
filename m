Return-Path: <linux-kernel-owner+w=401wt.eu-S1030545AbXAHEZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030545AbXAHEZE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbXAHESb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:18:31 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50416 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030498AbXAHESZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:18:25 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, akpm@osdl.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: [PATCH 23/24] Unionfs: Kconfig and Makefile
Date: Sun,  7 Jan 2007 23:13:15 -0500
Message-Id: <11682296001876-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
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
index 2bd34ef..33dc1b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3241,6 +3241,13 @@ L:	linux-kernel@vger.kernel.org
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
index 8cd2417..2e519f4 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1554,6 +1554,16 @@ config UFS_DEBUG
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
1.4.4.2

