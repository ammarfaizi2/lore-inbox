Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUHQLfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUHQLfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUHQLfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:35:39 -0400
Received: from mail-02.iinet.net.au ([203.59.3.34]:32959 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261239AbUHQLfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:35:36 -0400
Message-ID: <4121ED7F.7060805@cyberone.com.au>
Date: Tue, 17 Aug 2004 21:35:27 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       Nathan Lynch <nathanl@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [patch] new-task-fix.patch, 2.6.8.1-mm1
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <1092722342.3081.68.camel@booger> <1092727147.27274.109.camel@bach> <20040817084510.GA6958@elte.hu>
In-Reply-To: <20040817084510.GA6958@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>* Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>  
>
>>Looking through 2.6.8.1-mm1, I see this code which doesn't make sense:
>>    
>>
>
>  
>
>>So, first off, the statements under "if (unlikely(cpu != this_cpu))"
>>can be folded into the previous block, since that's under the same
>>test.  Secondly, why is sleep_avg being set twice to the same thing,
>>and why are we happy to adjust it the first time without holding the
>>rq lock for current, but the second time we make sure we are holding
>>the rq lock? [...]
>>    
>>
>
>agreed, this is a bug - the code has rotten somewhat. The attached patch
>fixes it. I've also cleaned up the locking and added this_rq, to make
>clear when and how we are hopping from one runqueue to another. (this
>cleanup would have made the original bug more obvious as well.)
>
>This comes after sched-nonlinear-timeslicespatch.patch in 2.6.8.1-mm1. 
>Tested on x86.
>
>  
>

Looks OK to me. Thanks Ingo, Rusty.

