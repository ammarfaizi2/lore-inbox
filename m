Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262827AbSJaQFs>; Thu, 31 Oct 2002 11:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262841AbSJaQEl>; Thu, 31 Oct 2002 11:04:41 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21000 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262838AbSJaQEY>; Thu, 31 Oct 2002 11:04:24 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.21561.25201.754130@laputa.namesys.com>
Date: Thu, 31 Oct 2002 19:03:05 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: [PATCH]: reiser4 [1/8] export fsync_super()
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Drdoom-Fodder: drdoom passwd crash satan CERT security
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

    Following patch exports fsync_super() function. fsync_super() is
    required for reiser4, because during umount we want to perform some
    tasks after ->writepage has been called on all pages dirtied through
    mmap (that is, after fsync_super()), but before inodes
    destruction. As a result, reiser4 cannot use kill_block_super() and
    has to call fsync_super() explicitly.

Please apply.
Nikita.
--- linus-bk-2.5/fs/buffer.c	Thu Oct 17 03:01:42 2002
+++ linux-2.5-reiser4/fs/buffer.c	Mon Oct 21 13:43:49 2002
@@ -224,6 +224,7 @@ int fsync_super(struct super_block *sb)
 
 	return sync_blockdev(sb->s_bdev);
 }
+EXPORT_SYMBOL(fsync_super);
 
 /*
  * Write out and wait upon all dirty data associated with this

