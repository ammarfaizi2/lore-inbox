Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUCKXiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 18:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUCKXiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 18:38:13 -0500
Received: from anumail3.anu.edu.au ([150.203.2.43]:63192 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S261816AbUCKXiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 18:38:01 -0500
Message-ID: <4050F84F.8080005@cyberone.com.au>
Date: Fri, 12 Mar 2004 10:37:51 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
References: <1ysXv-wm-11@gated-at.bofh.it> <m3lllzawlm.fsf@averell.firstfloor.org> <20040311112852.4f56cf34.akpm@osdl.org> <20040311202136.GA59610@colin2.muc.de>
In-Reply-To: <20040311202136.GA59610@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-2.5)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>>Some kind of SMT scheduler is definitely needed, we have a serious
>>>regression compared to 2.4 here right now. I'm not sure this 
>>>is the right approach though, it seems to be far too complex.
>>>

Andi, I'll agree that the way domains currently get set up is pretty
ugly. Maybe some additional functions or macros could be used to make
this process a bit clearer.

The actual kernel/sched.c code is really not that complex. In some ways
it is *less* complicated than the old numa scheduler because it all goes
through one code path.

It also handles SMT, which is where a bit of complexity is coming from.
The other alternative is shared runqueues which is uglier and less flexible.


>>Well that's discouraging.  I really do want to push this thing along a bit.
>>
>>Yours is the only report of regression of which I am aware.  Is the reason
>>understood?
>>
>
>I think the reason is that it doesn't do balance on clone/fork. The 
>normal scheduler also doesn't do that, but for some reason it still does 
>better on the benchmarks (but worse than the old 2.4 -aa/Intel O(1) HT 
>scheduler)
>
>

There have been a few changes and bug fixes since you last tested.
Maybe that would help.

>>And is anyone developing alternative SMT enhancements?
>>
>
>I thought there was a patch from Ingo Molnar? ("shared runqueue") 
>I must admit I never tried it, just remember seeing the patches.
>

Yep shared runqueues. Ingo and Rusty both had implementations but
they both agreed sched-domains was a better alternative.


