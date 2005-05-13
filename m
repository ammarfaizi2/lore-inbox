Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVEMHQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVEMHQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 03:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVEMHQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 03:16:45 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:43349 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262272AbVEMHQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 03:16:43 -0400
Message-ID: <42845456.3080908@yahoo.com.au>
Date: Fri, 13 May 2005 17:16:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>, george@mvista.com,
       jdike@addtoit.com, Jesse Barnes <jesse.barnes@intel.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] (How to) Let idle CPUs sleep
References: <20050512171251.GA21656@in.ibm.com> <OF86BA5D99.FE159896-ONC1256FFF.0062E865-C1256FFF.0063A681@de.ibm.com> <20050513062330.GD23705@in.ibm.com>
In-Reply-To: <20050513062330.GD23705@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Thu, May 12, 2005 at 08:08:26PM +0200, Martin Schwidefsky wrote:
> 
>>I would prefer a solution where the busy CPU wakes up an idle CPU if the
>>imbalance is too large. Any scheme that requires an idle CPU to poll at
>>some intervals will have one of two problem: either the poll intervall
>>is large then the imbalance will stay around for a long time, or the
>>poll intervall is small then this will behave badly in a heavily
>>virtualized environment with many images.
> 
> 
> I guess all the discussions we are having boils down to this: what is the max
> time one can afford to have an imbalanced system because of sleeping idle CPU
> not participating in load balance? 10ms, 100ms, 1 sec or more?
> 

Exactly. Any scheme that requires a busy CPU to poll at some intervals
will also have problems: you are putting more work on the busy CPUs,
there will be superfluous IPIs, and there will be cases where the
imbalance is allowed to get too large. Not really much different from
doing the work with the idle CPUs really, *except* that it will introduce
a lot of complexity that nobody has shown is needed.

> Maybe the answer depends on how much imbalance it is that we are talking of
> here. A high order of imbalance would mean that the sleeping idle CPUs have
> to be woken up quickly, while a low order imbalance could mean that 
> we can let it sleep longer.
> 
>>From all the discussions we have been having, I think a watchdog
> implementation makes more sense. Nick/Ingo, what do you think
> should be our final decision on this?
> 

Well the complex solution won't go in until it is shown that the
simple version has fundamental failure cases - but I don't think
we need to make a final decision yet do we?

-- 
SUSE Labs, Novell Inc.

