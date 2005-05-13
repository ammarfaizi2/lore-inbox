Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVEMJd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVEMJd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 05:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVEMJd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 05:33:56 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:15289 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262318AbVEMJdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 05:33:53 -0400
Message-ID: <4284747C.7030009@yahoo.com.au>
Date: Fri, 13 May 2005 19:33:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Ingo Molnar <mingo@elte.hu>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       george@mvista.com, jdike@addtoit.com,
       Jesse Barnes <jesse.barnes@intel.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] (How to) Let idle CPUs sleep
References: <20050512171251.GA21656@in.ibm.com> <OF86BA5D99.FE159896-ONC1256FFF.0062E865-C1256FFF.0063A681@de.ibm.com> <20050513062330.GD23705@in.ibm.com> <42845456.3080908@yahoo.com.au> <20050513080424.GA31206@elte.hu> <428464D5.10702@yahoo.com.au> <20050513091924.GG23705@in.ibm.com>
In-Reply-To: <20050513091924.GG23705@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Fri, May 13, 2005 at 08:29:17AM +0000, Nick Piggin wrote:
> 
>>And don't forget that the watchdog approach can just as easily deep
>>sleep a CPU only to immediately wake it up again if it detects an
>>imbalance.
> 
> 
> I think we should increase the threshold beyond which the idle CPU
> is woken up (more than the imbalance_pct that exists already). This
> should justify waking up the CPU.
> 

Oh yeah that's possible (and maybe preferable - testing will need to
be done). But again it doesn't solve the corner cases where problems
happen. And it introduces more divergence to the balancing algorithms.

Basically I'm trying to counter the notion that the watchdog solution
is fundamentally better just because it allows indefinite sleeping and
backoff doesn't. You'll always be waking things up when they should
stay sleeping, and putting them to sleep only to require they be woken
up again.

> 
>>And the CPU usage / wakeup cost arguments cut both ways. The busy
>>CPUs have to do extra work in the watchdog case.
> 
> 
> Maybe with a really smart watchdog solution, we can cut down this overhead.

Really smart usually == bad, especially when it's not something that
has been shown to be terribly critical.

> I did think of other schemes - a dedicated CPU per node acting as watchdog 
> for that node and per-node wacthdog kernel threads? - to name a few. What I had
> proposed was the best I thought. But maybe we can look at improving it 
> to see if the overhead concern you have can be reduced - meeting the interests
> of both the worlds :)

My main concern is complexity, second concern is diminishing returns,
third concern is overhead on other CPUs :)

But I won't pretend to know it all - I don't have a good grasp of the
problem domains, so I'm just making some noise now so we don't put in
a complex solution where a simple one would suffice.

The best idea obviously would be to get the interested parties involved,
and get different approaches running side by side, then measure things!


