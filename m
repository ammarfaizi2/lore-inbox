Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319230AbSIKQ7X>; Wed, 11 Sep 2002 12:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319231AbSIKQ7X>; Wed, 11 Sep 2002 12:59:23 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:17675 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S319230AbSIKQ7U>; Wed, 11 Sep 2002 12:59:20 -0400
Message-ID: <3D7F7783.6030804@namesys.com>
Date: Wed, 11 Sep 2002 21:04:03 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: [BK] ReiserFS file write bug fix for 2.4
Content-Type: multipart/mixed;
 boundary="------------060202000000080206090007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060202000000080206090007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Well, at least getting the new file write code into pre6 found this bug 
for us....  please apply.

--------------060202000000080206090007
Content-Type: message/rfc822;
 name="reiserfs_file_write bugfix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiserfs_file_write bugfix"

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 27964 invoked from network); 11 Sep 2002 14:58:29 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 11 Sep 2002 14:58:29 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 755951870F8; Wed, 11 Sep 2002 18:58:29 +0400 (MSD)
Date: Wed, 11 Sep 2002 18:58:29 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: reiserfs_file_write bugfix
Message-ID: <20020911185829.A11962@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hello!

   You probably want to ask Marcelo if he is going to leave reiserfs_file_write
   stuff in kernel. If he is going to do that, then attached fix should be
   applied. Otherwise it can be ignored, of course.

Bye,
    Oleg

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=mail3

Hello!

  This fixes a buglet in new reiserfs_file_write() that escaped out previous
  tests. Problem only occurs on non-empty appended (opened with O_APPEND)
  files that are being written with more than 128k bytes data at a time
  (write syscall). Fix itself is trivial.

Diffstat:
 file.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.632   -> 1.633  
#	  fs/reiserfs/file.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/11	green@angband.namesys.com	1.633
# reiserfs: Fix a case where non empty files written to with O_APPEND set and amount of bytes to write bigger than 128k (or up to 4k less for non page aligned writes) can get their content damaged.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/file.c b/fs/reiserfs/file.c
--- a/fs/reiserfs/file.c	Wed Sep 11 18:50:13 2002
+++ b/fs/reiserfs/file.c	Wed Sep 11 18:50:14 2002
@@ -1189,7 +1189,7 @@
 
 	already_written += write_bytes;
 	buf += write_bytes;
-	pos = *ppos += write_bytes;
+	*ppos = pos += write_bytes;
 	count -= write_bytes;
     }
 

--lrZ03NoBR/3+SXJZ--



--------------060202000000080206090007--

