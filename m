Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbSKPVfy>; Sat, 16 Nov 2002 16:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267370AbSKPVfy>; Sat, 16 Nov 2002 16:35:54 -0500
Received: from verein.lst.de ([212.34.181.86]:14607 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267367AbSKPVfw>;
	Sat, 16 Nov 2002 16:35:52 -0500
Date: Sat, 16 Nov 2002 22:42:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nuke some crap from fs.h
Message-ID: <20021116224246.A26097@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove four dead prototypes and don't include mount.h here - fs.h
itself doesn't need it at all (just the struct vfsmount forward
declaration) and gets it through dcache.h anyway.


--- 1.190/include/linux/fs.h	Thu Nov 14 06:35:31 2002
+++ edited/include/linux/fs.h	Sat Nov 16 20:18:12 2002
@@ -28,7 +28,7 @@
 
 struct poll_table_struct;
 struct nameidata;
-
+struct vfsmount;
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -271,10 +271,9 @@
 #define ATTR_FLAG_NODIRATIME	16 	/* Don't update atime for directory */
 
 /*
- * Includes for diskquotas and mount structures.
+ * Includes for diskquotas.
  */
 #include <linux/quota.h>
-#include <linux/mount.h>
 
 /*
  * oh the beauties of C type declarations.
@@ -1340,11 +1339,6 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 extern unsigned int real_root_dev;
 #endif
-
-extern ssize_t char_read(struct file *, char *, size_t, loff_t *);
-extern ssize_t block_read(struct file *, char *, size_t, loff_t *);
-extern ssize_t char_write(struct file *, const char *, size_t, loff_t *);
-extern ssize_t block_write(struct file *, const char *, size_t, loff_t *);
 
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern int inode_setattr(struct inode *, struct iattr *);
