Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbSJ1VIR>; Mon, 28 Oct 2002 16:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSJ1VIR>; Mon, 28 Oct 2002 16:08:17 -0500
Received: from [195.223.140.107] ([195.223.140.107]:37760 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261493AbSJ1VIQ>;
	Mon, 28 Oct 2002 16:08:16 -0500
Date: Mon, 28 Oct 2002 22:14:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: chrisl@vmware.com, linux-kernel@vger.kernel.org, chrisl@gnuchina.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021028211416.GK13972@dualathlon.random>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com> <3DB990FE.A1B8956@digeo.com> <20021028191745.GA1564@vmware.com> <3DBD95B8.321C4D6E@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBD95B8.321C4D6E@digeo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 11:53:28AM -0800, Andrew Morton wrote:
> chrisl@vmware.com wrote:
> > 
> > On Fri, Oct 25, 2002 at 11:44:14AM -0700, Andrew Morton wrote:
> > > chrisl@vmware.com wrote:
> > > >
> > > > bigmm -i 3 -t 2 -c 1024
> > >
> > > That's a nice little box killer you have there.
> > 
> > Thanks. It kills on all our customer's kernel, they don't use the
> > bleeding edge kernel at all. It is interesting to see vmware
> > serve as some heavy load stress test tool. It will give some real
> > world load to the OS, e.g. the load need to boot a windows etc. You
> > can stack many of them to abuse the OS.
> 
> I tested Andrea's latest kernel.  It survived.
> 
> Probably because it left 100 megabytes of lowmem unallocated
> throughout the test.

that's unrelated to the vm code though (in terms of per-zone lru
mentioned by Andrew for 2.5 that in turns breaks all the aging
information compared to 2.4), that is meant to definitely fix another
highmem unbalance bug where all the lowmem could be pinned and made
unfreeable by lowmem users despite plenty of highmem is still available.
That's the fix to the google mlock deadlock, mainline has a weak attempt
to fix it in another manner, but I backed it out since it's too weak to
be effective in the real workloads (it didn't fix the problem in real
life) and I instead kept my first approch that is THE definitive fix.
btw, 2.5 has still the weak approch, so it's still subject to the google
bug, I will fix it in my tree while moving to 2.5.

> If the customer is running a suse/UL kernel they're presumably OK.

Right.

Andrea

(PS about your previous comment on the swap needed: kernels <= 2.4.9
 (9 != 19) also have the problem that vm+swap isn't all the vm that vmware
 can use, for them you need the double of swap)
