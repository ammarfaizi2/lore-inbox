Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWDXTfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWDXTfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWDXTfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:35:37 -0400
Received: from spirit.analogic.com ([204.178.40.4]:20492 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751173AbWDXTfW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:35:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
X-OriginalArrivalTime: 24 Apr 2006 19:35:20.0819 (UTC) FILETIME=[39460430:01C667D6]
Content-class: urn:content-classes:message
Subject: Re: better leve triggered IRQ management needed
Date: Mon, 24 Apr 2006 15:35:20 -0400
Message-ID: <Pine.LNX.4.61.0604241529360.24459@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: better leve triggered IRQ management needed
thread-index: AcZn1jlNkvcn1qSPRYmhekg3OEA18g==
References: <20060424114105.113eecac@localhost.localdomain> <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Stephen Hemminger" <shemminger@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2006, Linus Torvalds wrote:

>
>
> On Mon, 24 Apr 2006, Stephen Hemminger wrote:
>>
>> We should fail request_irq() if the SA_SHIRQ but the irq is edge-triggered.
>
> That would be HORRIBLE.
>
> Edge-triggered works perfectly fine for SA_SHIRQ, as long as there is just
> one user and the driver is properly written. Making request_irq() fail
   ^^^^^^^^_______ Must be a trick!
> would break existing and working setups.
>

If there is just one user then it isn't shared! Get real.

> If you have a driver that requires level-triggered interrupts, then your
> driver is arguably buggy. NAPI or no NAPI, doesn't matter. Edge-triggered
> interrupts is a fact of life, and deciding that you don't like them is not
> an excuse for saying "they should not work".
>

It's trivial to write a driver where the ISR completely handles the
interrupt so that another edge can happen. It is impossible to write
a driver that shares such an edge-driven interrupt with another.

> You can get an edge by having your driver make sure that it clears the
> interrupt source at some point where it requires an edge.
>
> And yes, that may mean that when you're ready to start taking interrupts
> again, you are required to first read all pending packets, instead of just
> assuming that a level-triggered interrupt will "just happen", but that's
> the harsh reality for writing a driver that actually WORKS.
>
> For a driver writer, there is one rule above _all_ other rules:
>
> 	"Reality sucks, deal with it"
>
> That rule is inviolate, and no amount of "I wish", and "it _should_ work
> this way" or "..but the documentation says" matters at all.
>
> If you can't take that rule, don't write drivers, and don't design
> infrastructure for them.
>
> 		Linus

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
