Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129793AbRBRVMJ>; Sun, 18 Feb 2001 16:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbRBRVMA>; Sun, 18 Feb 2001 16:12:00 -0500
Received: from hera.cwi.nl ([192.16.191.8]:28392 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129793AbRBRVLl>;
	Sun, 18 Feb 2001 16:11:41 -0500
Date: Sun, 18 Feb 2001 22:11:36 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102182111.WAA170825.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, axboe@suse.de
Subject: Re: [PROBLEM] 2.4.1 can't mount ext2 CD-ROM
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, zzed@cyberdude.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >     You are defeating the entire purpose of having a hardware sector
    >     size independently from the software block size. And 2kB is a
    >     valid guess, apart from the drives that do 512 byte transfers too
    >     2kB is really the smallest transfer we can do.
    > 
    > : And 2kB is a valid guess
    > 
    > Strange. The twelve or so CD readers I have here are all
    > able to read 512-byte sectors. I am quite willing to believe

    I think most Plextor and Yamaha do, but it's not guaranteed to
    be supported. And it definitely won't for ATAPI with ide-scsi.

Strange. I just used ATAPI with ide-scsi as test. It works.

    Did you verify that changing block size works? Just curious.

Maybe you misunderstand.
In reality no blocksize is changed.

Setting hardsect_size to 2048 means: this hardware is unable
to use smaller blocks, give an error to whoever asks for
something smaller.

Not setting hardsect_size at all means: I have no idea what this
hardware can do. Now it is up to the user. If the user tries
something the hardware cannot do, she will get EIO.
Limiting the user in advance is a bad idea.

But yes, I found an old CDROM with a blocksize of 1024,
which was rejected by 2.4.1 and accepted by 2.4.1 after
removing al mention of sr_hardsizes from sr.c.

    > is a good idea today. No padding reads involved.
    > If you disagree, please go slowly and state very explicitly
    > why you think I should be unable to mount ext2 filesystems with
    > a block size smaller than 2048 on my SCSI CD drive.

    I don't think you should be unable to, of course we would want to
    support 1kB ext2 and other file systems that want to change the block
    size. We are just disagreeing on how to do it. I don't think counting
    on being able to change the block size of a device at will always
    be reliable.

It is not clear to me what you mean by "changing the block size".
What problems do you see?
Don't forget that 2.2 does not have sr_hardsizes, so all problems
you see should be present in 2.2.

Andries
