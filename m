Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272478AbTGaNhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272479AbTGaNhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:37:11 -0400
Received: from angband.namesys.com ([212.16.7.85]:26046 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S272478AbTGaNhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:37:09 -0400
Date: Thu, 31 Jul 2003 17:37:07 +0400
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reiserfs: fix savelinks on bigendian platforms
Message-ID: <20030731133707.GM14081@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    This small patch fixes a savelinks problem on bigendian platforms, where
    savelinks were not working at all because of incorrect cpu->disk endianness conversion.
    Savelinks are used on reiserfs to remember "truncate" and "unlink" events
    so that if crash happens in the middle of truncate/unlink, we do not endup with
    lost or half truncated files.

    Please pull from bk://namesys.com/bk/reiser3-linux-2.4-savelink-bigendian-fix

Diffstat:
 super.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1048  -> 1.1049 
#	 fs/reiserfs/super.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/31	green@angband.namesys.com	1.1049
# reiserfs: fix savelinks for bigendian arches.
#    Remove unneeded cpu->disk order conversion for savelink data.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Thu Jul 31 17:24:46 2003
+++ b/fs/reiserfs/super.c	Thu Jul 31 17:24:46 2003
@@ -284,7 +284,7 @@
     }
 
     /* body of "save" link */
-    link = cpu_to_le32 (INODE_PKEY (inode)->k_dir_id);
+    link = INODE_PKEY (inode)->k_dir_id;
 
     /* put "save" link inot tree */
     retval = reiserfs_insert_item (th, &path, &key, &ih, (char *)&link);
