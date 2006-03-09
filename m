Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWCIC3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWCIC3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 21:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWCIC3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 21:29:52 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:44171 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932151AbWCIC3v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 21:29:51 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: yield during swap prefetching
Date: Thu, 9 Mar 2006 13:30:13 +1100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org
References: <200603081013.44678.kernel@kolivas.org> <20060308222404.GA4693@elf.ucw.cz> <440F9154.2080909@yahoo.com.au>
In-Reply-To: <440F9154.2080909@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603091330.14396.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2006 01:22 pm, Nick Piggin wrote:
> Pavel Machek wrote:
> >On Út 07-03-06 16:05:15, Andrew Morton wrote:
> >>Why do you want that?
> >>
> >>If prefetch is doing its job then it will save the machine from a pile of
> >>major faults in the near future.  The fact that the machine happens
> >
> >Or maybe not.... it is prefetch, it may prefetch wrongly, and you
> >definitely want it doing nothing when system is loaded.... It only
> >makes sense to prefetch when system is idle.
>
> Right. Prefetching is obviously going to have a very low work/benefit,
> assuming your page reclaim is working properly, because a) it doesn't
> deal with file pages, and b) it is doing work to reclaim pages that
> have already been deemed to be the least important.
>
> What it is good for is working around our interesting VM that apparently
> allows updatedb to swap everything out (although I haven't seen this
> problem myself), and artificial memory hogs. By moving work to times of
> low cost. No problem with the theory behind it.
>
> So as much as a major fault costs in terms of performance, the tiny
> chance that prefetching will avoid it means even the CPU usage is
> questionable. Using sched_yield() seems like a hack though.

Yeah it's a hack alright. Funny how at last I find a place where yield does 
exactly what I want and because we hate yield so much noone wants me to use 
it all.

Cheers,
Con
