Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292841AbSCPU3v>; Sat, 16 Mar 2002 15:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310585AbSCPU3l>; Sat, 16 Mar 2002 15:29:41 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:13765 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S292841AbSCPU3f>; Sat, 16 Mar 2002 15:29:35 -0500
Date: Sat, 16 Mar 2002 13:27:52 -0700
Message-Id: <200203162027.g2GKRqf13432@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: yodaiken@fsmlabs.com
Cc: Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020316131219.C20436@hq.fsmlabs.com>
In-Reply-To: <20020316113536.A19495@hq.fsmlabs.com.suse.lists.linux.kernel>
	<Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com.suse.lists.linux.kernel>
	<20020316115726.B19495@hq.fsmlabs.com.suse.lists.linux.kernel>
	<p73g0301f79.fsf@oldwotan.suse.de>
	<20020316125711.B20436@hq.fsmlabs.com>
	<20020316210504.A24097@wotan.suse.de>
	<20020316131219.C20436@hq.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com writes:
> On Sat, Mar 16, 2002 at 09:05:04PM +0100, Andi Kleen wrote:
> > That will hopefully change eventually because 2M pages are a bit help for
> > a lot of applications that are limited by TLB thrashing, but needs some 
> > thinking on how to avoid the fragmentation trap (e.g. I'm considering
> > to add a highmem zone again just for that and use rmap with targetted
> > physical freeing to allocating them) 
> 
> To me, once you have a G of memory, wasting a few meg on unused
> process memory seems no big deal.

I'm not happy to throw away 2 MiB per process. My workstation has 1
GiB of RAM, and 65 processes (and that's fairly low compared to your
average desktop these days, because I just use olwm and don't have a
fancy desktop or lots of windows). You want me to throw over 1/8th of
my RAM away?!?

And in fact, isn't it going to be more than 2 MiB wasted per process?
For each shared object loaded, only partial pages are going to be
used. *My* libc is less than 700 KiB, so I'd be wasting most of a page
to map it in.

I want that 1 GiB of RAM to be used to cache most of my data. Those
NASA 1km/pixel satellite mosaics of the world are pretty big, you know
(21600x21600x3 per hemisphere:-).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
