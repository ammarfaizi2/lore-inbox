Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263651AbTIBIjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbTIBIjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:39:25 -0400
Received: from dyn-ctb-203-221-73-133.webone.com.au ([203.221.73.133]:15366
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263651AbTIBIjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:39:18 -0400
Message-ID: <3F545731.80808@cyberone.com.au>
Date: Tue, 02 Sep 2003 18:39:13 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Mitchell Blank Jr <mitch@sfgoth.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] might_sleep() improvements
References: <20030902075145.GA12817@sfgoth.com> <3F545175.1080505@cyberone.com.au> <20030902083256.GA52644@gaz.sfgoth.com>
In-Reply-To: <20030902083256.GA52644@gaz.sfgoth.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mitchell Blank Jr wrote:

>Nick Piggin wrote:
>
>>>Andrew - I thought this might be appropriate for -mm kernels.
>>>
>>>This patch makes the following improvements to might_sleep():
>>>
>>>o Add a "might_sleep_if()" macro for when we might sleep only if some
>>> condition is met.  I think this is a bit better than the currently used
>>> "if (cond) might_sleep();" since it's clearer that the test won't be
>>> compiled in if spinlock sleep debugging is turned off.  (Obviously
>>> gcc is smart enough to omit simple conditions in that case)  It also
>>> looks cleaner, IMO.  Think of it as analogous to BUG()/BUG_ON().
>>>
>>>
>>I think these should be pushed down to where the sleeping
>>actually happens if possible.
>>
>
>No, you want to generate the warning as early as possible in case the
>sleeping case happens very infrequently.  For instance:
>
>	newskb = skb_unshare(skb, GFP_KERNEL);
>
>might not even need to do any allocation (much less a sleep) in 99.9% of
>cases, but it's still a bug if it's called in atomic context and we want
>spinlock sleep debugging to catch that for us.
>
>

Yeah well in this case I guess skb_unshare is as low as might_sleep
can be pushed. I guess I don't have a problem with might_sleep_if as
long as its used nicely.


