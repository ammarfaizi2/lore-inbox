Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129689AbRBRTe1>; Sun, 18 Feb 2001 14:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131006AbRBRTeR>; Sun, 18 Feb 2001 14:34:17 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38115 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129689AbRBRTeH>;
	Sun, 18 Feb 2001 14:34:07 -0500
Date: Sun, 18 Feb 2001 20:34:03 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102181934.UAA168081.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, axboe@suse.de
Subject: Re: [PROBLEM] 2.4.1 can't mount ext2 CD-ROM
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, zzed@cyberdude.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    > A value of hardsect_size[] means: this is the smallest size
    > the hardware can work with. It is therefore a serious mistake
    > just to come with "a good guess". This value is used only

    You are defeating the entire purpose of having a hardware sector
    size independently from the software block size. And 2kB is a
    valid guess, apart from the drives that do 512 byte transfers too
    2kB is really the smallest transfer we can do.

: And 2kB is a valid guess

Strange. The twelve or so CD readers I have here are all
able to read 512-byte sectors. I am quite willing to believe
that hardware exists that is unable to, but it is a bad idea
to refuse to mount filesystems just because of some "good guess"
that was not so good at all.

    > to reject impossible sizes, and everywhere the kernel accepts 0
    > meaning "don't know".

[Minor correction to my previous note:
	hardsect_size[MAJOR_NR] = NULL;
is fine, putting 512 is fine as well, but putting 0 does not
work because of the get_hardsect_size() that doesnt check for 0.]

    So put 0 and sure anyone can submit I/O on the size that they want.
    Now the driver has to support padding reads, or gathering data to do
    a complete block write. This is silly. Sr should support 512b transfers
    just fine, but only because I added the necessary _hacks_ to support
    it. sd doesn't right now for instance.

Please calm down. Removing this sr_hardsizes nonsense
is a good idea today. No padding reads involved.
If you disagree, please go slowly and state very explicitly
why you think I should be unable to mount ext2 filesystems with
a block size smaller than 2048 on my SCSI CD drive.

Andries
