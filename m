Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283526AbRK3OSH>; Fri, 30 Nov 2001 09:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283542AbRK3OR5>; Fri, 30 Nov 2001 09:17:57 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:38673 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S283526AbRK3ORn>; Fri, 30 Nov 2001 09:17:43 -0500
Message-ID: <3C0794FE.79621AE@delusion.de>
Date: Fri, 30 Nov 2001 15:17:34 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [Correct PATCH] Re: Stuff that needs fixing in 2.5.1-pre4
In-Reply-To: <3C06F3A5.D407607A@delusion.de> <20011130084015.H16796@suse.de> <3C078FA7.8E78488C@delusion.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> Thanks for the tip. Here's a patch against 2.5.1-pre4 that fixes it.

I just noticed that my patch is reversed, so please apply it with -R or
alternatively try this fixed version.

-Udo.

diff -urN -X dontdiff linux-vanilla/fs/fat/file.c linux/fs/fat/file.c
--- linux-vanilla/fs/fat/file.c Sun Aug 12 19:56:56 2001
+++ linux/fs/fat/file.c Fri Nov 30 14:35:16 2001
@@ -48,7 +48,7 @@
 }


-int fat_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
+int fat_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
 {
        struct super_block *sb = inode->i_sb;
        unsigned long phys;
diff -urN -X dontdiff linux-vanilla/fs/minix/itree_common.c linux/fs/minix/itree_common.c
--- linux-vanilla/fs/minix/itree_common.c       Fri Sep  7 18:45:51 2001
+++ linux/fs/minix/itree_common.c       Fri Nov 30 14:39:37 2001
@@ -140,7 +140,7 @@
        return -EAGAIN;
 }

-static inline int get_block(struct inode * inode, long block,
+static inline int get_block(struct inode * inode, sector_t block,
                        struct buffer_head *bh_result, int create)
 {
        int err = -EIO;
diff -urN -X dontdiff linux-vanilla/include/linux/msdos_fs.h linux/include/linux/msdos_fs.h
--- linux-vanilla/include/linux/msdos_fs.h      Fri Oct 12 22:48:42 2001
+++ linux/include/linux/msdos_fs.h      Fri Nov 30 14:36:45 2001
@@ -273,7 +273,7 @@
 extern struct inode_operations fat_file_inode_operations;
 extern ssize_t fat_file_read(struct file *filp, char *buf, size_t count,
                             loff_t *ppos);
-extern int fat_get_block(struct inode *inode, long iblock,
+extern int fat_get_block(struct inode *inode, sector_t iblock,
                         struct buffer_head *bh_result, int create);
 extern ssize_t fat_file_write(struct file *filp, const char *buf, size_t count,
                              loff_t *ppos);
