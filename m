Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143371AbRAHMS2>; Mon, 8 Jan 2001 07:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143437AbRAHMSS>; Mon, 8 Jan 2001 07:18:18 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:4737 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S143371AbRAHMR7>; Mon, 8 Jan 2001 07:17:59 -0500
Date: Mon, 8 Jan 2001 14:17:02 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cramfs is ro only, so honour this in inode->mode
Message-ID: <20010108141702.I10035@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
hi all,

cramfs is a read-only fs. So we should honour that in inode->mode
to avoid confusion of programs.

My isofs shows this too, so I think I'm right deleting the write
permissions in the inode. May be we should change it in
mkcramfs (too).

I don't know what POSIX says about RO fs, but I can't find any
real sense in having W permissions for an RO fs.

The patch:
--- linux-2.4.0/fs/cramfs/inode.c.orig  Fri Dec 29 23:07:57 2000
+++ linux-2.4.0/fs/cramfs/inode.c       Mon Jan  8 13:04:37 2001
@@ -37,7 +37,7 @@
        struct inode * inode = new_inode(sb);

        if (inode) {
-               inode->i_mode = cramfs_inode->mode;
+               inode->i_mode = cramfs_inode->mode & ~ S_IWUGO;
                inode->i_uid = cramfs_inode->uid;
                inode->i_size = cramfs_inode->size;
                inode->i_gid = cramfs_inode->gid;

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
