Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280878AbRKGRo5>; Wed, 7 Nov 2001 12:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280877AbRKGRoP>; Wed, 7 Nov 2001 12:44:15 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:50587 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S280875AbRKGRoG>; Wed, 7 Nov 2001 12:44:06 -0500
Date: Wed, 7 Nov 2001 18:47:10 +0100
From: Peter Seiderer <Peter.Seiderer@ciselant.de>
To: linux-kernel@vger.kernel.org
Subject: What is the difference between 'login: root' and 'su -' ?
Message-ID: <20011107184710.A1410@zodiak.ecademix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
tried today to mkfs.ext2 a partition of my disk and detected there is
a little difference between 'login: root' and 'su -'.

First I tried it this way:

	Welcome to SuSE Linux 7.0 (i386) - Kernel 2.4.14 (tty1).

	zodiak login: seiderer
	Password:
	seiderer@zodiak:~ > su -
	Password:
	zodiak:~ #
	zodiak:~ # mkfs.ext2 /dev/hdc4
	mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
	Filesystem label=
	OS type: Linux
	Block size=4096 (log=2)
	Fragment size=4096 (log=2)
	716672 inodes, 1432116 blocks
	71605 blocks (5.00%) reserved for the super user
	First data block=0
	44 block groups
	32768 blocks per group, 32768 fragments per group
	16288 inodes per group
	Superblock backups stored on blocks:
	        32768, 98304, 163840, 229376, 294912, 819200, 884736

	Writing inode tables: 16/44File size limit exceeded

strace showed that write returned wit EFBIG and the process ended with SIGXFSZ:

	write(1, "\10\10\10\10\10", 5)          = 5
	write(1, "16/44", 5)                    = 5
	_llseek(4, 18446744071562084352, [2147500032], SEEK_SET) = 0
	write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) = -1 EFBIG (File too large)
	--- SIGXFSZ (File size limit exceeded) ---
	+++ killed by SIGXFSZ +++

When login in directly from the console as root everything went right:
	Welcome to SuSE Linux 7.0 (i386) - Kernel 2.4.14 (tty1).

	zodiak login: root
	Password:
	zodiak:~ # mkfs.ext2 /dev/hdc4
	mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
	Filesystem label=
	OS type: Linux
	Block size=4096 (log=2)
	Fragment size=4096 (log=2)
	716672 inodes, 1432116 blocks
	71605 blocks (5.00%) reserved for the super user
	First data block=0
	44 block groups
	32768 blocks per group, 32768 fragments per group
	16288 inodes per group
	Superblock backups stored on blocks:
	        32768, 98304, 163840, 229376, 294912, 819200, 884736

	Writing inode tables: done
	Writing superblocks and filesystem accounting information: done
	zodiak:~ #

The RLIMIT_FSIZE showed in both cases the same values:
getrlimit(RLIMIT_FSIZE) rlim_cur: 2147483647 rlim_max: 2147483647

Can anybody point me out what went wrong? Is it a kernel limit?

Peter

