Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVKXPg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVKXPg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVKXPg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:36:57 -0500
Received: from mail.suse.de ([195.135.220.2]:20635 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932168AbVKXPg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:36:56 -0500
Date: Thu, 24 Nov 2005 16:36:35 +0100
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124153635.GJ20775@brahms.suse.de>
References: <20051123165923.GJ20775@brahms.suse.de> <1132783243.13095.17.camel@localhost.localdomain> <20051124131310.GE20775@brahms.suse.de> <m1zmnugom7.fsf@ebiederm.dsl.xmission.com> <20051124133907.GG20775@brahms.suse.de> <1132842847.13095.105.camel@localhost.localdomain> <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain> <20051124145518.GI20775@brahms.suse.de> <m1psoqgk18.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psoqgk18.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 08:09:07AM -0700, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > On Thu, Nov 24, 2005 at 03:15:24PM +0000, Alan Cox wrote:
> >> On Iau, 2005-11-24 at 15:22 +0100, Andi Kleen wrote:
> >> > What do you need a special driver for if the northbridge just
> >> > can do the scrubbing by itself?
> >> 
> >> You need a driver to collect and report all the ECC single bit errors to
> >> the user so that they can decide if they have problem hardware.
> >
> > Assuming the errors are logged to the standard machine check
> > architecture that's already done by mce.c. K8 does that definitely.
> >
> > Take a look at mcelog at some point.
> > Your distro probably already sets it up by default to log to
> > /var/log/mcelog
> >
> >> 
> >> EDAC is more than one thing
> >> 	- Control response to a fatal error
> >> 	- Report non-fatal events for analysis/user decision making
> >
> > x86-64 mce.c does all that There was even a port to i386 around at some point.
> 
> Right on the k8 memory controller there is a lot of overlap,
> with what has already been implemented.  For all other x86 memory
> controllers the code is filling a large void.  

At least the Lindenhurst (E7205) datasheet says the chipset can trigger
MCEs in the CPU (using a MCEERR# pin). I don't know if it's always
enabled, but the hardware seems to have the capability.
That's the oldest Intel server chipset supported with EM64T CPUs.

The threshold counters are not supported directly only.


> The current k8
> code has been delayed for this reason.
> 
> Where the EDAC code goes beyond the current k8 facilities is the
> decode to the dimm level so that the bad memory stick can be
> easily identified.

That would be nice to have agreed. But I don't really know
how to do this without mainboard specific knowledge.
If you have something usable it's best to port it to mce.c
or perhaps mcelog

> 
> One of the goals of the EDAC code is to work towards a unified
> kernel architecture for this kind error reporting.  Currently every
> architecture (if the error are reported at all) handles this
> differently which makes it very hard to do something sane is
> user space.

There is a clear case for being architecture specific here. Some 
architectures - like PPC64 or IA64 - have good firmware support for it, so it's
best to use these facilities. On others like i386 and
x86-64 the x86-64 log architecture is good. I might be a bit
biased but I think it's very good and should be used on i386
at some point too. I don't see any need for more.

-Andi

