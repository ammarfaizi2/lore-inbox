Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVDBHGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVDBHGK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 02:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVDBHGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 02:06:09 -0500
Received: from fmr15.intel.com ([192.55.52.69]:12976 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261188AbVDBHFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 02:05:52 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: x86 TSC time warp puzzle
Date: Fri, 1 Apr 2005 23:05:21 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6004629635@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: x86 TSC time warp puzzle
Thread-Index: AcU3JdXonX6xmtAoSG2cn+UlcNdZLQAH+mog
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jonathan Lundell" <linux@lundell-bros.com>,
       "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Apr 2005 07:05:16.0676 (UTC) FILETIME=[52D98440:01C53752]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At what point are you seeing these delays? During early boot or after
boot? 
It can be SMI happening in the platform. Typically BIOS uses some SMI
polling 
to handle some devices during early boot. Though 500 microseconds sounds
a 
bit too high.

Thanks,
Venki

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Jonathan Lundell
>Sent: Friday, April 01, 2005 5:43 PM
>To: LKML
>Subject: x86 TSC time warp puzzle
>
>Well, not actually a time warp, though it feels like one.
>
>I'm doing some real-time bit-twiddling in a driver, using the TSC to 
>measure out delays on the order of hundreds of nanoseconds. Because I 
>want an upper limit on the delay, I disable interrupts around it.
>
>The logic is something like:
>
>	local_irq_save
>	out(set a bit)
>	t0 = TSC
>	wait while (t = (TSC - t0)) < delay_time
>	out(clear the bit)
>	local_irq_restore
>
> From time to time, when I exit the delay, t is *much* bigger than 
>delay_time. If delay_time is, say, 300ns, t is usually no more than 
>325ns. But every so often, t can be 2000, or 10000, or even much 
>higher.
>
>The value of t seems to depend on the CPU involved, The worst case is 
>with an Intel 915GV chipset, where t approaches 500 microseconds (!).
>
>This is with ACPI and HT disabled, to avoid confounding interactions. 
>I suspected NMI, of course, but I monitored the nmi counter, and 
>mostly saw nothing (from time to time a random hit, but mostly not).
>
>The longer delay is real. I can see the bit being set/cleared in the 
>pseudocode above on a scope, and when the long delay happens, the bit 
>is set for a correspondingly long time.
>
>BTW, the symptom is independent of my IO. I wrote a test case that 
>does diddles nothing but reading TSC, and get the same result.
>
>Finally, on some CPUs, at least, the extra delay appears to be 
>periodic. The 500us delay happens about every second. On a different 
>machine (chipset) it happens at about 5 Hz. And the characteristic 
>delay on each type of machine seems consistent.
>
>Any ideas of where to look? Other lists to inquire on?
>
>Thanks.
>-- 
>/Jonathan Lundell.
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
