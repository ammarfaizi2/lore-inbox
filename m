Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273904AbRJQCOo>; Tue, 16 Oct 2001 22:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274062AbRJQCOe>; Tue, 16 Oct 2001 22:14:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13675 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273904AbRJQCOY>; Tue, 16 Oct 2001 22:14:24 -0400
Date: Wed, 17 Oct 2001 04:09:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org,
        ltp-list@lists.sourceforge.net
Subject: Re: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
Message-ID: <20011017040907.A2380@athlon.random>
In-Reply-To: <20011017021242.S2380@athlon.random> <Pine.LNX.4.30.0110170920350.18794-100000@gamma.student.ljbc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.30.0110170920350.18794-100000@gamma.student.ljbc>; from kuib-kl@ljbc.wa.edu.au on Wed, Oct 17, 2001 at 09:32:12AM +0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 09:32:12AM +0800, Beau Kuiper wrote:
> On Wed, 17 Oct 2001, Andrea Arcangeli wrote:
> 
> > On Tue, Oct 16, 2001 at 08:16:39AM -0400, rwhron@earthlink.net wrote:
> > >
> > > Summary:
> > >
> > > Wall clock time for this test has dropped dramatically (which
> > > is good) over the last 3 Andrea Arcangeli patched kernels.
> >
> > :) I worked the last two days to make it faster under swap, it's nice to
> > see that your tests also confirm that.  I'm only scared it swaps too
> > much when swap is not used but if this sorts out to be the case it will
> > be very easy to fix. And a very minor bit of very seldom background
> > pagetable scanning shouldn't hurt anyways. So far on my desktop it seems
> > not to swap too much.
> 
> Swapping too much probably has a lot to do with a particular hard drive
> and its performace. Is there any way of adding a configurable option (via
> sysctl) to allow the adminstrators to tune how aggressively the kernel
> swaps out data/vs throwing out the disk cache (so if it is set to
> agressive, the kernel will try hard to make sure to use swap to free up
> memory, or if it is set to conservative it will try to free disk cache (to
> a limit) instead of swapping stuff out to free memory)

I could add a sysctl to control that. In short the change consists of
making the DEF_PRIORITY in mm/vmscan.c a variable rather than a
preprocessor #define. That's the "ratio" number I was talking about in
the last email to Rik, and if you read ac/mm/vmscan.c you'll find it
there too indeed.

That's basically the only number that I left in the code, everything
else should be completly dynamic behaviour. Anyways also this number
isn't critical, as said it shouldn't make an huge difference anyways,
but yes it could be tunable.

However one of the reasons I didn't do that I still believe the vm
should be autotuning and provide behaviour with concepts, not with
random tweaking. But I cannot imagine at the moment how to make even
such fixed number to go away :), so at the moment it could make some
sense to make it a sysctl.

The probe of the cache that allows me to swapouts before we really
failed shrinking the cache doesn't sounds like random tweaking either to
me (maybe I'm biased 8), it instead allows to free memory and swapout at
the very same time, and this seems beneficial.

Andrea
