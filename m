Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132338AbRCZGgl>; Mon, 26 Mar 2001 01:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132340AbRCZGgc>; Mon, 26 Mar 2001 01:36:32 -0500
Received: from www.wen-online.de ([212.223.88.39]:41221 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132338AbRCZGg2>;
	Mon, 26 Mar 2001 01:36:28 -0500
Date: Mon, 26 Mar 2001 10:36:29 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jonathan Morton <chromi@cyberspace.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <l03130325b6e3e9bdf18e@[192.168.239.101]>
Message-ID: <Pine.LNX.4.33.0103260915230.390-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2001, Jonathan Morton wrote:

> >> My patch already fixes OOM problems caused by overgrown caches/buffers, by
> >> making sure OOM is not triggered until these buffers have been cannibalised
> >> down to freepages.high.  If balancing problems still exist, then they
> >> should be retuned with my patch (or something very like it) in hand, to
> >> separate one problem from the other.  AFAIK, balancing should now be a
> >> performance issue rather than a stability issue.
> >
> >Great.  I haven't seen your patch yet as my gateway ate it's very last
> >disk.  I look forward to reading it.
>
> I'm currently investigating the old non-overcommit patch, which (apart from
> needing manual applying to recent kernels) appears to be rather broken in a
> trivial way.  It prevents allocation if total reserved memory is greater
> than the total unallocated memory.  Let me say that again, a different way
> - it prevents memory usage from exceeding 50%...
>
> Is there a fast way of getting total VM size?  Eg. equivalent to the
> following code:
>
> si_meminfo(&i);
> si_swapinfo(&i);
> free = i.totalram + i.totalswap;

Other than using their components?.. don't know.

> If not, I have to do some jiggery to keep good performance along with true
> non-overcommittance.

(thinking about mlock and what that could do to any saved state.. and
how long allocations can block and where.. egad.  then there's zones)

I'm no VM expert, but I wonder if the overhead of obtaining this info
will be the worst you have to deal with.

	-Mike

