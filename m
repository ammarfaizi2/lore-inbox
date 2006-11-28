Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756807AbWK1VgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbWK1VgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 16:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756821AbWK1VgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 16:36:03 -0500
Received: from smtp3.Stanford.EDU ([171.67.20.26]:8397 "EHLO
	smtp3.stanford.edu") by vger.kernel.org with ESMTP id S1756681AbWK1VgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 16:36:00 -0500
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <1164747854.15887.48.camel@cmn3.stanford.edu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu>
	 <20061128200927.GA26934@elte.hu>
	 <1164746224.15887.40.camel@cmn3.stanford.edu>
	 <1164747854.15887.48.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 13:35:55 -0800
Message-Id: <1164749755.15887.54.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 13:04 -0800, Fernando Lopez-Lezcano wrote:
> On Tue, 2006-11-28 at 12:37 -0800, Fernando Lopez-Lezcano wrote:
> > On Tue, 2006-11-28 at 21:09 +0100, Ingo Molnar wrote:
> > > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > > 
> > > > Hi, I'm trying out the latest -rt patch and getting alsa xruns when 
> > > > using jackd and jack clients. This is a sample from the output of 
> > > > qjackctl / jackd (jack 0.102.25, qjackctl 0.2.21):
> > > 
> > > > (            japa-4096 |#0): new 17 us maximum-latency wakeup.
> > > > (         beagled-3412 |#1): new 19 us maximum-latency wakeup.
> > > > (          IRQ 18-1081 |#1): new 26 us maximum-latency wakeup.
> > > > (             snd-4040 |#1): new 1107 us maximum-latency wakeup.
> > > > (            japa-4096 |#0): new 1445 us maximum-latency wakeup.
> > > > (            japa-4096 |#0): new 2110 us maximum-latency wakeup.
> > > > (        qjackctl-4038 |#1): new 2328 us maximum-latency wakeup.
> > > > (            japa-4096 |#0): new 2548 us maximum-latency wakeup.
> > > > (          IRQ 18-1081 |#0): new 10291 us maximum-latency wakeup.
> > > 
> > > hm, lets fix this. Could you enable tracing (on the yum rpm) via:
> > > 
> > > 	echo 1 > /proc/sys/kernel/trace_enabled
> > > 
> > > does /proc/latency_trace have any meaningful events included for such a 
> > > long delay? If not then it would be nice to rebuild the kernel with 
> > > CONFIG_LATENCY_TRACING - and in any case my previous suggestion holds 
> > > too: booting with maxcpus=1 to reproduce the latencies will give easier 
> > > to interpret latency traces. 
> > 
> > Sorry, it looks like it is an smp issue. Booting with maxcpus=1 reduces
> > the xrun reports significantly (only three so far but very short, in the
> > range of 0.029 to 0.041 ms). The long ones seem to have gone away, so
> > far...
> 
> Strange, I rebooted smp and I'm not seeing the very long xruns I was
> seeing before, only short ones as reported above. Here are some traces,
> but nothing that makes sense I think.
> 
> I'll turn off the machine and cold boot it...)

No difference, actually it looks like the regression re-regresses if I
enable the trace... Arghhh.

Toggling /proc/sys/kernel/trace_enabled makes the long xruns reported by
jack come and go. 

-- Fernando


