Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTELTVy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTELTVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:21:54 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:16583 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262577AbTELTVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:21:46 -0400
Message-ID: <3EBFF741.3070505@namesys.com>
Date: Mon, 12 May 2003 23:34:25 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK][2.4] reiserfs: Enable tail packing, resend
Content-Type: multipart/mixed;
 boundary="------------050704030705000207010400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050704030705000207010400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Hans


--------------050704030705000207010400
Content-Type: message/rfc822;
 name="[2.4] reiserfs: Enable tail packing, resend"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[2.4] reiserfs: Enable tail packing, resend"

Return-Path: <green@angband.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 926 invoked from network); 12 May 2003 14:02:32 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 12 May 2003 14:02:32 -0000
Received: by angband.namesys.com (Postfix, from userid 521)
	id 0AABD571F9C; Mon, 12 May 2003 18:02:32 +0400 (MSD)
Date: Mon, 12 May 2003 18:02:32 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [2.4] reiserfs: Enable tail packing, resend
Message-ID: <20030512140232.GD4165@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i

Hello!

    This patch restores the tail packing fucntionality that was
    mistakenly disabled by previously accepted directio fix patch.

    Please pull from bk://namesys.com/bk/reiser3-linux-2.4-tailfix

Diffstat:
 inode.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Plain text patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1158  -> 1.1159 
#	 fs/reiserfs/inode.c	1.42    -> 1.43   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/03	green@angband.namesys.com	1.1159
# reiserfs: One of the O_DIRECT fixes disabled tail packing by mistake. Enable it again.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Mon May 12 17:47:44 2003
+++ b/fs/reiserfs/inode.c	Mon May 12 17:47:44 2003
@@ -2085,8 +2085,8 @@
 	/* If the file have grown beyond the border where it
 	   can have a tail, unmark it as needing a tail
 	   packing */
-	if ( (have_large_tails (inode->i_sb) && inode->i_size < block_size (inode)*4) ||
-	     (have_small_tails (inode->i_sb) && inode->i_size < block_size(inode)) )
+	if ( (have_large_tails (inode->i_sb) && inode->i_size > block_size (inode)*4) ||
+	     (have_small_tails (inode->i_sb) && inode->i_size > block_size(inode)) )
 	    inode->u.reiserfs_i.i_flags &= ~i_pack_on_close_mask;
 
 	journal_begin(&th, inode->i_sb, 1) ;



--------------050704030705000207010400--

