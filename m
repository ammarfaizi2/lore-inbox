Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313963AbSDKBus>; Wed, 10 Apr 2002 21:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313964AbSDKBus>; Wed, 10 Apr 2002 21:50:48 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:10256 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313963AbSDKBur>; Wed, 10 Apr 2002 21:50:47 -0400
Message-ID: <3CB4DD71.DED82F57@zip.com.au>
Date: Wed, 10 Apr 2002 17:48:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.5.8-pre] swapinfo accounting
In-Reply-To: <Pine.LNX.4.33L2.0204101755170.25409-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> It looks to me like mm/swapfile.c::si_swapinfo()
> shouldn't be adding nr_to_be_unused to total_swap_pages
> or nr_swap_pages for return in val->freeswap and
> val->totalswap.

whee, an si_swapinfo() maintainer.

Your function sucks :)  I'm spending 15 CPU-seconds
in there during a kernel build.  The problem appears
to be that a fix from 2.4 hasn't been propagated
forward.

2.4 has:

                if (swap_info[i].flags != SWP_USED)

and 2.5 has:

                if (!(swap_info[i].flags & SWP_USED))

and I think the 2.4 version will fix the accounting
problem you're seeing?

(I haven't checked whather it's the _right_ fix, but
it looks like it'll make it go away?)

-
