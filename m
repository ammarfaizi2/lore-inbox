Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbUB0TTf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbUB0TTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:19:35 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:45281 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262935AbUB0TT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:19:27 -0500
Date: Sat, 28 Feb 2004 03:19:14 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Matt Mackall" <mpm@selenic.com>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Why no interrupt priorities?
Cc: "Helge Hafting" <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com> <20040227185555.GJ3883@waste.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr31mmcvk4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040227185555.GJ3883@waste.org>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 12:55:55 -0600, Matt Mackall <mpm@selenic.com> wrote:

> On Fri, Feb 27, 2004 at 09:44:44AM -0800, Grover, Andrew wrote:
>> > From: Helge Hafting [mailto:helgehaf@aitel.hist.no]
>> > Grover, Andrew wrote:
>> > > Is the assumption that hardirq handlers are superfast also
>> > the reason
>> > > why Linux calls all handlers on a shared interrupt, even if
>> > the first
>> > > handler reports it was for its device?
>> > >
>> > No, it is the other way around.  hardirq handlers have to be superfast
>> > because linux usually _have to_ call all the handlers of a shared irq.
>> >
>> > The fact that one device did indeed have an interrupt for us
>> > doesn't mean
>> > that the others didn't.  So all of them have to be checked to be safe.
>>
>> If a device later in the handler chain is also interrupting, then the
>> interrupt will immediately trigger again. The irq line will remain
>> asserted until nobody is asserting it.
>>
>> If the LAST guy in the chain is the one with the interrupt, then you
>> basically get today's ISR "call each handler" behavior, but it should be
>> possible to in some cases to get less time spent in do_IRQ.
>
> Let's imagine you have n sources simultaneously interrupting on a
> given descriptor. Check the first, it's happening, acknowledge it,
> exit, notice interrupt still asserted, check the first, nope, check
> the second, yep, exit, etc. By the time we've made it to the nth ISR,
> we've banged on the first one n times, the second n-1 times, etc. In
> other words, early chain termination has an O(n^2) worst case.
>

With level triggered you can just walk the chain, exit at the end of the
first cycle and  should the IRQ still be asserted you just incur the
overhead of exit and reentry of the ISR.

Even with edge, I would not check alwasy from the beginning of the chain...


