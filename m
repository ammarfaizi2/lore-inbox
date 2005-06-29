Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVF2Wz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVF2Wz6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVF2Wz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:55:58 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:47877 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262714AbVF2WxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:53:06 -0400
Date: Wed, 29 Jun 2005 18:53:06 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] reiserfs: enable attrs by default if saf
Message-ID: <20050629225306.GA7287@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.151-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 The following patch enables attrs by default if the reiserfs_attrs_cleared
 bit is set in the superblock. This allows chattr-type attrs to be used
 without any further action by the user.

 Please apply.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
 
diff -ruNpX dontdiff linux-2.6.12-rc6/fs/reiserfs/super.c linux-2.6.12-rc6.devel/fs/reiserfs/super.c
--- linux-2.6.12-rc6/fs/reiserfs/super.c	2005-06-13 14:34:58.000000000 -0400
+++ linux-2.6.12-rc6.devel/fs/reiserfs/super.c	2005-06-22 17:34:55.000000000 -0400
@@ -884,6 +884,8 @@ static void handle_attrs( struct super_b
 				reiserfs_warning(s, "reiserfs: cannot support attributes until flag is set in super-block" );
 				REISERFS_SB(s) -> s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );
 		}
+	} else if (le32_to_cpu( rs -> s_flags ) & reiserfs_attrs_cleared) {
+		REISERFS_SB(s)->s_mount_opt |= REISERFS_ATTRS;
 	}
 }
 
-- 
Jeff Mahoney
SuSE Labs
