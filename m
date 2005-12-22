Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbVLVVMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbVLVVMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVLVVMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:12:41 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:37510 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965181AbVLVVMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:12:39 -0500
Date: Thu, 22 Dec 2005 22:11:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
Message-ID: <20051222211132.GA21742@elte.hu>
References: <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org> <1135106124.13138.339.camel@localhost.localdomain> <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com> <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu> <43A90225.4060007@cosmosbay.com> <20051221074346.GA2398@elte.hu> <43A90C07.4000003@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A90C07.4000003@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Dumazet <dada1@cosmosbay.com> wrote:

> >in any case, on sane platforms (i386, x86_64) an irq-disable is 
> >well-optimized in hardware, and is just as fast as a preempt_disable().
> 
> I'm afraid its not the case on current hardware.
> 
> The irq enable/disable pair count for more than 50% the cpu time spent 
> in kmem_cache_alloc()/kmem_cache_free()/kfree()

because you are not using NMI based profiling?

> oprofile results on a dual Opteron 246 :
> 
> You can see the high profile numbers right after cli and popf(sti) 
> instructions, popf being VERY expensive.

that's just the profiling interrupt hitting them. You should not analyze 
irq-safe code with a non-NMI profiling interrupt.

CLI/STI is extremely fast. (In fact in the -rt tree i'm using them 
within mutexes instead of preempt_enable()/preempt_disable(), because 
they are faster and generate less register side-effect.)

	Ingo
