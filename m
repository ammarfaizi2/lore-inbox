Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313173AbSDJOZU>; Wed, 10 Apr 2002 10:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313174AbSDJOZT>; Wed, 10 Apr 2002 10:25:19 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:40203 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313173AbSDJOZQ>; Wed, 10 Apr 2002 10:25:16 -0400
Message-ID: <3CB44A37.4090809@namesys.com>
Date: Wed, 10 Apr 2002 18:20:39 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS 5 of 13, please apply
Content-Type: multipart/mixed;
 boundary="------------000003090201090809070001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000003090201090809070001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------000003090201090809070001
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 5 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 5 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13250 invoked from network); 10 Apr 2002 11:21:50 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:50 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id D41684D1B33; Wed, 10 Apr 2002 15:21:50 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:50 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 5 of 13
Message-ID: <20020410152150.A20881@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


This patch is to add forgotten metadata journaling for a case when
we free blocks after tail conversion failures. Found and fixed by Chris Mason

--- linux-2.5.8-pre2/fs/reiserfs/inode.c.orig	Mon Apr  8 14:09:34 2002
+++ linux-2.5.8-pre2/fs/reiserfs/inode.c	Mon Apr  8 14:09:57 2002
@@ -745,8 +745,12 @@
 		if (retval) {
 		    if ( retval != -ENOSPC )
 			printk("clm-6004: convert tail failed inode %lu, error %d\n", inode->i_ino, retval) ;
-		    if (allocated_block_nr)
+		    if (allocated_block_nr) {
+			/* the bitmap, the super, and the stat data == 3 */
+			journal_begin(&th, inode->i_sb, 3) ;
 			reiserfs_free_block (&th, allocated_block_nr);
+			transaction_started = 1 ;
+		    }
 		    goto failure ;
 		}
 		goto research ;



--------------000003090201090809070001--

