Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSIHVbz>; Sun, 8 Sep 2002 17:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSIHVbz>; Sun, 8 Sep 2002 17:31:55 -0400
Received: from packet.digeo.com ([12.110.80.53]:16298 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S315275AbSIHVby>;
	Sun, 8 Sep 2002 17:31:54 -0400
Message-ID: <3D7BC648.2A27202A@digeo.com>
Date: Sun, 08 Sep 2002 14:51:04 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
References: <3D7B9988.6B8CD04F@digeo.com> <Pine.LNX.4.44.0209082139190.1950-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2002 21:36:30.0180 (UTC) FILETIME=[CB397A40:01C2577F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On Sun, 8 Sep 2002, Andrew Morton wrote:
> >
> > We need to find some way of making vm_enough_memory not call get_page_state
> > so often.  One way of doing that might be to make get_page_state dump
> > its latest result into a global copy, and make vm_enough_memory()
> > only get_page_state once per N invokations.  A speed/accuracy tradeoff there.
> 
> Accuracy is not very important in that sysctl_overcommit_memory 0 case
> e.g. the swapper_space.nr_pages addition was brought in at a time when
> it was very necessary, but usually overestimates now (or last time I
> thought about it).  The main thing to look out for is running the same
> memory grabber twice in quick succession: not nice if it succeeds the
> first time, but not the second, just because of some transient effect
> that its old pages are temporarily uncounted.
> 

That's right - there can be sudden and huge changes in pages used/free.

So any rate limiting tweak in there would have to be in terms of
number-of-pages rather than number-of-seconds.
