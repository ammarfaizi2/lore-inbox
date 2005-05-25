Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVEYNPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVEYNPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVEYNPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:15:49 -0400
Received: from mail.timesys.com ([65.117.135.102]:9995 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262157AbVEYNPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:15:38 -0400
Message-ID: <42947A1D.2090005@timesys.com>
Date: Wed, 25 May 2005 09:14:05 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Sven Dietrich <sdietrich@mvista.com>, Andrew Morton <akpm@osdl.org>,
       dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       mingo@elte.hu, hch@infradead.org, linux-kernel@vger.kernel.org,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505251323490.28057-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10505251323490.28057-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2005 13:09:11.0781 (UTC) FILETIME=[F17AE150:01C5612A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:
> On Tue, 24 May 2005, john cooper wrote:
>>I'd like to hear some technical arguments of why IRQ threads
>>are held with such suspicion...
> 
> Performance! Even on RT systems you do NOT make all interrupts run in
> threads. Simple devices like UARTS run everything in interrupt context.
> Introducing a context switch for every character received on such a
> channel can be _very_ expensive.

The IRQ thread mechanism introduces a facility which offers
a benefit at an associated cost.  For cases where the interrupt
payload processing is small in comparison to the associated
context switch, overhead in this case may be optimized
by running the payload processing in exception context.

But "performance" here is a vague term.  It may in some cases
be preferable to incur an increased overhead of interrupt payload
processing in task context to improve overall CPU availability
or reduce interrupt lockout in code associated with the
interrupt.  It is a system-wide issue depending on the system
goals.

I agree for simple devices which generate high frequency interrupts
and have trivial interrupt payload processing, the addition of
deferring the latter to task context may be unneeded overhead.
But even here it is a system-wide design issue and I don't see
a simple, universal right-way/wrong-way.  In any case the choice
of either mechanisms is available.

As a data point, commercial OSes exist which strive to optimize
for non-RT throughput which by default defer all interrupt payload
processing into task context.  Not that this is necessarily
conclusive here but it should offer reassurance this isn't as
radical a concept as it may seem.

-john

-- 
john.cooper@timesys.com
