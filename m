Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276411AbRJCPnn>; Wed, 3 Oct 2001 11:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276422AbRJCPne>; Wed, 3 Oct 2001 11:43:34 -0400
Received: from altern.org ([212.73.209.210]:26639 "HELO altern.org")
	by vger.kernel.org with SMTP id <S276411AbRJCPnQ>;
	Wed, 3 Oct 2001 11:43:16 -0400
Date: Wed, 3 Oct 2001 17:43:22 +0200 (CEST)
From: <booh@altern.org>
Subject: [PATCH] Re: all files are executable in vfat
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Message-Id: <20011003154324Z276411-761+15300@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at linux/fs/fat/inode.c it seems that everything is
here to allow a smart handling of the x flag.
But there is something that I don't undestand (or is a bug)
and is corrected by this micro patch.

--- linux-2.4.10-xfs/fs/fat/inode.c        Wed Sep 26 20:59:39 2001
+++ linux-2.4.10-xfs.fat_exec/fs/fat/inode.c     Wed Sep 26 22:32:35 2001
@@ -920,8 +920,8 @@
                inode->i_generation |= 1;
                inode->i_mode = MSDOS_MKMODE(de->attr,
                    ((sbi->options.showexec &&
-                      !is_exec(de->ext))
-                       ? S_IRUGO|S_IWUGO : S_IRWXUGO)
+                      is_exec(de->ext))
+                       ? S_IRWXUGO : S_IRUGO|S_IWUGO)
                    & ~sbi->options.fs_umask) | S_IFREG;
                MSDOS_I(inode)->i_start = CF_LE_W(de->start);
                if (sbi->fat_bits == 32) {


Now you have two choices when using umask=OOO
- without showexec : only dirs have the x flag set.
- with showexec : *.{exe,bat,com} have it too.

I am not the list so ...

Guillaume Chazarain
(putting my name in the header doesn't work.)
