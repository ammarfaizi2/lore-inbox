Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310598AbSCPVHL>; Sat, 16 Mar 2002 16:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310611AbSCPVHB>; Sat, 16 Mar 2002 16:07:01 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22725 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S310598AbSCPVGm>; Sat, 16 Mar 2002 16:06:42 -0500
Date: Sat, 16 Mar 2002 14:05:17 -0700
Message-Id: <200203162105.g2GL5H914363@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: yodaiken@fsmlabs.com
Cc: Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020316134732.C21439@hq.fsmlabs.com>
In-Reply-To: <20020316113536.A19495@hq.fsmlabs.com.suse.lists.linux.kernel>
	<Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com.suse.lists.linux.kernel>
	<20020316115726.B19495@hq.fsmlabs.com.suse.lists.linux.kernel>
	<p73g0301f79.fsf@oldwotan.suse.de>
	<20020316125711.B20436@hq.fsmlabs.com>
	<20020316210504.A24097@wotan.suse.de>
	<20020316131219.C20436@hq.fsmlabs.com>
	<200203162027.g2GKRqf13432@vindaloo.ras.ucalgary.ca>
	<20020316134732.C21439@hq.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com writes:
> On Sat, Mar 16, 2002 at 01:27:52PM -0700, Richard Gooch wrote:
> > yodaiken@fsmlabs.com writes:
> > > On Sat, Mar 16, 2002 at 09:05:04PM +0100, Andi Kleen wrote:
> > > > That will hopefully change eventually because 2M pages are a bit help for
> > > > a lot of applications that are limited by TLB thrashing, but needs some 
> > > > thinking on how to avoid the fragmentation trap (e.g. I'm considering
> > > > to add a highmem zone again just for that and use rmap with targetted
> > > > physical freeing to allocating them) 
> > > 
> > > To me, once you have a G of memory, wasting a few meg on unused
> > > process memory seems no big deal.
> > 
> > I'm not happy to throw away 2 MiB per process. My workstation has 1
> > GiB of RAM, and 65 processes (and that's fairly low compared to your
> > average desktop these days, because I just use olwm and don't have a
> > fancy desktop or lots of windows). You want me to throw over 1/8th of
> > my RAM away?!?
> 
> Why not?  If you just ran vim on console you'd be more productive and
> not need all those worthless processes. 

Yeah, right.

> At 4KB/page and 8bytes/pte a
> 1G process will need at least 2MB of pte alone ! Add in the 4 layers,
> the software VM struct, ...

This isn't a dedicated bigass-image display box. It's a workstation.
It's where I read email, hack kernels, write visualisation tools and
stuff like that.

And I can afford a few MiB of RAM for PTE's and such for *the one
process which is mapping my huge data files*! That's effectively a
small, one-time cost. Every other process doesn't have a significant
PTE cost.

I'm not using my kernel as a device driver for an image display
programme. I'm using it run a box that's generally useful to me.

> > And in fact, isn't it going to be more than 2 MiB wasted per process?
> > For each shared object loaded, only partial pages are going to be
> > used. *My* libc is less than 700 KiB, so I'd be wasting most of a page
> > to map it in.
> 
> You're using a politically incorrect libc.

Yeah :-) Man it feels good.

> But sure, big pages are not always good.

Hm. With wide TLB's, what are the benefits to big pages? One
pathological case that hit me a few years back was a workload which
bounced around in VM in a pattern that really thrash the cache due to
aliasing. It wouldn't have been a problem if we had truly fully
set-associative caches, rather than N-way (where N is 2, 4 or 8
usually). But big pages won't help that much here (it's just a way of
reducing TLB thrash, but doesn't help with cache thrashing).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
