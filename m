Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWGFM35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWGFM35 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 08:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWGFM35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 08:29:57 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:65298 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030229AbWGFM34 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 08:29:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 06 Jul 2006 12:29:55.0221 (UTC) FILETIME=[E2FC9C50:01C6A0F7]
Content-class: urn:content-classes:message
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Thu, 6 Jul 2006 08:29:55 -0400
Message-ID: <Pine.LNX.4.61.0607060816110.8320@chaos.analogic.com>
In-Reply-To: <1152187268.3084.29.camel@laptopd505.fenrus.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] spinlocks: remove 'volatile'
thread-index: Acag9+MG6p41tfWPT5aj2a7d6bU04Q==
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com> <1152187268.3084.29.camel@laptopd505.fenrus.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Jul 2006, Arjan van de Ven wrote:

> On Thu, 2006-07-06 at 07:59 -0400, linux-os (Dick Johnson) wrote:
>> On Thu, 6 Jul 2006, Ingo Molnar wrote:
>>
>>>
>>> * Linus Torvalds <torvalds@osdl.org> wrote:
>>>
>>>> I wonder if we should remove the "volatile". There really isn't
>>>> anything _good_ that gcc can do with it, but we've seen gcc code
>>>> generation do stupid things before just because "volatile" seems to
>>>> just disable even proper normal working.
>>
>> Then GCC must be fixed. The keyword volatile is correct. It should
>> force the compiler to read the variable every time it's used.
>
> this is not really what the C standard says.
>
>
>
>> This is not pointless. If GCC generates bad code, tell the
>> GCC people. The volatile keyword is essential.
>
> no the "volatile" semantics are vague, trecherous and evil. It's a LOT
> better to insert the well defined "barrier()" in the right places.

Look at:

 	http://en.wikipedia.org/wiki/Volatile_variable

This is just what is needed to prevent the compiler from making non working
code during optimization.

Also look at:

 	http://en.wikipedia.org/wiki/Memory_barrier

This is used to prevent out-of-order execution, not at all what is
necessary.

Also, just because it 'works' means nothing. When SMP processors
came about, we had many drivers with no spin-locks at all. Sometimes
some files had a byte or two changed. That was the only obvious
problem. If this had continued, the entire file system would be
trashed, but fortunately we learned about spin-locks and the
volatile keyword. You must not destroy the spin locks by removing
the volatile keyword.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
