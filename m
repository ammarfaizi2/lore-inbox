Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291875AbSBTOW5>; Wed, 20 Feb 2002 09:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291876AbSBTOWt>; Wed, 20 Feb 2002 09:22:49 -0500
Received: from angband.namesys.com ([212.16.7.85]:7552 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S291875AbSBTOWh>; Wed, 20 Feb 2002 09:22:37 -0500
Date: Wed, 20 Feb 2002 17:22:27 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, reiserfs-dev@namesys.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5 dropping unneded lock precense check.
Message-ID: <20020220172227.A998@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   After BKL was moved from the VFS into the filesystem's methods in the lookup
   call, we do not need to check BKL is actually held (we know it is not).
   This patch patch removes unneeded lock_depth check.
   Without this patch reiserfs cannot be used on SMP.
   Please apply.


--- linux-2.5.5/fs/reiserfs/namei.c.orig	Thu Feb 14 11:53:09 2002
+++ linux-2.5.5/fs/reiserfs/namei.c	Thu Feb 14 11:53:17 2002
@@ -344,8 +344,6 @@
     struct reiserfs_dir_entry de;
     INITIALIZE_PATH (path_to_entry);
 
-    reiserfs_check_lock_depth("lookup") ;
-
     if (dentry->d_name.len > REISERFS_MAX_NAME_LEN (dir->i_sb->s_blocksize))
 	return ERR_PTR(-ENAMETOOLONG);
 
