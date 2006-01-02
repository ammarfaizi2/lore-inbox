Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWABOoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWABOoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 09:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWABOoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 09:44:10 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:15605 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750766AbWABOoJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 09:44:09 -0500
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
From: Daniel Walker <dwalker@mvista.com>
To: kus Kusche Klaus <kus@keba.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F36732330F@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F36732330F@MAILIT.keba.co.at>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 06:44:07 -0800
Message-Id: <1136213048.22548.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 15:39 +0100, kus Kusche Klaus wrote:
> > From: Daniel Walker
> > On Mon, 2006-01-02 at 08:57 +0100, kus Kusche Klaus wrote:
> > >   <idle>-0     0D...    1us+: preempt_schedule_irq (svc_preempt)
> > >   <idle>-0     0....    5us!: default_idle (cpu_idle)
> > >   <idle>-0     0D..1 8700us+: asm_do_IRQ (c021da48 1a 0)
> > 
> > Your trace appears to be showing an actual latency of 300us . 
> > The trace
> > starts at 8700us . The default_idle line above is showing 
> > interrupts are
> > enable, and preemption is enabled . So the tracing code 
> > really should be
> > ignoring the default_idle line since there is no reason to be 
> > tracing. 
> 
> Ok, thanks, fine.
> 
> I always thought that the output of the tracer always represents a 
> single block of latency (either interrupts or preemption disabled),
> from its beginning to its end.
> 
> Does that mean that any line with status "0...." is not dangerous
> at all w.r.t. latency?

The tracing isn't correct on ARM . It shouldn't show a max latency of
8700us when it's only 300us . I'm not saying there isn't a problem.

> If this is the case, then it should not only be excluded from the
> trace listing, but also from the total timings! The trace header says
> that this is a latency of 8964 us, and this also means that any
> latency shorter than that is not recorded by the tracer.
> 
> However, if the "real" latency of this trace is only 300 us, there
> are quite likely longer "real" latencies (at least, my own test
> programs strongly indicate that), and I'd like to see their traces
> and get the maximum "real" latency duration in the statistics (the
> interrupt latency histogram is also based on the values in the trace
> and not on the "real" latencies: It has a significant peak around
> 8800 us, and I certainly don't have that many int-off periods of
> 8800 us on my system!).

Right .. I'm still looking into it. ARM is just missing some vital
tracing bits I think .

Daniel


