Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbRFZNbm>; Tue, 26 Jun 2001 09:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbRFZNbc>; Tue, 26 Jun 2001 09:31:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:48587 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264939AbRFZNba>;
	Tue, 26 Jun 2001 09:31:30 -0400
Date: Tue, 26 Jun 2001 15:31:25 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106261331.PAA454623.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, R.E.Wolff@BitWizard.nl
Subject: Re: loop device broken in 2.4.6-pre5
Cc: axboe@suse.de, jari.ruusu@pp.inet.fi, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff writes:

>> But why 1024?
>> (Or make the set blocksize ioctl also work on loop devices.)

> I thought the change was a "quick hack" that would make stuff work
> (page cache?) near the end of the file. That would mean that this kind
> of "quick hack" won't work. 

I am not sure I can parse your sentence.
But:

# blockdev --getbsz /dev/loop1
0
# dd if=/dev/zero of=tenbl bs=1024 count=10
10+0 records in
10+0 records out
# losetup /dev/loop1 tenbl
# blockdev --getbsz /dev/loop1
4096
# dd if=/dev/zero of=/dev/loop1 bs=1024 count=10
dd: writing `/dev/loop1': No space left on device
9+0 records in
8+0 records out
# blockdev --setbsz 2048 /dev/loop1
# blockdev --getbsz /dev/loop1
2048
# dd if=/dev/zero of=/dev/loop1 bs=1024 count=10
10+0 records in
10+0 records out
#

Andries
