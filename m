Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313170AbSDJOVG>; Wed, 10 Apr 2002 10:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313172AbSDJOVF>; Wed, 10 Apr 2002 10:21:05 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:30731 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313170AbSDJOVE>; Wed, 10 Apr 2002 10:21:04 -0400
Message-ID: <3CB44936.8000102@namesys.com>
Date: Wed, 10 Apr 2002 18:16:22 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH]  ReiserFS 2 of 13, please apply
Content-Type: multipart/mixed;
 boundary="------------000005060608030103080904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000005060608030103080904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------000005060608030103080904
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 2 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 2 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13235 invoked from network); 10 Apr 2002 11:21:50 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:50 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id AED3F4D1B34; Wed, 10 Apr 2002 15:21:50 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:50 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 2 of 13
Message-ID: <20020410152150.A20865@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


This patch is to fix a lookup problem on bigendian platforms

--- linux-2.5.8-pre2.orig/fs/reiserfs/inode.c Mon, 11 Feb 2002 12:21:42 -0500
+++ linux-2.5.8-pre2/fs/reiserfs/inode.c Mon, 18 Feb 2002 19:43:55 -0500
@@ -1207,7 +1211,8 @@
     struct reiserfs_iget4_args *args;
 
     args = opaque;
-    return INODE_PKEY( inode ) -> k_dir_id == args -> objectid;
+    /* args is already in CPU order */
+    return le32_to_cpu(INODE_PKEY(inode)->k_dir_id) == args -> objectid;
 }
 
 struct inode * reiserfs_iget (struct super_block * s, const struct cpu_key * key)




--------------000005060608030103080904--

