Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWFURuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWFURuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWFURuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:50:55 -0400
Received: from ns.suse.de ([195.135.220.2]:48031 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751062AbWFURuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:50:54 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Date: Wed, 21 Jun 2006 19:50:47 +0200
User-Agent: KMail/1.9.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Ingo Molnar <mingo@elte.hu>,
       Jakub Jelinek <jakub@redhat.com>, Roland McGrath <roland@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200606210828_MC3-1-C30B-9D83@compuserve.com> <200606211914.37137.ak@suse.de> <Pine.LNX.4.64.0606211022300.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606211022300.5498@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606211950.47529.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 June 2006 19:27, Linus Torvalds wrote:
> 
> On Wed, 21 Jun 2006, Andi Kleen wrote:
> > 
> > My measurements show different - i get 60+ cycles on K8 and 150+ cycles
> > on P4. That is with a full vsyscall around it. However it is still
> > far better than CPUID, however slower than RDTSCP on those CPUs that support it.
> > 
> > I changed the CPUID fallback path to use LSL on x86-64
> 
> One note of warning: 
> 
> Playing "clever games" has a real tendency to suck badly eventually. I'm 
> betting LSL is pretty damn low on any list of instructions to be optimized 
> by the CPU core, so it would tend to always be microcoded, while other ops 
> might get faster.

Any way we use to get the current CPU number is microcoded.
Unless RDTSCP and CPUID LSL is not defined to flush any pipelines fortunately.
And with the cache it is not THAT critical.

> > Measuring this way is a bad idea because you get far too much 
> > noise from the RDTSCs. Usually you need to put a a few thousands entry 
> > loop inside the RDTSCP and devide the result by the loop count
> 
> And measuring that way isn't perfect either, because it tends to show you 
> how well an instruction works in that particular instruction mix, but not 
> necessarily in real life.
> 
> Benchmarking single instructions is simply damn hard. It's often better to 
> try to find a real load where that particular sequence is important enough 
> to be measurable at all, and then try the alternatives. Not perfect 
> either, but if you can't find such a load, maybe you shouldn't be doing it 
> in the first place.. And if you _can_ find such a real load, at least you 
> measured something that was actually real.

I benchmarked it in a faithful simulation of a x86-64 vsyscall

-Andi
