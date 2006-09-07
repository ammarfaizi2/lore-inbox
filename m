Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWIGCZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWIGCZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 22:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422659AbWIGCZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 22:25:26 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:35206 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1422658AbWIGCZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 22:25:25 -0400
Date: Thu, 7 Sep 2006 04:23:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-ID: <20060907022303.GG25473@stusta.de>
References: <200608302013.58122.ak@suse.de> <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de> <Pine.LNX.4.64.0609070115270.6761@scrub.home> <20060906235029.GC25473@stusta.de> <Pine.LNX.4.64.0609070202040.6761@scrub.home> <20060907003758.GD25473@stusta.de> <Pine.LNX.4.64.0609070245100.6761@scrub.home> <20060907010235.GE25473@stusta.de> <Pine.LNX.4.64.0609070313420.6761@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609070313420.6761@scrub.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 03:23:31AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 7 Sep 2006, Adrian Bunk wrote:
> 
> > > Define "full libc".
> > 
> > Everything described in clause 7 of ISO/IEC 9899:1999.
> 
> Its behaviour is also defined by the environment, so what gcc can assume 
> is rather limited and you have not shown a single example, that any such 
> assumption would be invalid for the kernel.

ISO/IEC 9899:1999 clause 7 defines the libc part of a hosted environment.

> > > Explain what exactly -ffreestanding fixes, which is not valid for the 
> > > kernel.
> > 
> > It's simply correct since the kernel doesn't provide everything 
> > described in clause 7 of ISO/IEC 9899:1999.
> > 
> > And it fixes compile errors caused by the fact that gcc is otherwise 
> > allowed to replace calls to any standard C function with semantically 
> > equivalent calls to other standard C functions - in a hosted environment 
> > the latter are guaranteed to be present.
> 
> The kernel uses standard C, so your point is?

A standard C freestanding environment or a standard C hosted environment?

> You already got two NACKs from arch maintainers, why the hell are you 
> still pushing this patch? The builtin functions are useful and you want to 

The same people who justified removing -ffreestanding with the "it was 
only added for x86-64, so dropping it should be safe" that has proven 
wrong now put their arch maintainers hats on for NACKing reverting this 
patch...

> force arch maintainers to have to enable every single one manually and 
> to maintain a list of these functions over multiple versions of gcc?

It could be done per architecture or globally for some functions.

And it doesn't sound like a bad idea to check the current code and think 
of what it does and what it should do -  many architecture specific 
things (like much of include/asm-i386/string.h) seem to be more 
historically than architecture specific.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

