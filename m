Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291125AbSBLP2K>; Tue, 12 Feb 2002 10:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291124AbSBLP2B>; Tue, 12 Feb 2002 10:28:01 -0500
Received: from angband.namesys.com ([212.16.7.85]:13696 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S291114AbSBLP1r>; Tue, 12 Feb 2002 10:27:47 -0500
Date: Tue, 12 Feb 2002 18:27:45 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 2.4 reiserfs for chown32.
Message-ID: <20020212182745.A1556@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    This patch fixes a problem where 32-bit uid/gid can only be set on a
    newly created file. All files that already existed at mount time
    were incorrectly marked as old format files without 32bit uid support.

    Please apply.

Bye,
    Oleg

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pick_correct_sd_version.diff"

--- linux/fs/reiserfs/inode.c.orig	Tue Feb  5 09:44:59 2002
+++ linux/fs/reiserfs/inode.c	Tue Feb 12 16:57:46 2002
@@ -931,9 +931,6 @@
 	// (directories and symlinks)
 	struct stat_data * sd = (struct stat_data *)B_I_PITEM (bh, ih);
 
-	/* both old and new directories have old keys */
-	//version = (S_ISDIR (sd->sd_mode) ? ITEM_VERSION_1 : ITEM_VERSION_2);
-
 	inode->i_mode   = sd_v2_mode(sd);
 	inode->i_nlink  = sd_v2_nlink(sd);
 	inode->i_uid    = sd_v2_uid(sd);
@@ -953,6 +950,8 @@
 	    set_inode_item_key_version (inode, KEY_FORMAT_3_5);
 	else
             set_inode_item_key_version (inode, KEY_FORMAT_3_6);
+
+        set_inode_sd_version (inode, STAT_DATA_V2);
     }
 
     /* nopack = 0, by default */

--mYCpIKhGyMATD0i+--
