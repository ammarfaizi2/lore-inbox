Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWFTSZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWFTSZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 14:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWFTSZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 14:25:25 -0400
Received: from ns1.suse.de ([195.135.220.2]:19136 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750793AbWFTSZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 14:25:25 -0400
Message-ID: <44983D89.7040400@suse.com>
Date: Tue, 20 Jun 2006 14:25:13 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] reiserfs: use generic_file_open for open() checks
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

 The other common disk-based file systems (I checked ext[23], xfs, jfs)
 check to ensure that opens of files > 2 GB fail unless O_LARGEFILE
 is specified. They check via generic_file_open or their own open routine.

 ReiserFS doesn't have an f_op->open defined, and as such, it's possible to
 open files > 2 GB without O_LARGEFILE.

 This patch adds the f_op->open member to conform with the expected
 behavior.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
- --

 fs/reiserfs/file.c |    1 +
 1 file changed, 1 insertion(+)

diff -ruNpX dontdiff linux-2.6.17-rc5.orig/fs/reiserfs/file.c linux-2.6.17-rc5.reiser/fs/reiserfs/file.c
- --- linux-2.6.17-rc5.orig/fs/reiserfs/file.c	2006-06-05 10:37:26.000000000 -0400
+++ linux-2.6.17-rc5.reiser/fs/reiserfs/file.c	2006-06-07 10:09:24.000000000 -0400
@@ -1571,6 +1571,7 @@ const struct file_operations reiserfs_fi
 	.write = reiserfs_file_write,
 	.ioctl = reiserfs_ioctl,
 	.mmap = generic_file_mmap,
+	.open = generic_file_open,
 	.release = reiserfs_file_release,
 	.fsync = reiserfs_sync_file,
 	.sendfile = generic_file_sendfile,

- -- 
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEmD2JLPWxlyuTD7IRAgAEAJ4mdjOTfjYnxkerzBvERvOaDubQOQCfcQRK
IWtRqpF+mkhZfbjtnkGxvPA=
=/8oU
-----END PGP SIGNATURE-----
