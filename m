Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288807AbSAENEa>; Sat, 5 Jan 2002 08:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288809AbSAENEU>; Sat, 5 Jan 2002 08:04:20 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:29929 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288807AbSAENEQ>; Sat, 5 Jan 2002 08:04:16 -0500
Date: Sat, 5 Jan 2002 05:04:12 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Cc: jffs-dev@axis.com
Subject: Patch: linux-2.5.2-pre8/fs/jffs2 compilation fixes
Message-ID: <20020105050412.A25073@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.2-pre8/fs/jffs2 required a few minor
changes to make it compile.  dir.c needed to include <linux/sched.h>
for CURRENT_TIME, and there were a couple of kdev-related changes.
Here is the patch.

	It compiles.  I have not otherwise tested it.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jffs2.diffs"

Only in linux/fs/jffs2: CVS
diff -u -r linux-2.5.2-pre8/fs/jffs2/dir.c linux/fs/jffs2/dir.c
--- linux-2.5.2-pre8/fs/jffs2/dir.c	Fri Jan  4 19:40:37 2002
+++ linux/fs/jffs2/dir.c	Sat Jan  5 04:59:07 2002
@@ -37,6 +37,7 @@
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/sched.h>	/* for CURRENT_TIME */
 #include <linux/fs.h>
 #include <linux/jffs2.h>
 #include <linux/jffs2_fs_i.h>
diff -u -r linux-2.5.2-pre8/fs/jffs2/readinode.c linux/fs/jffs2/readinode.c
--- linux-2.5.2-pre8/fs/jffs2/readinode.c	Fri Sep 14 14:04:07 2001
+++ linux/fs/jffs2/readinode.c	Sat Jan  5 04:59:07 2002
@@ -437,7 +437,7 @@
 	case S_IFSOCK:
 	case S_IFIFO:
 		inode->i_op = &jffs2_file_inode_operations;
-		init_special_inode(inode, inode->i_mode, kdev_t_to_nr(MKDEV(rdev>>8, rdev&0xff)));
+		init_special_inode(inode, inode->i_mode, MKDEV(rdev>>8, rdev&0xff));
 		break;
 
 	default:
diff -u -r linux-2.5.2-pre8/fs/jffs2/super.c linux/fs/jffs2/super.c
--- linux-2.5.2-pre8/fs/jffs2/super.c	Fri Jan  4 19:40:37 2002
+++ linux/fs/jffs2/super.c	Sat Jan  5 04:59:07 2002
@@ -208,7 +208,7 @@
 	c = JFFS2_SB_INFO(sb);
 	memset(c, 0, sizeof(*c));
 	
-	c->mtd = get_mtd_device(NULL, MINOR(sb->s_dev));
+	c->mtd = get_mtd_device(NULL, minor(sb->s_dev));
 	if (!c->mtd) {
 		D1(printk(KERN_DEBUG "jffs2: MTD device #%u doesn't appear to exist\n", MINOR(sb->s_dev)));
 		return NULL;

--EVF5PPMfhYS0aIcm--
