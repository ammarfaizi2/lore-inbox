Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288805AbSAENCA>; Sat, 5 Jan 2002 08:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288807AbSAENBu>; Sat, 5 Jan 2002 08:01:50 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:27113 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288805AbSAENBk>; Sat, 5 Jan 2002 08:01:40 -0500
Date: Sat, 5 Jan 2002 05:01:39 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.2-pre8/fs/jffs kdev_t compilation fixes
Message-ID: <20020105050139.A25057@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Here is a patch for a couple of kdev-related fixes needed
to make linux-2.5.2-pre8/fs/jffs compile.

	I know it compiles.  I have not otherwise tested it.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jffs.diffs"

Only in linux/fs/jffs: CVS
diff -u -r linux-2.5.2-pre8/fs/jffs/inode-v23.c linux/fs/jffs/inode-v23.c
--- linux-2.5.2-pre8/fs/jffs/inode-v23.c	Fri Jan  4 19:40:37 2002
+++ linux/fs/jffs/inode-v23.c	Sat Jan  5 04:55:37 2002
@@ -357,7 +357,7 @@
 	inode->i_nlink = raw_inode->nlink;
 	inode->i_uid = raw_inode->uid;
 	inode->i_gid = raw_inode->gid;
-	inode->i_rdev = 0;
+	inode->i_rdev = NODEV;
 	inode->i_size = raw_inode->dsize;
 	inode->i_atime = raw_inode->atime;
 	inode->i_mtime = raw_inode->mtime;
diff -u -r linux-2.5.2-pre8/fs/jffs/jffs_fm.c linux/fs/jffs/jffs_fm.c
--- linux-2.5.2-pre8/fs/jffs/jffs_fm.c	Thu Oct  4 15:13:18 2001
+++ linux/fs/jffs/jffs_fm.c	Sat Jan  5 04:55:37 2002
@@ -46,7 +46,7 @@
 	}
 	DJM(no_jffs_fmcontrol++);
 
-	mtd = get_mtd_device(NULL, MINOR(dev));
+	mtd = get_mtd_device(NULL, minor(dev));
 
 	if (!mtd) {
 		kfree(fmc);

--vtzGhvizbBRQ85DL--
