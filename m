Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbTBNSHL>; Fri, 14 Feb 2003 13:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbTBNSHK>; Fri, 14 Feb 2003 13:07:10 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:30936 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S263256AbTBNSGi>; Fri, 14 Feb 2003 13:06:38 -0500
Message-ID: <3E4D327C.6050007@namesys.com>
Date: Fri, 14 Feb 2003 21:16:28 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [[BK][PATCH] 2.5 trivial reiserfs resizer patch (needed now that
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    mark_buffer_dirty requires buffer to be uptodate already)
Content-Type: multipart/mixed;
 boundary="------------050908040703060205000401"

This is a multi-part message in MIME format.
--------------050908040703060205000401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Hans


--------------050908040703060205000401
Content-Type: message/rfc822;
 name="Trivial resizer fix for 2.5, please forward to Linus."
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Trivial resizer fix for 2.5, please forward to Linus."

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 5381 invoked from network); 14 Feb 2003 08:46:38 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 14 Feb 2003 08:46:38 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 92208452F0A; Fri, 14 Feb 2003 11:46:36 +0300 (MSK)
Date: Fri, 14 Feb 2003 11:46:36 +0300
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: Trivial resizer fix for 2.5, please forward to Linus.
Message-ID: <20030214114636.F10351@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i

Hello!

   This trivial changeset fixes reiserfs resizer crash now that
   mark_buffer_dirty requires buffer to be uptodate already.
   Noticed by Alex Tomas <bzzz@tmi.comex.ru>

   Please pull from bk://namesys.com/bk/reiser3-linux-2.5-resizer-fix

Diffstat:
 resize.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Plain text patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1060  -> 1.1061 
#	fs/reiserfs/resize.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/14	green@angband.namesys.com	1.1061
# reiserfs: Move mark_buffer_uptodate in front of mark_buffer_dirty in resizer.
#   This is needed because mark_buffer_dirty is now checking if buffer is up to date.
#   Noticed by Alex Tomas <bzzz@tmi.comex.ru>
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/resize.c b/fs/reiserfs/resize.c
--- a/fs/reiserfs/resize.c	Fri Feb 14 11:39:28 2003
+++ b/fs/reiserfs/resize.c	Fri Feb 14 11:39:28 2003
@@ -118,8 +118,8 @@
 		memset(bitmap[i].bh->b_data, 0, sb_blocksize(sb));
 		reiserfs_test_and_set_le_bit(0, bitmap[i].bh->b_data);
 
-		mark_buffer_dirty(bitmap[i].bh) ;
 		set_buffer_uptodate(bitmap[i].bh);
+		mark_buffer_dirty(bitmap[i].bh) ;
 		sync_dirty_buffer(bitmap[i].bh);
 		// update bitmap_info stuff
 		bitmap[i].first_zero_hint=1;



--------------050908040703060205000401--

