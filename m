Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132686AbREHEqf>; Tue, 8 May 2001 00:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135711AbREHEqY>; Tue, 8 May 2001 00:46:24 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:42994 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132686AbREHEqM>; Tue, 8 May 2001 00:46:12 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105080445.f484jxL6000663@webber.adilger.int>
Subject: Re: EXT2-fs error with 2.4.4 (using CVS)
In-Reply-To: <20010508011610.P15636@pervalidus> =?US-ASCII?Q?from_Fr=E9d=E9ric_L=2E_W=2E_Meunier_at_May_8=2C_2001_01=3A16=3A?=
 =?US-ASCII?Q?10_am?=
To: =?US-ASCII?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.net>
Date: Mon, 7 May 2001 22:45:59 -0600 (MDT)
CC: Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Federic Meunier writes:
> ==> /var/log/syslog <==
> May  8 00:25:52 pervalidus kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in
> directory #162813: directory entry across blocks - offset=92, inode=451111, rec_len=16404,
> name_len=9
> May  8 00:25:52 pervalidus kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in
> directory #162813: directory entry across blocks - offset=92, inode=451111, rec_len=16404,
> name_len=9
> 
> When CVS finished, I received the following error:
> 
> May  8 01:11:29 pervalidus kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in
> directory #162813: directory entry across blocks - offset=92, inode=451111, rec_len=16404,
> name_len=9
> May  8 01:11:29 pervalidus kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in
> directory #162813: directory entry across blocks - offset=92, inode=451111, rec_len=16404,
> name_len=9

Since it is always the same inode, I would say it is corrupt.  You need to
run e2fsck to fix it.  It looks like it is a single-bit error on the disk.
The rec_len=16404=0x4014.  One (of many possible) valid rec_len would be
0x14=20.  To be valid we need name_len <= rec_len <= block size.

Chances are, when you run e2fsck, it will fix this dirent, but the rest of
the directory entries in that block will be moved to lost+found.

I would suspect a hardware problem, to create a single-bit error (if it
is such).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
