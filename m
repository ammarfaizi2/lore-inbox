Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSFEE15>; Wed, 5 Jun 2002 00:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317546AbSFEE14>; Wed, 5 Jun 2002 00:27:56 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:31395 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S314584AbSFEE14>;
	Wed, 5 Jun 2002 00:27:56 -0400
Date: Wed, 5 Jun 2002 14:27:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
        Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] fs/locks.c use list_del_init
Message-Id: <20020605142721.2d15f147.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Trivial part of a patch by Matthew Wilcox.  Please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.20/fs/locks.c 2.5.20-sfr.1/fs/locks.c
--- 2.5.20/fs/locks.c	Fri Mar  8 14:37:19 2002
+++ 2.5.20-sfr.1/fs/locks.c	Wed Jun  5 14:23:33 2002
@@ -397,10 +397,8 @@
  */
 static void locks_delete_block(struct file_lock *waiter)
 {
-	list_del(&waiter->fl_block);
-	INIT_LIST_HEAD(&waiter->fl_block);
-	list_del(&waiter->fl_link);
-	INIT_LIST_HEAD(&waiter->fl_link);
+	list_del_init(&waiter->fl_block);
+	list_del_init(&waiter->fl_link);
 	waiter->fl_next = NULL;
 }
 
