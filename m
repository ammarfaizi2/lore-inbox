Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269861AbRHDV47>; Sat, 4 Aug 2001 17:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269868AbRHDV4u>; Sat, 4 Aug 2001 17:56:50 -0400
Received: from p061.as-l031.contactel.cz ([212.65.234.253]:12804 "EHLO
	p061.as-l031.contactel.cz") by vger.kernel.org with ESMTP
	id <S269861AbRHDV4o>; Sat, 4 Aug 2001 17:56:44 -0400
Date: Sat, 4 Aug 2001 23:56:27 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: [PATCH] 2.4.7-ac4/ac5 dies due to double unlock
Message-ID: <20010804235627.C11632@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
  double-unlock on sb_lock in try_to_sync_unused inodes when 
try_to_sync_unused_list() returns 0... It is reliably
triggered by xmms loading mp3 tags from vfat...

  Originally from 2.4.7-ac4, but still unfixed in -ac5.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

diff -urdN linux/fs/inode.c linux/fs/inode.c
--- linux/fs/inode.c	Sat Aug  4 00:02:18 2001
+++ linux/fs/inode.c	Sat Aug  4 17:37:50 2001
@@ -412,7 +412,7 @@
 			continue;
 		spin_unlock(&sb_lock);
 		if (!try_to_sync_unused_list(&sb->s_dirty))
-			break;
+			return;
 		spin_lock(&sb_lock);
 	}
 	spin_unlock(&sb_lock);



