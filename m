Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287069AbRL2B5i>; Fri, 28 Dec 2001 20:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287070AbRL2B53>; Fri, 28 Dec 2001 20:57:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:33782 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287069AbRL2B5Q>;
	Fri, 28 Dec 2001 20:57:16 -0500
Date: Fri, 28 Dec 2001 20:57:14 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for bug in -pre3 reiserfs_read_super()
Message-ID: <Pine.GSO.4.21.0112282053450.3924-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Fsck.  The second chunk (LB5) that went into -pre3 adds an absolutely
bogus line and I'm seriously puzzled how in hell did it get there in
the first place ;-/  Fix follows:

diff -urN C2-pre3/fs/reiserfs/super.c C2-pre3-reiserfs/fs/reiserfs/super.c
--- C2-pre3/fs/reiserfs/super.c	Thu Dec 27 19:48:04 2001
+++ C2-pre3-reiserfs/fs/reiserfs/super.c	Fri Dec 28 20:51:33 2001
@@ -637,7 +637,6 @@
 	else
 	    old_format = 1;
     }
-    s->s_blocksize = size;
 
     s->u.reiserfs_sb.s_mount_state = SB_REISERFS_STATE(s);
     s->u.reiserfs_sb.s_mount_state = REISERFS_VALID_FS ;

