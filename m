Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275645AbRIZVvs>; Wed, 26 Sep 2001 17:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275644AbRIZVvj>; Wed, 26 Sep 2001 17:51:39 -0400
Received: from 213-4-252-67.uc.nombres.ttd.es ([213.4.252.67]:3332 "EHLO femto")
	by vger.kernel.org with ESMTP id <S275645AbRIZVv2>;
	Wed, 26 Sep 2001 17:51:28 -0400
Date: Wed, 26 Sep 2001 23:15:13 +0200
From: Eric Van Buggenhaut <ericvb@debian.org>
To: linux-kernel@vger.kernel.org
Subject: linux/fs/sysv/symlink.c in patch-2.4.10.bz2
Message-ID: <20010926231512.D639@eric.ath.cx>
Reply-To: Eric.VanBuggenhaut@AdValvas.be
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Echelon: FBI CIA NSA Handgun Assault Atomic Bomb Heroin Drug Terrorism
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch-2.4.10.bz2 pretends to install a new file

linux/fs/sysv/symlink.c

 which already exists in 2.4.9.

I also notice v2.4.9 is dated ... Wed Dec 31 16:00:00 1969

Woaw I didn't realize I had been playing with linux for so long !


diff -u --recursive --new-file v2.4.9/linux/fs/sysv/symlink.c linux/fs/sysv/symlink.c
--- v2.4.9/linux/fs/sysv/symlink.c  Wed Dec 31 16:00:00 1969
+++ linux/fs/sysv/symlink.c Sun Sep  2 10:34:36 2001
@@ -0,0 +1,25 @@
+/*
+ *  linux/fs/sysv/symlink.c
+ *
+ *  Handling of System V filesystem fast symlinks extensions.
+ *  Aug 2001, Christoph Hellwig (hch@caldera.de)
+ */
+
+#include <linux/fs.h>
+
+static int sysv_readlink(struct dentry *dentry, char *buffer, int buflen)
+{
+   char *s = (char *)dentry->d_inode->u.sysv_i.i_data;
+   return vfs_readlink(dentry, buffer, buflen, s);
+}
+
+static int sysv_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+   char *s = (char *)dentry->d_inode->u.sysv_i.i_data;
+   return vfs_follow_link(nd, s);
+}
+
+struct inode_operations sysv_fast_symlink_inode_operations = {
+   readlink:   sysv_readlink,
+   follow_link:    sysv_follow_link,
+};
diff -u --recursive --new-file v2.4.9/linux/fs/ufs/balloc.c linux/fs/ufs/balloc.c


Should 2.4.9 be remove before installing 2.4.10 ?

Thanks.

-- 
Eric VAN BUGGENHAUT

Eric.VanBuggenhaut@AdValvas.be
