Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbRFUW7W>; Thu, 21 Jun 2001 18:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265278AbRFUW7L>; Thu, 21 Jun 2001 18:59:11 -0400
Received: from hera.cwi.nl ([192.16.191.8]:29349 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262658AbRFUW7A>;
	Thu, 21 Jun 2001 18:59:00 -0400
Date: Fri, 22 Jun 2001 00:58:53 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106212258.AAA370096.aeb@vlet.cwi.nl>
To: jari.ruusu@pp.inet.fi, torvalds@transmeta.com
Subject: Re: loop device broken in 2.4.6-pre5
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Jari Ruusu <jari.ruusu@pp.inet.fi>

    File backed loop device on 4k block size ext2 filesystem:

    # dd if=/dev/zero of=file1 bs=1024 count=10
    10+0 records in
    10+0 records out
    # losetup /dev/loop0 file1
    # dd if=/dev/zero of=/dev/loop0 bs=1024 count=10 conv=notrunc
    dd: /dev/loop0: No space left on device
    9+0 records in
    8+0 records out
    # tune2fs -l /dev/hda1 2>&1| grep "Block size"
    Block size:               4096
    # uname -a
    Linux debian 2.4.6-pre5 #1 Thu Jun 21 14:27:25 EEST 2001 i686 unknown

    Stock 2.4.5 and 2.4.5-ac15 don't have this problem.

I am not sure there is an error here.

The default block size of a loop device is that of the underlying device.
There was a kernel bug that was recently fixed, where the block size
of a file backed loop device could be essentially random.
So, earlier you happened to get blocksize 1024, and you had room for
10 blocks of size 1024.
Now you have blocksize 4096, and you have room for 2 blocks of size 4096.
There are no fractional blocks at the end of a block device.

Andries
