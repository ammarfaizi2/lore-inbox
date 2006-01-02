Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWABOjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWABOjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 09:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWABOjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 09:39:37 -0500
Received: from general.keba.co.at ([193.154.24.243]:54392 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1750731AbWABOjh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 09:39:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Date: Mon, 2 Jan 2006 15:39:30 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F36732330F@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYPpuxTaNLnsYnjQyyVwAViByyANQAADkVg
From: "kus Kusche Klaus" <kus@keba.com>
To: "Daniel Walker" <dwalker@mvista.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Walker
> On Mon, 2006-01-02 at 08:57 +0100, kus Kusche Klaus wrote:
> >   <idle>-0     0D...    1us+: preempt_schedule_irq (svc_preempt)
> >   <idle>-0     0....    5us!: default_idle (cpu_idle)
> >   <idle>-0     0D..1 8700us+: asm_do_IRQ (c021da48 1a 0)
> 
> Your trace appears to be showing an actual latency of 300us . 
> The trace
> starts at 8700us . The default_idle line above is showing 
> interrupts are
> enable, and preemption is enabled . So the tracing code 
> really should be
> ignoring the default_idle line since there is no reason to be 
> tracing. 

Ok, thanks, fine.

I always thought that the output of the tracer always represents a 
single block of latency (either interrupts or preemption disabled),
from its beginning to its end.

Does that mean that any line with status "0...." is not dangerous
at all w.r.t. latency?

If this is the case, then it should not only be excluded from the
trace listing, but also from the total timings! The trace header says
that this is a latency of 8964 us, and this also means that any
latency shorter than that is not recorded by the tracer.

However, if the "real" latency of this trace is only 300 us, there
are quite likely longer "real" latencies (at least, my own test
programs strongly indicate that), and I'd like to see their traces
and get the maximum "real" latency duration in the statistics (the
interrupt latency histogram is also based on the values in the trace
and not on the "real" latencies: It has a significant peak around
8800 us, and I certainly don't have that many int-off periods of
8800 us on my system!).

So, what should I change in order to have only "real" latency timings
and to get the trace with the maximum "real" latency recorded?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
