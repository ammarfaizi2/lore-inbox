Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311690AbSCNRlA>; Thu, 14 Mar 2002 12:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311694AbSCNRkv>; Thu, 14 Mar 2002 12:40:51 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62731 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311690AbSCNRkj>; Thu, 14 Mar 2002 12:40:39 -0500
Message-ID: <3C90E02E.EB242F8C@zip.com.au>
Date: Thu, 14 Mar 2002 09:38:54 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Roberto Nibali <ratz@drugphish.ch>, linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
In-Reply-To: <3C9007F5.1000003@drugphish.ch> <3C900A11.55BA4B32@zip.com.au> <3C90939E.4070409@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Andrew Morton wrote:
> > Roberto Nibali wrote:
> >
> >>Hi,
> >>
> >>What for are BLKRAGET, BLKFRAGET and BLKSECTGET still needed?
> >>
> >
> > They got collaterally damaged in the IDE "cleanup".  The patch at
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6/dallocbase-10-readahead.patch
> > resurrects them.
> 
> This is WRONG. What I did here was just removal of unused code.
> They got obsoleted by the BIO infrastructure changes.

Actually, it's right.

In mid-February you asserted that the IDE readahead controls were
inoperative.  You said:

> You are missing one simple thing: The removed values doen't control
> ANYTHING!

I asked:

> Please explain, in detail, why /proc/ide/hdX/settings:file_readhead
> no longer controls the readhead for that device.  If this is
> the case in thr current 2.4 kernel, or if it will become the
> case if/when the IDE patches are merged then that needs fixing.
> 

You didn't answer.

I tested them.  They still worked.

I also said:

> 
> Look, I agree that the current readhead controls are junk, and
> do not belong in the driver layer at all.   All I'm saying is
> that we need per-device controls, for whatever scheme we end
> up using for readhead in 2.5.   We really don't want to have
> the same sized readhead for CDROMs, floppies and super-duper
> RAID arrays.

Then the device-driver-based readahead controls got taken out.

I really do agree that it was a pile of crap.  I've turned them
into a property of the request queue, which is a more appropriate
place for them.

In my current patch, the per-queue readahead parameter is controlled
via the old ioctls.  Probably, these will be retired in favour of
/proc/iosched, when that turns up.

In the meantime, I *need* those tunables for ongoing development.

-
