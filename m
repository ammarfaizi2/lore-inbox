Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVL3KfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVL3KfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 05:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVL3KfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 05:35:25 -0500
Received: from general.keba.co.at ([193.154.24.243]:2605 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1751243AbVL3KfZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 05:35:25 -0500
Content-class: urn:content-classes:message
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 30 Dec 2005 11:35:22 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <AAD6DA242BC63C488511C611BD51F36732330A@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYNFOROOtTGhE/fSYar3xmaorVNlgAFbRlA
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

I enabled CONFIG_DEBUG_PREEMPT.

I still have that latency trace in <idle>-0 with that line at the end.
In fact, it is the most common trace on this system: 
I always get that trace immediately after resetting the latency 
tracer, always close to 9 ms (until an even longer latency happens).

Moreover, I looked up the address shown in asm_do_IRQ in the second
line of all those traces.
<idle>-0     0D..1    1us!: touch_critical_timing (default_idle)
<idle>-0     0D..2 8841us+: asm_do_IRQ (c021da44 1a 0)
It is always the same address, and it is in "cpu_idle".

However, CONFIG_DEBUG_PREEMPT remains silent: No bugs, no warns,
just plain nothing in the syslog.

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
