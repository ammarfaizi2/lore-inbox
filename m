Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281922AbRKZRBU>; Mon, 26 Nov 2001 12:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281929AbRKZRBK>; Mon, 26 Nov 2001 12:01:10 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:44295 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S281922AbRKZRBF>; Mon, 26 Nov 2001 12:01:05 -0500
Date: Mon, 26 Nov 2001 11:54:40 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
In-Reply-To: <87elmlo6ag.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.3.96.1011126114550.26538A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Nov 2001, OGAWA Hirofumi wrote:

> davidsen@tmr.com (bill davidsen) writes:
> 
> > In article <E166e8A-0000t2-00@mrvdom02.schlund.de> linux-kernel@borntraeger.net wrote:
> > | > > Machine booted ok and everything seemed to be ok, but i noticed a few
> > | > > weird messages in boot messages right before mounting the root-partition:
> > | > > FAT: bogus logical sector size 0
> > | > > FAT: bogus logical sector size 0
> > | > When the kernel is booting, it doesn't know the filesystem type of the
> > | > root fs, so it tries to mount the root device using all of the compiled-in
> > | > fs drivers, in the order they are listed in fs/Makefile.in.
> > | > It appears that the fat driver doesn't even check for a magic when it
> > | > starts trying to mount the filesystem, so it proceeds directly to
> > | 
> > | To be complete we should also apply this patch.
> > 
> > To be totally honest I think this is the wrong way to go. Like masking
> > the symptoms instead of treating the disease. The problem is that the
> > FAT driver seems to not check f/s type before claiming a f/s as its own.
> > The better solution is to put in a check before going forward with using
> > the f/s as FAT.
> 
> FAT doesn't have the field like the magic number, AFAIK.

Actually the original poster used "magic" and I didn't quibble, but I
believe you're right. I just noted that it is better to check to see if
the filesystem is FAT before reporting the error message. Obviously this
can be done, since you don't get the message with FAT as a module, I just
haven't looked to see if the check is in the module or the kernel before
even loading the FAT module.

Thanks for noting that, in any case.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

