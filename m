Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311638AbSCNPzF>; Thu, 14 Mar 2002 10:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311641AbSCNPyz>; Thu, 14 Mar 2002 10:54:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15114 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311638AbSCNPyu>; Thu, 14 Mar 2002 10:54:50 -0500
Date: Thu, 14 Mar 2002 10:53:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@suse.de>
cc: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre3aa2
In-Reply-To: <20020314133223.B19636@suse.de>
Message-ID: <Pine.LNX.3.96.1020314104230.9248A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Dave Jones wrote:

> On Thu, Mar 14, 2002 at 03:28:01AM +0100, Andrea Arcangeli wrote:
>  > Only in 2.4.19pre3aa2: 21_pte-highmem-f00f-1
>  > 
>  > 	vmalloc called before smp_init was an hack, right way
>  > 	is to use fixmap. CONFIG_M686 doesn't mean much these
>  > 	days, but it's ok and probably most vendors will use it
>  > 	for the smp kernels, so it will save 4096 of the vmalloc space.
>  > 	I just didn't wanted to clobber the code with || CONFIG_K7 ||
>  > 	CONFIG_... | ... given all the other f00f stuff is also
>  > 	conditional only to M686 and probably nobody bothered to compile
>  > 	it out for my same reason 
> 
>  Brian Gerst had a patch a few months back to introduce a CONFIG_F00F
>  if a relevant CONFIG_Mxxx was chosen[1]. It never got applied anywhere, but makes
>  more sense than the CONFIG_M686 we currently use. 
>  
> [1] 386/486/586. With addition of my Vendor choice menu, we could even further
>     narrow it down to Intel only.

  Since vendors (and consultants) like to build a single kernel for use on
multiple machines, it would be nice if this could be done by some init
code (released) and a module. I don't know what the overhead would be,
perhaps the runtime code is so small it's not worth doing. Does that mean
it's not worth doing the option either? It certainly would seen desirable
to check for the F00F bug and if the code to handle it was not present
refuse to boot right away.

  The code actually looks so small as to be unworthy of an option, given
that many people would set it off not knowing was it was much less whether
they needed it. This is not like a missing FPU where you can do a graceful
reject of the instructions, if you have the bug and not the fix you are
vulnerable to sudden total failures, correct?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

