Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbRGTPI2>; Fri, 20 Jul 2001 11:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266999AbRGTPIS>; Fri, 20 Jul 2001 11:08:18 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:36090 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266997AbRGTPIE>; Fri, 20 Jul 2001 11:08:04 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107201507.f6KF7PE5017282@webber.adilger.int>
Subject: Re: 2.4.6: chattr / lsattr does not work on directories anymore!
In-Reply-To: <20010720134252.A758@rbg.informatik.tu-darmstadt.de>
 "from Marc-Jano Knopp at Jul 20, 2001 01:42:52 pm"
To: Marc-Jano Knopp <mjk@rbg.informatik.tu-darmstadt.de>
Date: Fri, 20 Jul 2001 09:07:25 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

You write:
> Since kernel 2.4.6, the commands 'lsattr' and 'chattr' do not work
> anymore when applied to directories:
> 
> As root:
> 
> # mkdir x
> # chattr +i x
> chattr: Inappropriate ioctl for device while reading flags on x
> # lsattr -d x
> lsattr: Inappropriate ioctl for device While reading flags on x

This is fixed in the most recent Linus and -ac kernels.  The fix is below.

Cheers, Andreas
==========================================================================
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
