Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRFZKmL>; Tue, 26 Jun 2001 06:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264286AbRFZKmB>; Tue, 26 Jun 2001 06:42:01 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12958 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264279AbRFZKl4>;
	Tue, 26 Jun 2001 06:41:56 -0400
Date: Tue, 26 Jun 2001 12:41:51 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106261041.MAA454888.aeb@vlet.cwi.nl>
To: jari.ruusu@pp.inet.fi, torvalds@transmeta.com
Subject: Re: loop device broken in 2.4.6-pre5
Cc: Andries.Brouwer@cwi.nl, R.E.Wolff@BitWizard.nl, axboe@suse.de,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From jari.ruusu@pp.inet.fi Tue Jun 26 10:20:51 2001

    This patch fixes the problem. Please consider applying.

    --- linux-2.4.6-pre5/drivers/block/loop.c    Sat Jun 23 07:52:39 2001
    +++ linux/drivers/block/loop.c    Tue Jun 26 09:21:47 2001
    @@ -653,7 +653,7 @@
         bs = 0;
         if (blksize_size[MAJOR(lo_device)])
             bs = blksize_size[MAJOR(lo_device)][MINOR(lo_device)];
    -    if (!bs)
    +    if (!bs || S_ISREG(inode->i_mode))
             bs = BLOCK_SIZE;
     
         set_blocksize(dev, bs);

But why 1024? Next week your neighbour comes and has a file-backed
loop device with an odd number of 512-byte sectors.
If you want a guarantee, then I suppose one should pick 512.
(Or make the set blocksize ioctl also work on loop devices.)

Andries
