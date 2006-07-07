Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWGGVWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWGGVWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWGGVWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:22:35 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:44297 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932313AbWGGVWe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:22:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 07 Jul 2006 21:22:33.0118 (UTC) FILETIME=[75CA73E0:01C6A20B]
Content-class: urn:content-classes:message
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Fri, 7 Jul 2006 17:22:31 -0400
Message-ID: <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] spinlocks: remove 'volatile'
thread-index: AcaiC3XUgpyH4pfkQk2d+p9KiwwVSQ==
References: <20060705114630.GA3134@elte.hu><20060705101059.66a762bf.akpm@osdl.org><20060705193551.GA13070@elte.hu><20060705131824.52fa20ec.akpm@osdl.org><Pine.LNX.4.64.0607051332430.12404@g5.osdl.org><20060705204727.GA16615@elte.hu><Pine.LNX.4.64.0607051411460.12404@g5.osdl.org><20060705214502.GA27597@elte.hu><Pine.LNX.4.64.0607051458200.12404@g5.osdl.org><Pine.LNX.4.64.0607051555140.12404@g5.osdl.org><20060706081639.GA24179@elte.hu><Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com><Pine.LNX.4.64.0607060856080.12404@g5.osdl.org><Pine.LNX.4.64.0607060911530.12404@g5.osdl.org><Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com> <m34pxt8emn.fsf@defiant.localdomain> <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com> <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Krzysztof Halasa" <khc@pm.waw.pl>, "Ingo Molnar" <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux kernel" <linux-kernel@vger.kernel.org>, <arjan@infradead.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Jul 2006, Linus Torvalds wrote:

>
>
> On Fri, 7 Jul 2006, linux-os (Dick Johnson) wrote:
>>
>> Now Linus declares that instead of declaring an object volatile
>> so that it is actually accessed every time it is referenced, he wants
>> to use a GNU-ism with assembly that tells the compiler to re-read
>> __every__ variable existing im memory, instead of just one. Go figure!
>
> Actually, it's not just me.
>
> Read things like the Intel CPU documentation.
>
> IT IS ACTIVELY WRONG to busy-loop on a variable. It will make the CPU
> potentially over-heat, causing degreaded performance, and you're simply
> not supposed to do it.

This is a bait and switch argument. The code was displayed to show
the compiler output, not an example of good coding practice.

Furthermore, I'm still waiting for the new spin-friction that's
supposed to cause the increased heat. It doesn't exist and furthermore
no Intel processor instruction manual (that is available for public
inspection) claims that busy-waiting increases any heating, only that
some processors that __can__ fall back into a low-power mode will not
do so if they are spinning (naturally). But this is just another
bait-and-switch as well because I only wrote about volatile and
I even provided references.

>
>> Reference:
>> /usr/src/linux-2.6.16.4/include/linux/compiler-gcc.h:
>> #define barrier() __asm__ __volatile__("": : :"memory")
>
> Actually, for your kind of stupid loop, you should use
>
> - include/asm-i386/processor.h:
> 	#define cpu_relax()        rep_nop()
>

Again, I didn't propose to do that. In fact, your spin-lock
code already inserts "rep nops" and I never implied that they
should be removed. I said only that "volatile" still needs to
be used, not some macro that tells the compiler that everything
in memory probably got trashed. Read what I said, not what you
think some idiot might have said.

> where rep_nop() is
>
> 	/* REP NOP (PAUSE) is a a good thing to insert into busy-wait loops. */
> 	static inline void rep_nop(void)
> 	{
> 		__asm__ __volatile__("rep;nop": : :"memory");
> 	}
>
> on x86, and can be other things on other CPU's. On ppc64 it is
>
> 	#define cpu_relax()     do { HMT_low(); HMT_medium(); barrier(); } while (0)
>
> where those HMT macros adjust thread priority.
>

Not either of these things have anything to do with the topic and
I never even implied that they did. Again, I spoke only of the
well known volatile keyword. Nothing else.

> In other words, you just don't know what you're talking about. "volatile"
> is simply not useful, and the fact that you cannot seem to grasp that is
> _your_ problem.
>

Well, in fact I do know what I'm talking about. Your bait-and-switch
arguments just won't work with me.

> Repeat after me (or just shut up about things that you not only don't know
> about, but are apparently not willing to even learn):
>
> 	"'volatile' is useless. The things it did 30 years ago are much
> 	 more complex these days, and need to be tied to much more
> 	 detailed rules that depend on the actual particular problem,
> 	 rather than one keyword to the compiler that doesn't actually
> 	 give enough information for the compiler to do anything useful"
>
> Comprende?
>
> 		Linus
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
