Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268924AbRHLC3F>; Sat, 11 Aug 2001 22:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268928AbRHLC2z>; Sat, 11 Aug 2001 22:28:55 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:10247 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268924AbRHLC2t>; Sat, 11 Aug 2001 22:28:49 -0400
Message-ID: <3B75E9E3.FAAF05CC@zip.com.au>
Date: Sat, 11 Aug 2001 19:28:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: ext3-users@redhat.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.6
In-Reply-To: <3B75DE86.EEDFAFFB@zip.com.au>, <3B75DE86.EEDFAFFB@zip.com.au> <20010811184640.B17435@cpe-24-221-152-185.az.sprintbbd.net> <3B75E1F9.2BF5D4B6@zip.com.au>,
		<3B75E1F9.2BF5D4B6@zip.com.au> <20010811191539.C17435@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> ...
> > I'd assumed that this was related to the endianness fix.  You're
> > sure you were running with that in place?  If you can capture
> > a buffer trace that'd be great.
> 
> I'm sure I had the fix in.  I re-ran the original test I had a few times
> and it was good.  I'll try and capture the buffer trace if it happens
> again, but last time I'm guessing it happened on my root fs, so the log
> couldn't goto disk.

OK, thanks.

> > >  On a
> > > related note, what does ext3 do to the disk when this happens,  I
> > > think I need to point the yaboot author at it since it couldn't
> > > load a kernel (which was fun, let me tell you.. :))
> >
> > ext3 is designed to nicely crash the machine if it thinks something
> > may be wrong with the fs - it's very defensive of your data.
> >
> > If yaboot is open firmware's native ext2 capability then presumably
> > it refuses to read an ext3 partition which needs recovery.  ext3
> > is designed to not be compatible with ext2 when it's in the
> > needs-recovery state.
> 
> It's the linux bootloader that OF runs.  Is there any 'safe' way to read
> data off of an unclean ext3 partition?  I'm thinking grub might run into
> this problem too..

Well, LILO works OK with an unclean ext3 FS because it goes straight to
the underlying blocks.  If both grub and OF parse the superblock compatibility
bits then they could fail in this manner.

I *think* that at present an unrecovered ext3 filesystem is "incomaptible"
with ext2.  If, however we were to make it "read-only compatible" then
ext2-aware loaders would still be able to read the fs and boot from it.
But this stuff makes my head hurt - let's see what Andreas and Stephen
have to say.

-
