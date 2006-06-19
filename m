Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWFSUAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWFSUAK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWFSUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:00:10 -0400
Received: from spirit.analogic.com ([204.178.40.4]:11272 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964872AbWFSUAI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:00:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 19 Jun 2006 20:00:06.0953 (UTC) FILETIME=[F6361190:01C693DA]
Content-class: urn:content-classes:message
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Date: Mon, 19 Jun 2006 16:00:06 -0400
Message-ID: <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com>
In-Reply-To: <20060619191543.GA17187@rhlx01.fht-esslingen.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
thread-index: AcaT2vY9zN6VgbfUSHKgQCJQ9iyCWw==
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2006, Andreas Mohr wrote:

> Hello all,
>
> while looking for loop places to apply cpu_relax() to, I found the
> following gems:
>
> arch/i386/kernel/crash.c/crash_nmi_callback():
>
>        /* Assume hlt works */
>        halt();
>        for(;;);
>
>        return 1;
> }
>
> arch/i386/kernel/doublefault.c/doublefault_fn():
>
>        for (;;) /* nothing */;
> }
>
> Let's assume that we have a less than moderate fan failure that causes
> the CPU to heat up beyond the critical limit...
> That might result in - you guessed it - crashes or doublefaults.
> In which case we enter the corresponding handler and do... what?

The double-fault is just a place-holder. The CPU will actually
reset without even executing this (try it).

> Exactly, we accelerate the CPUs happy march into bit heaven by letting it
> execute a busy-loop under a non-working fan.

You accelerate nothing. Bit heaven? A CPU without a fan will go into
a cold, cold, shutdown, requiring a hardware reset to get it out of
that latched, no internal clock running, mode. Try it. I have had
broken plastic heat-sink hold-downs let the entire heat-sink fall off
the CPU. The machine just stops. I didn't know why it was stopping
since each time I reset it, it ran long enough to boot. When
I took the side panel off, I was surprised to see the heat-sink
and fan assembly hanging by the fan wires. Also, the CPU was only
warm to the touch, having been completely shut down for the
several minutes it took to locate tools to remove the cover, even
though I deliberately left the power ON.

> Thanks, your users will be very happy, I think ;)
> (especially since it was "just" a simple fan failure that could have been
> entirely remedied by buying another fan for $3)
>
>
> The same thing applies to
> arch/i386/kernel/smp.c/stop_this_cpu(), albeit there it's less catastrophic
> due to most likely normal working conditions there.
>
> IMHO on any critical CPU failure we should:
> - try to log it (might be difficult with a broken CPU, though)
> - optionally somehow directly alert the user
> - STOP the system, COMPLETELY (that way people WILL take notice, hopefully
>  before it's too late and actual damage will have occurred)
> - make DAMN SURE that the (possibly already broken) CPU won't have a
>  less than nice time once the system is stopped


In the first place, when the Intel and AMD CPUs overheat, they
shut down. To prevent them from cycling ON/OFF, they need a
hardware reset to take them out of shutdown mode. There is no
need to fret about busy-waiting.

For sure, it might be nicer to have some call-and-never-return
function for waiting with the rep-nop code, but it isn't necessary
for CPU protection.

>
> Am I completely missing something here?
>

See above.

> If this is an issue, then maybe we should consolidate those places into
> one function that safely(!) halts a CPU, optionally disabling APIC etc.
>
> Oh, and once you finished processing my mail here, you could optionally
> also look at my report about almost unusably broken USB:
> http://lkml.org/lkml/2006/6/19/54
> (no replies yet despite advanced breakage)
>
> Thanks!
>
> Andreas Mohr
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
