Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUA3NF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 08:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUA3NFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 08:05:25 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40632 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263800AbUA3NFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 08:05:20 -0500
Date: Fri, 30 Jan 2004 10:29:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040130092939.GB3841@elte.hu>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org> <40194B6D.6060906@redhat.com> <20040129191500.GA1027@mail.shareable.org> <4019A5D2.7040307@redhat.com> <20040130041708.GA2816@mail.shareable.org> <4019E713.1010107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4019E713.1010107@redhat.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin 2.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ulrich Drepper <drepper@redhat.com> wrote:

> If gettimeofday() is the only optimized syscall, just add a simple
> 
>   cmp $__NR_gettimeofday, %eax
>   je  __vsyscall_gettimeofday
> 
> to the __kernel_vsyscall code.  With correct static branch prediction
> you'll not be able to measure the effect.  The correct way is IMO to
> completely hide the optimizations since otherwise the increased
> dependencies between kernel and libc only create more friction and
> cost and loss of speed.

agreed 100%. Once the # of vsyscalls grows to above a certain treshold,
a table can be used just like we do in kernel-mode.

but i'm a bit worried about the apparent fact that adding 200 more
symbols (and making the vDSO a real DSO in essence) to abstract the
kernel syscalls is apparently unacceptable performance-wise. If this is
true then the whole dynamic linking architecture is much slower than it
should be, isnt it? Why cannot the same argument be made about the ~1400
symbols libc itself provides? Wouldnt a tighter libc API avoid all the
overhead (in fact 7x overhead) you described wrt. adding 200+ kernel
symbols? Why is the kernel vDSO so special [assuming, for the sake of
argument, a clean, versioned function API between libc and the kernel
vDSO]?

	Ingo
