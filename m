Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269783AbRHDDp4>; Fri, 3 Aug 2001 23:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269786AbRHDDpq>; Fri, 3 Aug 2001 23:45:46 -0400
Received: from [208.49.167.57] ([208.49.167.57]:8274 "EHLO s6.mailbank.com")
	by vger.kernel.org with ESMTP id <S269785AbRHDDpd>;
	Fri, 3 Aug 2001 23:45:33 -0400
From: "Delbert Matlock" <Delbert@Matlock.com>
To: <linux-kernel@vger.kernel.org>
Subject: UMSDOS symlink fix
Date: Fri, 3 Aug 2001 23:46:00 -0400
Message-ID: <MPBBLFNMFLHJNJCJDPMCGEOLDMAA.Delbert@Matlock.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enclosed is a one line fix for symlinks under the UMSDOS filesystem.  Under
stock 2.4.7 (and 2.4.7-ac4), if you create a symlink the last letter of the
original file will be left off the link.  This will fix it.

Now, if I can just get the blasted thing to mount as root.

-- Delbert Matlock
-- Delbert@Matlock.com
-- http://delbert.matlock.com/




diff -u -r linux.orig/fs/umsdos/namei.c linux/fs/umsdos/namei.c
--- linux.orig/fs/umsdos/namei.c	Fri Feb  9 14:29:44 2001
+++ linux/fs/umsdos/namei.c	Fri Aug  3 21:01:42 2001
@@ -491,7 +491,7 @@
 		goto out;
 	}

-	len = strlen (symname);
+	len = strlen (symname) + 1;
 	ret = block_symlink(dentry->d_inode, symname, len);
 	if (ret < 0)
 		goto out_unlink;

