Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWBINrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWBINrh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 08:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWBINrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 08:47:37 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:58346 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932507AbWBINrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 08:47:36 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v22
Date: Fri, 10 Feb 2006 00:47:09 +1100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       ck list <ck@vds.kolivas.org>, linux-mm@kvack.org,
       Paul Jackson <pj@sgi.com>
References: <200602092339.49719.kernel@kolivas.org> <43EB43B9.5040001@yahoo.com.au>
In-Reply-To: <43EB43B9.5040001@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602100047.09722.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 00:29, Nick Piggin wrote:
> busy Con Kolivas wrote:

busy? that's an interesting mua comment...

> - Looking a lot better from an impact-on-rest-of-vm code wise inspection.

That's good to hear, thanks.

> I got a couple of suggestions to make it even better.
>
> - I still have big reservations about it. For example the fact that if you
> thrash memory and force everything to swap out, then exit your memory
> hog, it won't do anything if you just happened to `cat bigfile > /dev/null`
>
> - Then, it has the potential to make *useful* swapping much less useful
> (ie. it will page back in your unused programs and libraries, which will
> kick out unmapped pagecache on desktop workloads).
>
> - It does not appear to necessarily solve the updatedb problem.
>
> - People complaining about their browser getting swapped out of their 1GB+
> desktop systems due to a midnight cron run must be angering the VM gods.
> I'd rather try to work out what to sacrifice in order to appease them
> before sending another one up there to beat them into submission.

I really don't want to go throwing out pagecache without some smart semantics 
and then swap in random stuff that could be crap I agree. The answer to this 
is for the vm itself to have an ageing algorithm like the clockpro stuff 
which does this in a smart way. It could certainly age away the updatedb 
wrinkles and leave some free ram - which would help/be helped by prefetching.

I don't think I've ever said it fixes the updatedb debacle. Updatedb gets to 
rule another day, but that does not constitute every swap workload out there. 
It helps my daily workloads, and as you might have missed, others have 
reported demonstrable benefits (and not just the "it seems faster" type).

> Sorry to sound negative about it. 

Well you're honest and that's worth respecting.

> Lucky for you nobody listens to me. 

After some thought I've decided I ain't touching that one.

Cheers,
Con
