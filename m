Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267551AbRGMVkX>; Fri, 13 Jul 2001 17:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267552AbRGMVkN>; Fri, 13 Jul 2001 17:40:13 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:12028 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267551AbRGMVkG>; Fri, 13 Jul 2001 17:40:06 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107132139.f6DLdxYC014544@webber.adilger.int>
Subject: Re: ioctl bug?
In-Reply-To: <Pine.LNX.4.33.0107131139450.12456-100000@gruel.uchicago.edu>
 "from Gary Lyons at Jul 13, 2001 03:43:15 pm"
To: lyons@pobox.com
Date: Fri, 13 Jul 2001 15:39:59 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gary writes:
> I think I have found a bug in the kernel.
> 
> starting with 2.4.5ac23 and continuing through both 2.4.6 and
> 2.v.6-ac2 Whenever I try to do a lsattr or chattr on a directory
> I get:
> 
> 	"Inappropriate ioctl for device While reading flags"

Yet another case of Linux pro-active bug-fixing.  I have already sent
a patch for this to Linus and Alan.  It seems I CC'd ext2-devel, but
not linux-kernel.

Here is the patch again.  It was likely caused by Al Viro's major
overhaul of the ext2 directory code, to move it into the page cache.

Cheers, Andreas
===========================================================================
--- linux-2.4.6.orig/fs/ext2/dir.c	Thu Jun 28 14:28:24 2001
+++ linux-2.4.6-aed/fs/ext2/dir.c	Tue Jul 10 22:59:12 2001
@@ -576,5 +576,6 @@
 struct file_operations ext2_dir_operations = {
 	read:		generic_read_dir,
 	readdir:	ext2_readdir,
+	ioctl:		ext2_ioctl,
 	fsync:		ext2_sync_file,
 };
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
