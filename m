Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268112AbTCFOKQ>; Thu, 6 Mar 2003 09:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268130AbTCFOKQ>; Thu, 6 Mar 2003 09:10:16 -0500
Received: from comtv.ru ([217.10.32.4]:56459 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S268112AbTCFOKO>;
	Thu, 6 Mar 2003 09:10:14 -0500
To: linux-kernel@vger.kernel.org
Cc: dan carpenter <error27@email.com>, Andrew Morton <akpm@digeo.com>,
       ext2-devel@lists.sourceforge.net
Subject: [PATCH] minor memleak in ext3 (catched by smatch)
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 06 Mar 2003 17:14:15 +0300
Message-ID: <m3n0k81t1k.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This minor memory leak has been catched by smatch.
Thanks to Dan Carpenter!



--- linux/fs/ext3/super.c	Mon Feb 24 17:47:45 2003
+++ super.c	Thu Mar  6 17:09:31 2003
@@ -1154,7 +1154,7 @@
 		if (!bh) {
 			printk(KERN_ERR 
 			       "EXT3-fs: Can't read superblock on 2nd try.\n");
-			return -EINVAL;
+			goto out_fail;
 		}
 		es = (struct ext3_super_block *)(((char *)bh->b_data) + offset);
 		sbi->s_es = es;

