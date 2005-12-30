Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVL3Mk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVL3Mk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 07:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVL3Mk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 07:40:28 -0500
Received: from general.keba.co.at ([193.154.24.243]:39726 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1750825AbVL3Mk1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 07:40:27 -0500
Content-class: urn:content-classes:message
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 30 Dec 2005 13:40:20 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <AAD6DA242BC63C488511C611BD51F36732330D@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYNFOROOtTGhE/fSYar3xmaorVNlgAJoXlQ
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ingo Molnar
> there seem to be leaked preempt counts:
> 
>   <idle>-0     0.n.1 8974us : touch_critical_timing (cpu_idle)
> 
> we should never have preemption disabled in cpu_idle(). To 
> debug leaked 
> preemption counts, enable CONFIG_DEBUG_PREEMPT.

Something really fishy is going on here: 
That 9 ms latency seems to be really *idle* time!

* If the box is idle, I get that trace almost immediately, and
almost always with close to 9 ms (system clock is 100 Hz, 
i.e. 10 ms tick period).

* If the box is 100 % loaded, I don't get that trace. I get
different traces from different processes, mostly shorter than
9 ms.

* If I load the box with work at regular intervals 
and idle time in between, I get traces
identical to the 9 ms idle trace, but consistently shorter.
If I throw a flood ping with 1000 pkt/s against my box, the idle
trace shows up with 800 or 900 microseconds, i.e. the idle time
between packets.

Now, is the tracer wrong, or has the idle time a wrong status?

By the way, I had one trace today where the cat /proc/latency_trace
itself showed up:

      \   /    |||||   \   |   /           
     cat-3129  0D...    1us!: preempt_schedule_irq (svc_preempt)
     cat-3129  0.... 5502us+: rt_up (l_start)
     cat-3129  0D..1 5511us+: check_raw_flags (rt_up)
     cat-3129  0...1 5514us+: rt_up (l_start)
     cat-3129  0...1 5518us : sub_preempt_count_ti (rt_up)

What's happening in those 5 ms?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
