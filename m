Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTIGRiy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTIGRhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:37:36 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:32014
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263388AbTIGRhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:37:03 -0400
Message-ID: <3F5B6CB9.9050408@cyberone.com.au>
Date: Mon, 08 Sep 2003 03:36:57 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Yau <jyau_kernel_dev@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <000201c374c8$1124ee20$f40a0a0a@Aria> <3F5ABE90.2040003@cyberone.com.au> <Law10-OE296cRyiOYbp00008b23@hotmail.com> <3F5AE7ED.7010501@cyberone.com.au> <LAW10-OE38NfztQ7LS000009f64@hotmail.com> <3F5AF9D9.3070206@cyberone.com.au> <Law10-OE54gbLYluLCT0003a61e@hotmail.com>
In-Reply-To: <Law10-OE54gbLYluLCT0003a61e@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Yau wrote:

>>Its actually more important when you have smaller timeslices, because
>>the interactive task is more likely to use all of its timeslice in a
>>burst of activity, then getting stuck behind all the cpu hogs.
>>
>>
>
>Well, I didn't claim it'd be optimal, I just said that it's not worth the
>extra effort.  The interactive task will still finish in O((interactive_time
>/ timeslice) * #hogs + interative_time) ms.  As long as the cpu time
>interactive tasks require are very short, they still should finish within a
>reasonable amount of time.
>

I have found it to be worth the extra effort in my patches, but maybe
you have something different in mind.

>
>>Yes. Also, say 5 hogs running, an interactive task needs to do something
>>taking 2ms. At a 2ms timeslice, it will take 2ms. At a 1ms timeslice it
>>will take 6ms.
>>
>>
>
>That's assuming that the interactive task gets scheduled first.  In the
>worst case scenario where it gets scheduled last, at 2 ms, it takes 12 ms
>and at 1 ms it also takes 12 ms.  Not much difference there.
>
>

No, not much difference. If the worst case scenario happens, it
indicates you have quite a big problem (ie. an interactive task not
allowed to preempt cpu hogs).


