Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWFUReS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWFUReS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWFUReS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:34:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1486 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750949AbWFUReR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:34:17 -0400
Date: Wed, 21 Jun 2006 10:27:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Chuck Ebbert <76306.1226@compuserve.com>, Ingo Molnar <mingo@elte.hu>,
       Jakub Jelinek <jakub@redhat.com>, Roland McGrath <roland@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
In-Reply-To: <200606211914.37137.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606211022300.5498@g5.osdl.org>
References: <200606210828_MC3-1-C30B-9D83@compuserve.com> <200606211914.37137.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jun 2006, Andi Kleen wrote:
> 
> My measurements show different - i get 60+ cycles on K8 and 150+ cycles
> on P4. That is with a full vsyscall around it. However it is still
> far better than CPUID, however slower than RDTSCP on those CPUs that support it.
> 
> I changed the CPUID fallback path to use LSL on x86-64

One note of warning: 

Playing "clever games" has a real tendency to suck badly eventually. I'm 
betting LSL is pretty damn low on any list of instructions to be optimized 
by the CPU core, so it would tend to always be microcoded, while other ops 
might get faster.

> Measuring this way is a bad idea because you get far too much 
> noise from the RDTSCs. Usually you need to put a a few thousands entry 
> loop inside the RDTSCP and devide the result by the loop count

And measuring that way isn't perfect either, because it tends to show you 
how well an instruction works in that particular instruction mix, but not 
necessarily in real life.

Benchmarking single instructions is simply damn hard. It's often better to 
try to find a real load where that particular sequence is important enough 
to be measurable at all, and then try the alternatives. Not perfect 
either, but if you can't find such a load, maybe you shouldn't be doing it 
in the first place.. And if you _can_ find such a real load, at least you 
measured something that was actually real.

		Linus
