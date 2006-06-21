Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWFUR5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWFUR5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWFUR5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:57:45 -0400
Received: from spirit.analogic.com ([204.178.40.4]:31492 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751062AbWFUR5p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:57:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 21 Jun 2006 17:57:44.0170 (UTC) FILETIME=[3265CCA0:01C6955C]
Content-class: urn:content-classes:message
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Date: Wed, 21 Jun 2006 13:57:43 -0400
Message-ID: <Pine.LNX.4.61.0606211334060.6615@chaos.analogic.com>
In-Reply-To: <44997EF0.3000005@us.ibm.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
thread-index: AcaVXDJtgNe7FFzIR9q8aHWzH+sW3A==
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com> <20060619222528.GC1648@openzaurus.ucw.cz> <20060619224130.GA17134@redhat.com> <Pine.LNX.4.61.0606200729280.7695@chaos.analogic.com> <44997EF0.3000005@us.ibm.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ian Romanick" <idr@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Jun 2006, Ian Romanick wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> linux-os (Dick Johnson) wrote:
>
>> The CPU produces heat. It's efficiency as a heater is nearly 100%
>> because it doesn't produce much noise or anything else to transfer
>> its 50+ watts into anything but heat. Spinning doesn't make friction.
>> It doesn't make more heat. The total box dissipation might even
>> be reduced because there is little memory activity and no seeks
>> of hard disks.
>>
>> Some CPUs will go to a low-power 'sleep' mode if halted. Some require
>> more than that, they must fetch 'pause', i.e., rep nop to stay in
>> a low power mode. Other CPUs will throttle back their power
>> consumption when the instruction cache is inactive, read spinning.
>> These CPUs are normally used in lap-tops to maximize battery life.
>
> What creates a fair amount of the heat in a CPU is the period of time
> when the transistors switch from nearly zero resistance to infinite
> resistance.  That brief period where the resistance very high but not
> yet infinite generates heat.  That's why running a CPU at a higher clock
> speed generates more heat:  there are more of those high resistance
> transitions in a given period of time.
>
> I think every processor since at least 1998 or so has had a mode where
> executing the HLT instruction puts the bulk of the chip in a steady
> state.  When it's in that steady state, the transistors don't switch, so
> there are no high resistance periods.
>
> This is, of course, completely different than the sleep or reduced clock
> modes that modern processors support.

P = I^2 * R, where R is resistance, I is current, and P is power. So
naively, one might assume that a high resistance state would cause
high power dissipation. This is not what's happening when the clock
is running.

What happens is that logic levels form voltage levels within devices.
The elements that are charged and discharged due to logic level changes
have associated capacitances. Changing the voltage on a capacitor
requires current to flow. It's this current, often called displacement
current, flowing through the non-zero output resistances of the devices
that charge these capacities, that cause the dominant power loss. There
are other resistances as well, through which this displacement current
must flow.

This displacement current varies directly with the charging rate
(frequency), but the power loss (from I^2) varies as the square of
the frequency. That's why reducing the clock rate during idle periods
even a small amount, or shutting down some clocked portions of the
chip during such periods can be effective in reducing the power
dissipation and, therefore, heat generation. If you reduce the
current a small amount, the power reduction can be substantial.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
