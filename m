Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288173AbSAHRGG>; Tue, 8 Jan 2002 12:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288177AbSAHRF4>; Tue, 8 Jan 2002 12:05:56 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:52487 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288173AbSAHRFx>; Tue, 8 Jan 2002 12:05:53 -0500
Date: Tue, 8 Jan 2002 20:05:49 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] problems with very-long symlinks eliminated in reiserfs
Message-ID: <20020108200549.A5051@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    This patch fixes following problem:
    Symlink-body length check was made against incorrect value, allowing for too long nodes to be
    inserted into tree. This might lead to obscure warnings in some cases.

    Please apply.

Bye,
    Oleg

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="long_symlinks_fix.diff"

--- linux/fs/reiserfs/namei.c.orig	Tue Jan  8 15:39:24 2002
+++ linux/fs/reiserfs/namei.c	Tue Jan  8 15:39:46 2002
@@ -876,7 +876,7 @@
     }
 
     item_len = ROUND_UP (strlen (symname));
-    if (item_len > MAX_ITEM_LEN (dir->i_sb->s_blocksize)) {
+    if (item_len > MAX_DIRECT_ITEM_LEN (dir->i_sb->s_blocksize)) {
 	iput(inode) ;
 	return -ENAMETOOLONG;
     }

--/9DWx/yDrRhgMJTb--
