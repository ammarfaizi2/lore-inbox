Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWGFUkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWGFUkg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWGFUkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:40:35 -0400
Received: from zcars04f.nortel.com ([47.129.242.57]:21968 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1750830AbWGFUke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:40:34 -0400
Message-ID: <44AD752D.3090405@nortel.com>
Date: Thu, 06 Jul 2006 14:40:13 -0600
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
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com> <1152187268.3084.29.camel@laptopd505.fenrus.org> <44AD5357.4000100@rtr.ca> <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org> <44AD658A.5070005@nortel.com> <Pine.LNX.4.64.0607061257130.3869@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607061257130.3869@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jul 2006 20:40:17.0762 (UTC) FILETIME=[64301420:01C6A13C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 6 Jul 2006, Chris Friesen wrote:
> 
>>The C standard requires the use of volatile for signal handlers and setjmp.
> 
> 
> Actually, the C standard requires "sigatomic_t".


 From ISO/IEC 9899:TC2, both of these specifically mention volatile:


7.13.2.1 The longjmp function

3 All accessible objects have values, and all other components of the 
abstract machine212) have state, as of the time the longjmp function was 
called, except that the values of objects of automatic storage duration 
that are local to the function containing the invocation of the 
corresponding setjmp macro that do not have volatile-qualified type and 
have been changed between the setjmp invocation and longjmp call are 
indeterminate.


7.14.1.1 The signal function

5 If the signal occurs other than as the result of calling the abort or 
raise function, the behavior is undefined if the signal handler refers 
to any object with static storage duration other than by assigning a 
value to an object declared as volatile sig_atomic_t, ...


>>For userspace at least the whole discussion of "barriers" is sort of
>>moot--there are no memory barriers defined in the C language, which makes it
>>kind of hard to write portable code that uses them.
> 
> 
> Any locking primitive BY DEFINITION has a barrier in it.
> 
> If it doesn't, it's not a locking primitive, it's a random sequence of 
> code that does something pointless.

Sure, so the implementation of the locking primitives requires 
hardware-specific knowledge.

But for someone coding to POSIX, is there any reason why they would use 
barriers?  If so, what API would they use?

Chris
