Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVKOVLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVKOVLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVKOVLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:11:23 -0500
Received: from spirit.analogic.com ([204.178.40.4]:36624 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750745AbVKOVLX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:11:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <437A4315.6040604@nortel.com>
References: <20051115102425.0iln2874xjoc4g84@coolrunningconcepts.com> <Pine.LNX.4.61.0511151401400.6145@chaos.analogic.com> <437A4315.6040604@nortel.com>
X-OriginalArrivalTime: 15 Nov 2005 21:11:22.0453 (UTC) FILETIME=[21619850:01C5EA29]
Content-class: urn:content-classes:message
Subject: Re: Timer idea
Date: Tue, 15 Nov 2005 16:11:17 -0500
Message-ID: <Pine.LNX.4.61.0511151542460.6510@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Timer idea
Thread-Index: AcXqKSFrIT0udLJ5SqeP2zmsXnR5Lg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Christopher Friesen" <cfriesen@nortel.com>
Cc: <evan@coolrunningconcepts.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2005, Christopher Friesen wrote:

> linux-os (Dick Johnson) wrote:
>
>> On ix86 machines, basic time comes from chip(s), read from ports.
>> That's just another tiny little problem.
>
> I'm sure you already know this, but x86 can also use the HPET for
> timestamps, as well as the TSC if it's available.
>
> Chris
>

Yes. Also, it can be 64 bits on 64 bit machines. Memory-mapping
isn't a solve-all, though. The mayor problem is that there
are so many ways to get incompatible time:

 	PIT, RTC, TSC, HPET.

... Every one requires a knowledge of a specific architecture  --
and every one has its own set of problems. If HPET was a problem
solver, then it would be a step in the right direction. Unfortunately
it just makes another set of unique problems.

The new hardware timer should-have-been something that does:

 	(1) A memory mapped register that reads time with
 	microsecond resolution like POSIX wants.
 	(2) A memory mapped register to which is written an
 	offset to adjust the time (in +/- microseconds).
 	(3) A memory mapped register to course-set time like
 	'time_t'.
 	(4) It should have been PCI/Based so if the motherboard
 	didn't have one built-in, you could buy one and plug
 	it in.

... Now, with everything done in hardware, there is no problem
with obtaining a correct, adjustable time. Anything less is
just a patch on a patch. Such a timer-chip, if made with a built-
in low-temperature coefficient AT-cut crystal could have been
developed to sell for under two dollars, in 1,000 quantities. Of
course if you have to make a plug-in board with a PCI interface,
that's much more expensive, but only the cost of a cheap network
card.

It looks like Intel had some timer-chip macro-cells that they
wanted to unload. There was no technical thought put into the
HPET. Yes, they claimed that it can be used for multimedia and,
in fact, it was first called a "multimedia timer". So new
ix86 boards will have what Apple boards have.

In a previous generation, VAXen had the right idea. A separate
device that kept time, starting at zero. The clock time was the
sum of boot-time, clock-time, and time-adjust quadwords. Unfortunately
the time was in micro-fortnights because it used a bus-clock for
the interval.

The concept of the three values, manipulated by hardware, not
software, will certainly be the ultimate solution to time-keeping.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.51 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
