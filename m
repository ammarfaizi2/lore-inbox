Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283654AbRK3NzY>; Fri, 30 Nov 2001 08:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283658AbRK3NzO>; Fri, 30 Nov 2001 08:55:14 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:32273 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S283654AbRK3Nyz>; Fri, 30 Nov 2001 08:54:55 -0500
Message-ID: <3C078FA7.8E78488C@delusion.de>
Date: Fri, 30 Nov 2001 14:54:47 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Stuff that needs fixing in 2.5.1-pre4
In-Reply-To: <3C06F3A5.D407607A@delusion.de> <20011130084015.H16796@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> Make the get_block long argument for block a sector_t. Once you have
> that warning free, send on the fix.

Thanks for the tip. Here's a patch against 2.5.1-pre4 that fixes it.

Regards,
Udo.

diff -urN -X dontdiff linux/fs/fat/file.c linux-vanilla/fs/fat/file.c
--- linux/fs/fat/file.c Fri Nov 30 14:35:16 2001
+++ linux-vanilla/fs/fat/file.c Sun Aug 12 19:56:56 2001
@@ -48,7 +48,7 @@
 }


-int fat_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
+int fat_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
 {
        struct super_block *sb = inode->i_sb;
        unsigned long phys;
diff -urN -X dontdiff linux/fs/minix/itree_common.c linux-vanilla/fs/minix/itree_common.c
--- linux/fs/minix/itree_common.c       Fri Nov 30 14:39:37 2001
+++ linux-vanilla/fs/minix/itree_common.c       Fri Sep  7 18:45:51 2001
@@ -140,7 +140,7 @@
        return -EAGAIN;
 }

-static inline int get_block(struct inode * inode, sector_t block,
+static inline int get_block(struct inode * inode, long block,
                        struct buffer_head *bh_result, int create)
 {
        int err = -EIO;
diff -urN -X dontdiff linux/include/linux/msdos_fs.h linux-vanilla/include/linux/msdos_fs.h
--- linux/include/linux/msdos_fs.h      Fri Nov 30 14:36:45 2001
+++ linux-vanilla/include/linux/msdos_fs.h      Fri Oct 12 22:48:42 2001
@@ -273,7 +273,7 @@
 extern struct inode_operations fat_file_inode_operations;
 extern ssize_t fat_file_read(struct file *filp, char *buf, size_t count,
                             loff_t *ppos);
-extern int fat_get_block(struct inode *inode, sector_t iblock,
+extern int fat_get_block(struct inode *inode, long iblock,
                         struct buffer_head *bh_result, int create);
 extern ssize_t fat_file_write(struct file *filp, const char *buf, size_t count,
                              loff_t *ppos);
