Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVLUHor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVLUHor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 02:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVLUHor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 02:44:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:30336 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932312AbVLUHoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 02:44:46 -0500
Date: Wed, 21 Dec 2005 08:43:46 +0100
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
Message-ID: <20051221074346.GA2398@elte.hu>
References: <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org> <1135106124.13138.339.camel@localhost.localdomain> <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com> <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu> <43A90225.4060007@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A90225.4060007@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Dumazet <dada1@cosmosbay.com> wrote:

> >while it could possibly be cleaned up a bit, it's one of the 
> >best-optimized subsystems Linux has. Most of the "unnecessary 
> >complexity" in SLAB is related to a performance or a debugging feature.  
> >Many times i have looked at the SLAB code in a disassembler, right next 
> >to profile output from some hot workload, and have concluded: 'I couldnt 
> >do this any better even with hand-coded assembly'.
> 
> Well, I miss a version of kmem_cache_alloc()/kmem_cache_free() that 
> wont play with IRQ masking.

sure, but adding this sure wont reduce complexity ;)

> The local_irq_save()/local_irq_restore() pair is quite expensive and 
> could be avoided for several caches that are exclusively used in 
> process context.

in any case, on sane platforms (i386, x86_64) an irq-disable is 
well-optimized in hardware, and is just as fast as a preempt_disable().

Combined with the fact that CLI/STI has no register side-effects, it can 
even be faster/cheaper, on x86 at least.

	Ingo
