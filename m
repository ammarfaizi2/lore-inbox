Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbTJAGON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 02:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbTJAGON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 02:14:13 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:35462 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261979AbTJAGOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 02:14:07 -0400
Date: Wed, 1 Oct 2003 07:13:48 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jun.nakajima@intel.com, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001061348.GE1131@mail.shareable.org>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com> <20031001053833.GB1131@mail.shareable.org> <20030930224853.15073447.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930224853.15073447.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > Doesn't refusing to boot seem to heavy handed for this bug?  The buggy
> > CPUs have been around for many years (it is practically the entire AMD
> > line for the last 4 years or so), and nobody in userspace has
> > complained about the 2.4 behaviour so far.  (Linux 2.4 behaviour is,
> > of course, to ignore the errata).
> 
> That is the case at present.  But the 2.6 kernel was hitting this
> erracularity daily.

We're talking about what to offer userspace now...  I think we all
agree that the kernel itself shouldn't be allowed to hit it, one way
or another.

> If some smart cookie decides to add prefetches to some STL implementation
> or something, they are likely to start hitting it with the same frequency.

Especially now that GCC has intrinsics for prefetches, and GCC's
optimiser can generate prefetches automatically (-fprefetch-loop-arrays).

But if they assume the kernel hides it, they'll still hit it on any of
the huge installed base of <=4 year old AMD boxes running 2.2 and 2.4.

Ideally, userspace should just not compile with prefetch if they think
they might run on one of those - or select different code at run time
- it is not so different from the constraints which say SSE code
simply won't run on some CPUs or old kernels anyway.  (prefetch is
worse on a P5 than a K7 - it'll throw an illegal opcode exception :)

I understand you're advocating a policy that says we can't do anything
about old systems, but from 2.6 onwards apps can depend on not being
hit by that erratum in userspace, is that right?

-- Jamie
