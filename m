Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268917AbRHLCPy>; Sat, 11 Aug 2001 22:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268920AbRHLCPo>; Sat, 11 Aug 2001 22:15:44 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:38797
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S268917AbRHLCPh>; Sat, 11 Aug 2001 22:15:37 -0400
Date: Sat, 11 Aug 2001 19:15:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: ext3-users@redhat.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.6
Message-ID: <20010811191539.C17435@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3B75DE86.EEDFAFFB@zip.com.au>, <3B75DE86.EEDFAFFB@zip.com.au> <20010811184640.B17435@cpe-24-221-152-185.az.sprintbbd.net> <3B75E1F9.2BF5D4B6@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B75E1F9.2BF5D4B6@zip.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2001 at 06:55:05PM -0700, Andrew Morton wrote:
> Tom Rini wrote:
> > 
> > On Sat, Aug 11, 2001 at 06:40:22PM -0700, Andrew Morton wrote:
> > 
> > > Patch against linux-2.4.8 is at
> > >
> > >       http://www.uow.edu.au/~andrewm/linux/ext3/
> > >
> > > The only changes here are merging up to 2.4.8 and the bigendian
> > > fix.
> > 
> > Gack.  I think about when you wrote this, I managed to crash again.  I
> > was running 2.4.8-pre8 + fsync_dev -> fsync_no_super + first fix.  It
> > was at transaction.c:1184, but the logs didn't make it to disk.
> 
> I'd assumed that this was related to the endianness fix.  You're
> sure you were running with that in place?  If you can capture
> a buffer trace that'd be great.

I'm sure I had the fix in.  I re-ran the original test I had a few times
and it was good.  I'll try and capture the buffer trace if it happens
again, but last time I'm guessing it happened on my root fs, so the log
couldn't goto disk.

> >  On a
> > related note, what does ext3 do to the disk when this happens,  I
> > think I need to point the yaboot author at it since it couldn't
> > load a kernel (which was fun, let me tell you.. :))
> 
> ext3 is designed to nicely crash the machine if it thinks something
> may be wrong with the fs - it's very defensive of your data.
> 
> If yaboot is open firmware's native ext2 capability then presumably
> it refuses to read an ext3 partition which needs recovery.  ext3
> is designed to not be compatible with ext2 when it's in the
> needs-recovery state.

It's the linux bootloader that OF runs.  Is there any 'safe' way to read
data off of an unclean ext3 partition?  I'm thinking grub might run into
this problem too..

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
