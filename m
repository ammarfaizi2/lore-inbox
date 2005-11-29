Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVK2Wnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVK2Wnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 17:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVK2Wnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 17:43:49 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37074 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932444AbVK2Wnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 17:43:49 -0500
Date: Tue, 29 Nov 2005 23:43:47 +0100
From: Andi Kleen <ak@suse.de>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129224346.GS19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <1133303615.3271.12.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133303615.3271.12.camel@entropy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you really need to come up with a better justification than "I
> think this will be useful" for a permanent user-space ABI change.

There's no user space ABI change involved, at least not from
the kernel side. Hardware is breaking some assumptions people
made though (they actually never worked fully, but these days they
break more clearly) and this is a best effort to adapt.

To give an bad analogy RDTSC usage in the last years is
like explicit spinning wait loops for delays in the earlier
times. They tended to work on some subset of computers,
but were always bad and caused problems and people eventually learned
it was better to use operating system services for this.

The kernel will probably not disable RDTSC outright,
but will make it clear in documentation that it's a bad
idea to use directly and laugh at everybody who runs
into problems with it.

oprofile usage might change slightly though, although only
for a small subset of its users. There can't be very many
of them using multiple performance counters anyways because
at least in the last 0.9 release I tried it didn't even work.

> What problem are you trying to solve, why is that a problem, how does
> making PMC0 always be a cycle counter solve that, what makes you think

Read the original messages in the thread. They explain it all.

> that future CPUs will have the same type of cycle counter that behaves
> the same way as the current cycle counters, etc.
> 
> AFAICT, the problem you're trying to solve is two-fold:
> 
> a) RDTSC is serializing and RDPMC isn't.
> 
> Which is nicely solved by RDTSCP.

No, you got that totally wrong. Please read the RDTSCP specification again.

> and
> b) RDTSC isn't well defined.

It's well defined - but in a way that makes it useless for cycle
measurements these days.

> 
> Well, RDPMC isn't defined at all. You're assuming that future processor
> revisions will have the same or substantially similar PerfCtrs as
> current processors, and nothing guarantees that at all.

Point, but i guess it is reasonable to assume that future x85 CPUs
will have cycle counter perfctrs.  I cannot imagine anybody dropping
such a basic facility.

-Andi

