Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbVLSIvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVLSIvL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 03:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVLSIvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 03:51:11 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:36512 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030290AbVLSIvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 03:51:10 -0500
Message-ID: <43A67564.6020708@aitel.hist.no>
Date: Mon, 19 Dec 2005 09:55:00 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ray-gmail@madrabbit.org
CC: Lee Revell <rlrevell@joe-job.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051215212447.GR23349@stusta.de>	 <20051215140013.7d4ffd5b.akpm@osdl.org>	 <20051215223000.GU23349@stusta.de>	 <43A1DB18.4030307@wolfmountaingroup.com>	 <1134688488.12086.172.camel@mindpipe> <2c0942db0512151637o3c95239ha2f2bee20923b276@mail.gmail.com>
In-Reply-To: <2c0942db0512151637o3c95239ha2f2bee20923b276@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee wrote:

>(Man, I've been holding my tongue on this conversation for a while,
>but it seems my better angels have deserted me.)
>
>On 12/15/05, Lee Revell <rlrevell@joe-job.com> wrote:
>  
>
>>Bugzilla link please.
>>    
>>
>
>No, that's not how failure engineering is done. A guy designing a
>bridge doesn't cut all the supports back to the bare minimum just to
>save money because his design says that the remaining metal should be
>strong enough. If you can't prove it, and it's a safety issue
>(continuing my analogy in the physical world), then you engineer for
>failure. Can you handle all occurrences? No, a hurricane Katrina comes
>along every once in a while. Can you weather more than you did before?
>Yes. In the meantime, their are fewer poor sods falling off the bridge
>that have to open a bugzilla report.
>  
>
This is quite different - you know much better what stack loads
the kernel may get into.  A bridge gets all sorts of weather,
with the very extreme cases occuring now and then.  With the
kernel, you can look at the code and determine the maximum
possible stack depth that can ever occur. It won't get deeper
even in some very rare case.


>The world of software is no different. If someone wants to remove the
>8k stacks option, they'd better prove that they're making my servers
>more reliable. I've seen zero arguments for why 8k stacks is unviable.
>  
>
Well, would you like the kernel to kill your webserver (or whatever
important app) because it attempted to fork at a time where
no two consecutive pages could be found?   That happens
occationally in real life - with 8k stack.  Going to 12k stack, 16k stacks,
or (shudder) 64 stacks would make that much worse than it
is today.

>(I've also wondered why we can't just have IRQ stacks plus 8k thread
>stacks -- seemingly the best of both worlds) Instead, what I've seen
>is that we have coders who don't like the idea of any non-order-zero
>allocations taking place, because big systems running poorly coded
>Java apps with massive threading can hit problems with allocations
>from time to time.
>  
>
You don't need big threaded apps for this to happen.  All
you need is a handful of forking apps and memory
fragmentation.  Many common server apps (web, mail, fileserver,...)
tend to use forking.  Massively threaded apps like 4k stacks simply
because that saves 4k for each of the many threads.

>The answer for that is the same answer the kernel community usually
>gives about poorly designed userspace applications: rewrite them.
>
>I'm quite open to being proved wrong. If someone has a counter case
>they can toss forth, please do so. Systems taking lots of interrupts?
>Then how about 8k + IRQ stacks? With a counterexample I'll gladly
>concede that I'm an ignorant slut[*] -- excuse me, Saturday Night Live
>flashbacks -- an ignorant git, and shut up. ([*] is only half right,
>I'm not all that ignorant).
>
>If someone doesn't show a counter case, then may I suggest people
>consider the possibility that this is not proper engineering. Prove
>it, or provide a safety blanket. But don't yank the blanket without
>proving the lack of problem.
>  
>
Well, failing order-1 allocations is _the_ counterexample.  IT
never happens with 4k stacks unless you run totally out of
memory, and then nothing can save you.

Helge Hafting
