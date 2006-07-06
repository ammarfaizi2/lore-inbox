Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWGFTdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWGFTdu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWGFTdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:33:50 -0400
Received: from zrtps0kn.nortel.com ([47.140.192.55]:25475 "EHLO
	zrtps0kn.nortel.com") by vger.kernel.org with ESMTP
	id S1750753AbWGFTdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:33:49 -0400
Message-ID: <44AD658A.5070005@nortel.com>
Date: Thu, 06 Jul 2006 13:33:30 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Mark Lord <lkml@rtr.ca>, Arjan van de Ven <arjan@infradead.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com> <1152187268.3084.29.camel@laptopd505.fenrus.org> <44AD5357.4000100@rtr.ca> <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jul 2006 19:33:34.0834 (UTC) FILETIME=[1241BD20:01C6A133]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On Thu, 6 Jul 2006, Mark Lord wrote:

>> A volatile declaration may be used to describe an object corresponding
>> to a memory-mapped input/output port or an object accessed by an
>> aysnchronously interrupting function.  Actions on objects so declared
>> shall not be "optimized out" by an implementation or reordered except
>> as permitted by the rules for evaluating expressions.
> 
> 
> Note that the "reordered" is totally pointless.
> 
> The _hardware_ will re-order accesses. Which is the whole point. 
> "volatile" is basically never sufficient in itself.

The "reordered" thing really only matters on SMP machines, no?  In which 
case (for userspace) the locking mechanisms (mutexes, etc.) should do 
The Right Thing to ensure visibility between cpus.

The C standard requires the use of volatile for signal handlers and setjmp.

For userspace at least the whole discussion of "barriers" is sort of 
moot--there are no memory barriers defined in the C language, which 
makes it kind of hard to write portable code that uses them.

Only a couple months ago Dave Miller mentioned setting variables 
modified in signal handlers as "volatile", and you didn't complain.  If 
fact you added that they should be of type "sigatomic_t".

(Pardon the long URL)

http://groups.google.com/group/linux.kernel/browse_frm/thread/18a59e3c9d8f6310/84881a7e53038b0e?lnk=st&q=sigatomic_t&rnum=8&hl=en#84881a7e53038b0e


Chris

