Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbTABEFQ>; Wed, 1 Jan 2003 23:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbTABEFP>; Wed, 1 Jan 2003 23:05:15 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:41350 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265480AbTABEFM>; Wed, 1 Jan 2003 23:05:12 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 1 Jan 2003 20:13:35 -0800
Message-Id: <200301020413.UAA03503@baldur.yggdrasil.com>
To: david-b@pacbell.net
Subject: Re: [PATCH] generic device DMA (dma_pool update)
Cc: akpm@digeo.com, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
>James Bottomley wrote:
>> adam@yggdrasil.com said:
>> 
>>>	Can someone show me or invent an example of two different uses of
>>>dma_alloc_coherent that really should use different policies on
>>>whether to block or not? 
>> 
>> 
>> The obvious one is allocations from interrupt routines, which must be 
>> GFP_ATOMIC (ignoring the issue of whether a driver should be doing a memory 
>> allocation in an interrupt).  Allocating large pools at driver initialisation 
>> should probably be GFP_KERNEL as you say.

>More:  not just "from interrupt routines", also "when a spinlock is held".
>Though one expects that if a dma_pool were in use, it'd probably have one
>of that kind of chunk already available (ideally, even initialized).

	Let me clarify or revise my request.  By "show me or invent an
example" I mean describe a case where this would be used, as in
specific hardware devices that Linux has trouble supporting right now,
or specific programs that can't be run efficiently under Linux, etc.
What device would need to do this kind of allocation?  Why haven't I
seen requests for this from people working on real device drivers?
Where is this going to make the kernel smaller, more reliable, faster,
more maintainable, able to make a computer do something it could do
before under Linux, etc.?

	I have trouble understanding why, for example, a USB hard
disk driver would want anything more than a fixed size pool of
transfer descriptors.  At some point you know that you've queued
enough IO so that the driver can be confident that it will be
called again before that queue is completely emptied.


>Many task-initiated allocations would use GFP_KERNEL; not just major driver
>activation points like open().

	Here too, it would help me to understand if you would try
to construct an example.

	Also, your use of the term GFP_KERNEL is potentially
ambiguous.  In some cases GFP_KERNEL seems to mean "wait indifinitely
until memory is available; never fail."  In other cases it means
"perhaps wait a second or two if memory is unavailable, but fail if
memory is not available by then."

	I don't dispute that adding a memory allocation class argument
to dma_alloc_consistent would make it capable of being used in more
cases.  I just don't know if any of those cases actually come up, in
which case the Linux community is probably better off with the smaller
kernel footprint.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
