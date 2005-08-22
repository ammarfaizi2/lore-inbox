Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbVHVW0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbVHVW0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbVHVW0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:26:50 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751408AbVHVW0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:26:15 -0400
Message-ID: <43098795.3040703@symas.com>
Date: Mon, 22 Aug 2005 01:06:45 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050821 SeaMonkey/1.0a
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <4D8eT-4rg-31@gated-at.bofh.it>	<4306A176.3090907@shaw.ca>	<4306AF26.3030106@yahoo.com.au>	<4307788E.1040209@symas.com>	<1124571437.2115.3.camel@mindpipe>	<43079FA9.700@symas.com> <17160.26222.678122.362194@gargle.gargle.HOWL>
In-Reply-To: <17160.26222.678122.362194@gargle.gargle.HOWL>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> Howard Chu writes:
>
>  > That's beside the point. Folks are making an assertion that
>  > sched_yield() is meaningless; this example demonstrates that there are
>  > cases where sched_yield() is essential.
>
> It is not essential, it is non-portable.
>
> Code you described is based on non-portable "expectations" about thread
> scheduling. Linux implementation of pthreads fails to satisfy
> them. Perfectly reasonable. Code is then "fixed" by adding sched_yield()
> calls and introducing more non-portable assumptions. Again, there is no
> guarantee this would work on any compliant implementation.
>
> While "intuitive" semantics of sched_yield() is to yield CPU and to give
> other runnable threads their chance to run, this is _not_ what standard
> prescribes (for non-RT threads).
>   
Very well; it is not prescribed in the standard and it is non-portable. 
Our code is broken and we will fix it.

But even Dave Butenhof, Mr. Pthreads himself, has said it is reasonable 
to expect sched_yield to yield the CPU. That's what pthread_yield did in 
Pthreads Draft 4 (DCE threads) and it is common knowledge that 
sched_yield is a direct replacement for pthread_yield; i.e., 
pthread_yield() was deleted from the spec because sched_yield fulfilled 
its purpose. Now you're saying "well, technically, sched_yield doesn't 
have to do anything at all" and the letter of the spec supports your 
position, but anybody who's been programming with pthreads since the DCE 
days "knows" that is not the original intention. I wonder that nobody 
has decided to raise this issue with the IEEE/POSIX group and get them 
to issue a correction/clarification in all this time, since the absence 
of specification here really impairs the usefulness of the spec.

Likewise the fact that sched_yield() can now cause the current process 
to be queued behind other processes seems suspect, unless we know for 
sure that the threads are running with PTHREAD_SCOPE_SYSTEM. (I haven't 
checked to see if PTHREAD_SCOPE_PROCESS is still supported in NPTL.)

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

