Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUBWCCy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 21:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbUBWCCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 21:02:54 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:36823 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261195AbUBWCCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 21:02:52 -0500
Message-ID: <40395F49.1010702@cyberone.com.au>
Date: Mon, 23 Feb 2004 13:02:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<40395ACE.4030203@cyberone.com.au> <20040222175507.558a5b3d.akpm@osdl.org>
In-Reply-To: <20040222175507.558a5b3d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>
>>
>>Andrew Morton wrote:
>>
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm2/
>>>
>>>
>>>
>>URL is of course,
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm3/
>>
>
>Yes, thanks.
>
>
>>This still doesn't shrink slab correctly on highmem machines
>>because you dropped my patch :(
>>
>
>First, one needs to define "correctly".
>
>Certainly, it is not "solves the alleged updatedb problem".
>
>

No, I think this is a non-problem.

>The design behind the slab shrinking is to reclaim slab in response to
>memory demand.  Not in response to lowmem demand.  With all the scaling,
>accounting-for-seeks-and-locality, etc.
>
>

That should come out in the wash with my patch anyway, because
it causes lowmem LRU pressure to assert a *lot* more slab pressure.
So highmem pressure should cause a similar amount of slab pressure
with either patch, it just comes about in different ways.

But allocations from lowmem will not shrink the slab nearly enough
with your patch because it shrinks by a percent of all pages.

