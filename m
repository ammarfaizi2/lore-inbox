Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSHIQff>; Fri, 9 Aug 2002 12:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSHIQfe>; Fri, 9 Aug 2002 12:35:34 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:52353 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315119AbSHIQeZ>;
	Fri, 9 Aug 2002 12:34:25 -0400
Date: Fri, 9 Aug 2002 20:36:39 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200208091636.g79GadQk007883@bitshadow.namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [BK] [PATCH] reiserfs changeset 4 of 7 to include into 2.4 tree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   This changeset fixes a problem where certain items of 3.5 format
   on converted to v3.6 filesystems might get wrong alignment.
   You can pull it from bk://thebsh.namesys.com/bk/reiser3-linux-2.4

Diffstat:

 namei.c           |    2 +-
 tail_conversion.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.684   -> 1.685  
#	 fs/reiserfs/namei.c	1.21    -> 1.22   
#	fs/reiserfs/tail_conversion.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/06	green@angband.namesys.com	1.685
# tail_conversion.c, namei.c:
#   fix a problem where 3.5 items might get wrong alignment on converted filesystems
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Tue Aug  6 10:38:12 2002
+++ b/fs/reiserfs/namei.c	Tue Aug  6 10:38:12 2002
@@ -379,7 +379,7 @@
     } else
 	buffer = small_buf;
 
-    paste_size = (old_format_only (dir->i_sb)) ? (DEH_SIZE + namelen) : buflen;
+    paste_size = (get_inode_sd_version (dir) == STAT_DATA_V1) ? (DEH_SIZE + namelen) : buflen;
 
     /* fill buffer : directory entry head, name[, dir objectid | , stat data | ,stat data, dir objectid ] */
     deh = (struct reiserfs_de_head *)buffer;
diff -Nru a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
--- a/fs/reiserfs/tail_conversion.c	Tue Aug  6 10:38:12 2002
+++ b/fs/reiserfs/tail_conversion.c	Tue Aug  6 10:38:12 2002
@@ -213,7 +213,7 @@
     copy_item_head (&s_ih, PATH_PITEM_HEAD(p_s_path));
 
     tail_len = (n_new_file_size & (n_block_size - 1));
-    if (!old_format_only (p_s_sb))
+    if (get_inode_sd_version (p_s_inode) == STAT_DATA_V2)
 	round_tail_len = ROUND_UP (tail_len);
     else
 	round_tail_len = tail_len;
