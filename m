Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbSLGAW7>; Fri, 6 Dec 2002 19:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbSLGAW7>; Fri, 6 Dec 2002 19:22:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:55243 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267672AbSLGAW6>;
	Fri, 6 Dec 2002 19:22:58 -0500
Message-ID: <3DF14125.966E5899@digeo.com>
Date: Fri, 06 Dec 2002 16:30:29 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrea Arcangeli <andrea@suse.de>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
References: <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <20021206222852.GF4335@dualathlon.random> <20021206232125.GR9882@holomorphy.com> <3DF13A54.927C04C1@digeo.com> <20021207002133.GT9882@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 00:30:29.0287 (UTC) FILETIME=[D82E8B70:01C29D87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> > William Lee Irwin III wrote:
> > >
> > > ...
> > > A 16KB or 64KB kernel allocation unit would then annihilate
> >
> On Fri, Dec 06, 2002 at 04:01:24PM -0800, Andrew Morton wrote:
> > You want to be careful about this:
> >       CPU: L1 I cache: 16K, L1 D cache: 16K
> > Because instantiating a 16k page into user pagetables in
> > one hit means that it must all be zeroed.  With these large
> > pagesizes that means that the application is likely to get
> > 100% L1 misses against the new page, whereas it currently
> > gets 100% hits.
> 
> 16K is reasonable; after that one might as well go all the way.

16k will cause serious slowdowns.

> About the only way to cope is amortizing it by cacheing zeroed pages,
> and that has other downsides.

So will that.  You've seen the kernbench profiles...

You will need to find a way to clear the page just before it
is used.
