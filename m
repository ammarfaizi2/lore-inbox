Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTECWCo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 18:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTECWCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 18:02:43 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:31943 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263451AbTECWBb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 18:01:31 -0400
Message-ID: <3EB43F20.6020400@namesys.com>
Date: Sun, 04 May 2003 02:13:52 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK] [2.4] reiserfs: Enable tail packing]
Content-Type: multipart/mixed;
 boundary="------------010309040300070907010201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010309040300070907010201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Hans


--------------010309040300070907010201
Content-Type: message/rfc822;
 name="[2.4] reiserfs: Enable tail packing"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[2.4] reiserfs: Enable tail packing"

Return-Path: <green@angband.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24445 invoked from network); 3 May 2003 12:46:47 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 3 May 2003 12:46:47 -0000
Received: by angband.namesys.com (Postfix, from userid 521)
	id 5F9F51CE973; Sat,  3 May 2003 16:46:47 +0400 (MSD)
Date: Sat, 3 May 2003 16:46:47 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [2.4] reiserfs: Enable tail packing
Message-ID: <20030503124647.GB21210@namesys.com>
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
--- a/fs/reiserfs/inode.c	Sat May  3 15:58:39 2003
+++ b/fs/reiserfs/inode.c	Sat May  3 15:58:39 2003
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



--------------010309040300070907010201--

