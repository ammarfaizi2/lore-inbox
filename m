Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268928AbRHLCr5>; Sat, 11 Aug 2001 22:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268929AbRHLCrs>; Sat, 11 Aug 2001 22:47:48 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:34190
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S268928AbRHLCro>; Sat, 11 Aug 2001 22:47:44 -0400
Date: Sat, 11 Aug 2001 19:47:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: ext3-users@redhat.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.6
Message-ID: <20010811194744.B17668@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3B75DE86.EEDFAFFB@zip.com.au>, <3B75DE86.EEDFAFFB@zip.com.au> <20010811184640.B17435@cpe-24-221-152-185.az.sprintbbd.net> <3B75E1F9.2BF5D4B6@zip.com.au>, <3B75E1F9.2BF5D4B6@zip.com.au> <20010811191539.C17435@cpe-24-221-152-185.az.sprintbbd.net> <3B75E9E3.FAAF05CC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B75E9E3.FAAF05CC@zip.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2001 at 07:28:51PM -0700, Andrew Morton wrote:
> Tom Rini wrote:
> > > >  On a
> > > > related note, what does ext3 do to the disk when this happens,  I
> > > > think I need to point the yaboot author at it since it couldn't
> > > > load a kernel (which was fun, let me tell you.. :))
> > >
> > > ext3 is designed to nicely crash the machine if it thinks something
> > > may be wrong with the fs - it's very defensive of your data.
> > >
> > > If yaboot is open firmware's native ext2 capability then presumably
> > > it refuses to read an ext3 partition which needs recovery.  ext3
> > > is designed to not be compatible with ext2 when it's in the
> > > needs-recovery state.
> > 
> > It's the linux bootloader that OF runs.  Is there any 'safe' way to read
> > data off of an unclean ext3 partition?  I'm thinking grub might run into
> > this problem too..
> 
> Well, LILO works OK with an unclean ext3 FS because it goes straight to
> the underlying blocks.  If both grub and OF parse the superblock compatibility
> bits then they could fail in this manner.

Both GRUB and yaboot can read directly from the fs.  It's possible to boot
a kernel right out of OF from an HFS partition (which I had to do to get
the box up again).  It might be worth documenting this someplace.

> I *think* that at present an unrecovered ext3 filesystem is "incomaptible"
> with ext2.  If, however we were to make it "read-only compatible" then
> ext2-aware loaders would still be able to read the fs and boot from it.

That'd be nice.  There's lots of PPC boxes which don't have a seperate
/boot.  But ext2 should be able to read a clean ext3, yes?  I never get
a chance to check thing... :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
