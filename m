Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318882AbSIIVkQ>; Mon, 9 Sep 2002 17:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318931AbSIIVkP>; Mon, 9 Sep 2002 17:40:15 -0400
Received: from packet.digeo.com ([12.110.80.53]:1748 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318882AbSIIVkN>;
	Mon, 9 Sep 2002 17:40:13 -0400
Message-ID: <3D7D1643.A6317BBE@digeo.com>
Date: Mon, 09 Sep 2002 14:44:35 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
References: <3D7B9988.6B8CD04F@digeo.com> <1031606032.29715.58.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 21:44:51.0444 (UTC) FILETIME=[206A0B40:01C2584A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Sun, 2002-09-08 at 19:40, Andrew Morton wrote:
> > We need to find some way of making vm_enough_memory not call get_page_state
> > so often.  One way of doing that might be to make get_page_state dump
> > its latest result into a global copy, and make vm_enough_memory()
> > only get_page_state once per N invokations.  A speed/accuracy tradeoff there.
> 
> Unless the error always falls on the same side the accuracy tradeoff is
> fatal to the entire scheme of things. Sorting out the use of
> get_page_state is worth doing if that is the bottleneck, and
> snapshooting such that we only look at it if we might be close to the
> limit would work, but we'd need to know when the limit had shifted too
> much

It could be that the cost is only present on the IBM whackomatics,
so they can twiddle the /proc setting and we can all be happy.
Certainly I did not see any problems on the quad.

Does "heuristic" overcommit handling need so much accuracy?
Perhaps we can push some of the cost over into mode 2 somehow.

Or we could turn it the other way up and, in __add_to_page_cache(),
do:

	if (overcommit_mode == anal)
		atomic_inc(&nr_pagecache_pages);
