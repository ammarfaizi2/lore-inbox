Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTIQFoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 01:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTIQFoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 01:44:22 -0400
Received: from dyn-ctb-203-221-73-208.webone.com.au ([203.221.73.208]:23301
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262674AbTIQFoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 01:44:20 -0400
Message-ID: <3F67F4A8.6080007@cyberone.com.au>
Date: Wed, 17 Sep 2003 15:44:08 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
References: <20030917022256.GA17624@wotan.suse.de>	<20030916194446.030d8e70.akpm@osdl.org>	<3F67E8D4.6010707@cyberone.com.au> <20030917072650.78f10ebf.ak@suse.de>
In-Reply-To: <20030917072650.78f10ebf.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:

>On Wed, 17 Sep 2003 14:53:40 +1000
>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>
>>The conditional compilation thing is a seperate issue. This patch may
>>have just broken a few camels' backs.
>>
>>What is intriguing to me is the "Its only a 2% slowdown of the page
>>fault for every cpu other than K[78] for this single workaround. There
>>
>
>Erm. It helps to get your numbers right first when arguing. Why did I waste the
>time on benchmarking and collecting data when people afterwards still argue with 
>bogus numbers? @)
>

I was using your numbers.

>
>It is not 2%, but <1% [~0.6% to be exact]
>

100 * (3.7268 - 3.65945) / 3.65945 = 1.8 (am I wrong?)

>
>(probably lower the statistical error for the test, LMBench results vary more
>than that on multiple runs)
>
>Then it is not for all page faults, but only for a very narrow special
>case - a page fault that is not handled, but causes a signal. These are
>not very common. Arguably there are some applications that use this
>stuff (like generational garbage collectors), but these are not exactly
>common.
>

I missed that, sorry.

>
>In summary, it causes 0.6% slowdown in an quite obscure use case.
>
>That's small enough that it is best to just always enable it, because
>the cost of processing any support request when people forget to enable
>etc. is much greater.
>

I agree that with the current cpu selection arrangements it has to be
always enabled. I'm talking about Adrian's patch though.

I wasn't really arguing about it based on it causing a big slowdown. I
just don't agree with your opinion (which you're very entitled to) on
the matter.

I think that messing up your config options is a user error anyway. And
obviously a big reason for config options is so you don't have to
compile everything, are we really going to try catering for people who
make the wrong choices?

Aside, I think Adrian's patch makes cpu selection simpler for users, and
if it was combined with a warning for booting a non selected cpu I can't
see it being any more of a support problem.


