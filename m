Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313267AbSD3M0x>; Tue, 30 Apr 2002 08:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313299AbSD3M0w>; Tue, 30 Apr 2002 08:26:52 -0400
Received: from buzz.etsit.upm.es ([138.100.17.60]:38149 "HELO
	buzz.etsit.upm.es") by vger.kernel.org with SMTP id <S313267AbSD3M0v>;
	Tue, 30 Apr 2002 08:26:51 -0400
Date: Tue, 30 Apr 2002 14:23:17 +0200 (CEST)
From: Jaime Medrano <overflow@eurielec.etsit.upm.es>
To: <linux-kernel@vger.kernel.org>
Subject: raid1 performance
Message-ID: <Pine.LNX.4.33.0204301411210.4658-100000@cuatro.eurielec.etsit.upm.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have several raid arrays (level 0 and 1) in my machine and I have
noticed that raid1 is much more slower than I expected.

The arrays are made from two equal hds (/dev/hde, /dev/hdg). And some
numbers about the read performances are:

/dev/hde: 29 Mb/s
/dev/hdg: 29 Mb/s
/dev/md0: 27 Mb/s (raid1)
/dev/md1: 56 Mb/s (raid0)
/dev/md2: 27 Mb/s (raid1)

These numbers comes from hdparm -tT. I have noticed a very poor
performance when reading sequentially a large file from raid1 (I suppose
this is what hdparm does).

I have taken a look at the read balancing code at raid1.c and I have found
that when a sequential read happens no balancing is done, and so all the
reading is done from only one of the mirrors while the others are iddle.ç

I have tried to modify the balancing algorithm in order to balance also
sequential access, but I have got almost the same numbers.

I have thought that the reason may be that some layer bellow is making
reads of greater size than the chunks in which I balance, and so the same
work is being done twice; but I don't know the way to find this.

Does anybody know how this works?

Regards,
Jaime Medrano


