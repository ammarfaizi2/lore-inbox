Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313165AbSDJOY1>; Wed, 10 Apr 2002 10:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313172AbSDJOY0>; Wed, 10 Apr 2002 10:24:26 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:38667 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313165AbSDJOYY>; Wed, 10 Apr 2002 10:24:24 -0400
Message-ID: <3CB44A01.2000900@namesys.com>
Date: Wed, 10 Apr 2002 18:19:45 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS 4 of 13, please apply all 13
Content-Type: multipart/mixed;
 boundary="------------010509070504010004020407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010509070504010004020407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------010509070504010004020407
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 4 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 4 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13245 invoked from network); 10 Apr 2002 11:21:50 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:50 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id C8D884D1B34; Wed, 10 Apr 2002 15:21:50 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:50 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 4 of 13
Message-ID: <20020410152150.A20876@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


This patch is to fix a case where flag was not set at inode-read time which
prevented 32bit uid/gid to work correctly.

--- linux-2.5.8-pre2/fs/reiserfs/inode.c.orig	Mon Apr  8 14:08:28 2002
+++ linux-2.5.8-pre2/fs/reiserfs/inode.c	Mon Apr  8 14:09:34 2002
@@ -935,9 +935,6 @@
 	// (directories and symlinks)
 	struct stat_data * sd = (struct stat_data *)B_I_PITEM (bh, ih);
 
-	/* both old and new directories have old keys */
-	//version = (S_ISDIR (sd->sd_mode) ? ITEM_VERSION_1 : ITEM_VERSION_2);
-
 	inode->i_mode   = sd_v2_mode(sd);
 	inode->i_nlink  = sd_v2_nlink(sd);
 	inode->i_uid    = sd_v2_uid(sd);
@@ -958,6 +955,7 @@
 	else
 	    set_inode_item_key_version (inode, KEY_FORMAT_3_6);
 	REISERFS_I(inode)->i_first_direct_byte = 0;
+	set_inode_sd_version (inode, STAT_DATA_V2);
     }
 
     pathrelse (path);



--------------010509070504010004020407--

