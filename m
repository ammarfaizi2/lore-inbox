Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVGYTK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVGYTK5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVGYTK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:10:57 -0400
Received: from fmr16.intel.com ([192.55.52.70]:9954 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261431AbVGYTKx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:10:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Variable ticks
Date: Mon, 25 Jul 2005 15:10:50 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300424AA2D@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Variable ticks
Thread-Index: AcWRSqw2OzUzd9nhSMKXSvD8WYnVggAAHUtg
From: "Brown, Len" <len.brown@intel.com>
To: "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Jul 2005 19:10:40.0477 (UTC) FILETIME=[8C2600D0:01C5914C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>I was thinking about variable tick times, and I can think of three 
>classes of action needing CPU attention.
>- device interrupts, which occur at no predictable time but would pull 
>the CPU out of a HLT or low power state.
>- process sleeps of various kinds, which have a known time of 
>occurence.
>- polled devices...
>
>Question one, are there other actions to consider?

Yes.
Speaking for ACPI C3 state, note that DMA also
wakes up the CPU -- even if there was no device interrupt.
(aka, "the trouble with USB")

>Question two, what about those polled devices?

it is a real challenge to save power under such conditions,
unless you can throttle the polling rate such that
the processor can actually enters idle while polling
is underway.

>I've been asked to give a high level overview of the recent discussion 
>for a meeting, and while I want to keep it at the level of "slower 
>clock, fewer interrupts" and "faster clock, better sleep 
>resolution," I 
>don't want to leave out any important issues, or be asked a question 
>(like how to handle polling devices) when I have no idea what 
>people are thinking in an area.

>From a power management point of view, what is important
is what we do when idle.  ie. on my laptop, from a power
savings point of view, I wouldn't care
much if HZ=1000 all the time if HZ=0 when in idle.

Outside of idle, the tick rate is much less important to
power savings, unless the change in tick rate was significant
enough to change the load enough that we'd want to change the
target non-idle MHz of the processor.

cheers,
-Len
