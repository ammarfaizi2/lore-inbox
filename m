Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbRGDVOA>; Wed, 4 Jul 2001 17:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266208AbRGDVNv>; Wed, 4 Jul 2001 17:13:51 -0400
Received: from femail16.sdc1.sfba.home.com ([24.0.95.143]:56062 "EHLO
	femail16.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S266200AbRGDVNk>; Wed, 4 Jul 2001 17:13:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Swanson <swansma@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: loop device corruption in 2.4.6
Date: Wed, 4 Jul 2001 17:14:02 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01070417140200.03178@test.home2.mark>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get repeatable errors with 2.4.6 patched with the international encryption 
patch patch-int-2.4.3.1.bz2 when building loop device filesystems on top of 
Reiserfs.

All I have to do is:

1. dd if=/dev/zero of=testfs bs=1024 count=100000
2. losetup -e aes /dev/loop0 ./testfs
3. mke2fs /dev/loop0
4. mount /dev/loop0 ./test
5. cd test ; touch m ; cd ..
6. umount ./test
7. losetup -d /dev/loop0
8. losetup -e aes /dev/loop0 ./testfs
9. e2fsck /dev/loop0  *** All heck breaks loose.

The thing is, I can still mount previously created AES loopback filesystems 
but I can't e2fsck them. Well, if I do I get the following:

e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Group descriptors look bad... trying backup blocks...
Inode count in superblock is 27112, should be 25064.
Fix? yes

Block bitmap for group 0 is not in group.  (block 1569951131)
Relocate? yes

Inode bitmap for group 0 is not in group.  (block 1258458187)
Relocate? yes

Inode table for group 0 is not in group.  (block 865539952)
WARNING: SEVERE DATA LOSS POSSIBLE.
Relocate?




