Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268916AbRHLBz1>; Sat, 11 Aug 2001 21:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268917AbRHLBzS>; Sat, 11 Aug 2001 21:55:18 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:45071 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268916AbRHLBzH>; Sat, 11 Aug 2001 21:55:07 -0400
Message-ID: <3B75E1F9.2BF5D4B6@zip.com.au>
Date: Sat, 11 Aug 2001 18:55:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: ext3-users@redhat.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.6
In-Reply-To: <3B75DE86.EEDFAFFB@zip.com.au>,
		<3B75DE86.EEDFAFFB@zip.com.au> <20010811184640.B17435@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> On Sat, Aug 11, 2001 at 06:40:22PM -0700, Andrew Morton wrote:
> 
> > Patch against linux-2.4.8 is at
> >
> >       http://www.uow.edu.au/~andrewm/linux/ext3/
> >
> > The only changes here are merging up to 2.4.8 and the bigendian
> > fix.
> 
> Gack.  I think about when you wrote this, I managed to crash again.  I
> was running 2.4.8-pre8 + fsync_dev -> fsync_no_super + first fix.  It
> was at transaction.c:1184, but the logs didn't make it to disk.

I'd assumed that this was related to the endianness fix.  You're
sure you were running with that in place?  If you can capture
a buffer trace that'd be great.

>  On a
> related note, what does ext3 do to the disk when this happens,  I
> think I need to point the yaboot author at it since it couldn't
> load a kernel (which was fun, let me tell you.. :))

ext3 is designed to nicely crash the machine if it thinks something
may be wrong with the fs - it's very defensive of your data.

If yaboot is open firmware's native ext2 capability then presumably
it refuses to read an ext3 partition which needs recovery.  ext3
is designed to not be compatible with ext2 when it's in the
needs-recovery state.

Probably the simplest way to avoid this is to make the boot partition
ext2.

-
