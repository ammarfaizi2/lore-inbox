Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266788AbRGKVYy>; Wed, 11 Jul 2001 17:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266786AbRGKVYo>; Wed, 11 Jul 2001 17:24:44 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:37623 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266785AbRGKVY3>; Wed, 11 Jul 2001 17:24:29 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107112122.f6BLM9Ik009658@webber.adilger.int>
Subject: [PATCH] minor fixup of quota checking
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        mvw@planets.elm.net
Date: Wed, 11 Jul 2001 15:22:09 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes (I think) an error in the boolean logic for
checking if a filesystem can support quotas.  Since quotas use both
read and write file operations, we need both functions available, but
the current test only fails if both read and write are NOT available.

Cheers, Andreas
==========================================================================
diff -ru linux-2.4.6.orig/fs/dquot.c linux-2.4.6-aed/fs/dquot.c
--- linux-2.4.6.orig/fs/dquot.c	Thu Jun 28 14:28:23 2001
+++ linux-2.4.6-aed/fs/dquot.c	Thu Jun 28 14:27:23 2001
@@ -1467,7 +1467,7 @@
 	if (IS_ERR(f))
 		goto out_lock;
 	error = -EIO;
-	if (!f->f_op || (!f->f_op->read && !f->f_op->write))
+	if (!f->f_op || !f->f_op->read || !f->f_op->write)
 		goto out_f;
 	inode = f->f_dentry->d_inode;
 	error = -EACCES;
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
