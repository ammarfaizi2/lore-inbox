Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVK2XRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVK2XRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVK2XRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:17:53 -0500
Received: from cantor2.suse.de ([195.135.220.15]:34773 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750973AbVK2XRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:17:52 -0500
Date: Wed, 30 Nov 2005 00:17:50 +0100
From: Andi Kleen <ak@suse.de>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129231750.GU19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <1133303615.3271.12.camel@entropy> <20051129224346.GS19515@wotan.suse.de> <1133305338.3271.30.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133305338.3271.30.camel@entropy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 03:02:18PM -0800, Nicholas Miell wrote:
> On Tue, 2005-11-29 at 23:43 +0100, Andi Kleen wrote:
> > > I think you really need to come up with a better justification than "I
> > > think this will be useful" for a permanent user-space ABI change.
> > 
> > There's no user space ABI change involved, at least not from
> > the kernel side. Hardware is breaking some assumptions people
> > made though (they actually never worked fully, but these days they
> > break more clearly) and this is a best effort to adapt.
> 
> Yes there is, you're allowing userspace usage of RDPMC and you're
> guaranteeing that PMC0 will always be a cycle counter. The RDPMC usage

Well, it doesn't change any existing ABIs.

> is benign (assuming you make a note somewhere that future versions of
> Linux might disable both RDPMC and RDTSC(P) to prevent timing-channel
> attacks), but that "PMC0 is a cycle counter" guarantee will probably
> come back to haunt you.

There are no plans that i Know of to disable them.
Also even if someone decided to disable them they could always
trap and emulate them.

> 
> > To give an bad analogy RDTSC usage in the last years is
> > like explicit spinning wait loops for delays in the earlier
> > times. They tended to work on some subset of computers,
> > but were always bad and caused problems and people eventually learned
> > it was better to use operating system services for this.
> 
> And you are now suggesting people should use RDPMC instead of OS
> services?

For any kind of timers they should use the OS service 
(gettimeofday/clock_gettime). The OS will go to extraordinary
means to make it as fast as possible, but when it's slow
then because it's not possible to do it faster accurately
(that's the case right now modulo one possible optimization)

For cycle counting where they previously used RDTSC they should
use RDPMC 0 now.

> That chart contains incompatible variations for pre-B, B, and C revision
> processors and (among other strange things) includes instructions for
> the monitoring of segment register loads to the HS register.
> 
> Everything is telling me that this is not something AMD intends to keep
> stable and it isn't even something they're interested in documenting
> very well at all.

There are obscure performance counters and then there are basic
fundamental performance counters. That particular counter hasn't
changed since the K7 days (and K6 didn't have performance counters) 

Intel also always had an equivalent one.  Unless they go to clockless
CPUs or something I think it's likely they will keep a counter like
this.

Also we'll let them know that we would like them to keep such a counter 
around.

You're right that many other performance counters are not so stable.

-Andi
