Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTIQEyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 00:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTIQEyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 00:54:09 -0400
Received: from dyn-ctb-203-221-73-208.webone.com.au ([203.221.73.208]:6917
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261959AbTIQEyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 00:54:06 -0400
Message-ID: <3F67E8D4.6010707@cyberone.com.au>
Date: Wed, 17 Sep 2003 14:53:40 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
References: <20030917022256.GA17624@wotan.suse.de> <20030916194446.030d8e70.akpm@osdl.org>
In-Reply-To: <20030916194446.030d8e70.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Andi Kleen <ak@suse.de> wrote:
>
>>
>>This is much more efficient than the previous workaround used in the kernel,
>>which checked for AMD CPUs in every prefetch(). This can be seen 
>>in the size of the vmlinux:
>>
>
>That is hardly a serious comparison: the workaround is just to stop the
>oopses while this gets sorted out.  It makes no pretense at either
>efficiency or permanence.
>
>
>>Without patch:
>>   text    data     bss     dec     hex filename
>>4020232  665956  169092 4855280  4a15f0 vmlinux
>>With patch:
>>4011578  665973  169092 4846643  49f433
>>
>
>hrm.  Why did data grow?
>
>
>>With prefetch check:    3.7268 microseconds
>>Without prefetch check: 3.65945 microseconds
>>
>
>We don't know how much of this difference is due to removing the branch and
>how much is due to reenabling prefetch.
>
>It would be interesting to see comparative benchmarking between prefetch
>and no prefetch at all, see whether this feature is worth its icache
>footprint.
>

The test was on a pentium 4, so its only removing the extra code.

I think Andi's patch is required (especially because it fixes
userspace), and under the current cpu selection scheme, it is
implemented correctly (although I am now at a loss as to what the
generic thing is for).

The conditional compilation thing is a seperate issue. This patch may
have just broken a few camels' backs.

What is intriguing to me is the "Its only a 2% slowdown of the page
fault for every cpu other than K[78] for this single workaround. There
is no point to conditional compilation" attitude some people have.
Of course, its only 2% on a pagefault, not anywhere near 2% of kernel
performance as a whole, so maybe that is justified.

Just repeating though, that is a seperate issue and I think Andi's patch
is needed.


