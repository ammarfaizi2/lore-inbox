Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265537AbSKKFRH>; Mon, 11 Nov 2002 00:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSKKFRH>; Mon, 11 Nov 2002 00:17:07 -0500
Received: from [195.223.140.107] ([195.223.140.107]:39301 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265537AbSKKFRG>;
	Mon, 11 Nov 2002 00:17:06 -0500
Date: Mon, 11 Nov 2002 06:23:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021111052336.GC30193@dualathlon.random>
References: <3DCEC6F7.E5EC1147@digeo.com> <Pine.LNX.4.44L.0211101902390.8133-100000@imladris.surriel.com> <20021111015445.GB5343@x30.random> <3DCF2BF5.5DD165DD@digeo.com> <20021111040642.GA30193@dualathlon.random> <3DCF308E.166FAADF@digeo.com> <20021111043941.GB30193@dualathlon.random> <3DCF3BD1.4A95617D@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCF3BD1.4A95617D@digeo.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 09:10:41PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > from your description it seems what will happen is:
> > 
> >         queue 3 5 6 7 8 9
> > 
> > I don't see why you say it won't do that. the whole point of the patch
> > to put reads at or near the head, and you say 3 won't be put at the
> > head if only 5 writes are pending. Or maybe your bypasses "6 writes"
> > means the other way around, that you put the read as the seventh entry
> > in the queue if there are 6 writes pending, is it the case?
> 
> Actually I thought your "queue" was "head of queue" and that 5,6,7,8 and 9
> were reads....
> 
> If the queue contains, say:
> 
> (head)	R1 R2 R3 W1 W2 W3 W4 W5 W6 W7
> 
> Then a new R4 will be inserted between W6 and W7.  So if R5 is mergeable
> with R4 there is still plenty of time for that.

yes, the fact it's "near" and not exactly in the head as I originally
thought, makes it less likely that it slows things down, even if it
theoretically still could for some workload, overall it seems a
worthwhile heuristic.

Andrea
