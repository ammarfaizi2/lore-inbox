Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWBWQtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWBWQtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWBWQtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:49:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750801AbWBWQtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:49:00 -0500
Date: Thu, 23 Feb 2006 08:48:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
In-Reply-To: <1140707358.4672.67.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0602230843020.3771@g5.osdl.org>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
 <1140707358.4672.67.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Feb 2006, Arjan van de Ven wrote:
> 
> I think that to get to a better list we need to invite people to submit
> their own profiles, and somehow add those all up and base the final list on
> that. I'm willing to do that effort if this is ends up being the prefered
> approach. Such an effort probably needs to be repeated like once a year or
> so to adopt to the changing nature of the kernel.

I suspect we need architecture-specific profiles.

For example, on x86(-64), memcpy() is mostly inlined for the interesting 
cases. That's not always so. Other architectures will have things like the 
page copying and clearing as _the_ hottest functions. Same goes for 
architecture-specific things like context switching etc, that have 
different names on different architectures.

So putting the profile data in scripts/ doesn't sound very good.

That said, this certainly seems simple enough. I'd like to hear about 
actual performance improvements with it before I'd apply anything like 
this.

Also, since it's quite possible that being dense in the I$ is more of an 
issue than being dense in the TLB (especially since almost everybody has 
super-pages for kernel TLB entries and thus uses just a single entry - or 
maybe a couple - for the kernel), it would probably make sense to try to 
take calling patterns into account some way.

That's true of TLB usage too (in the absense of super-pages), of course.

But numbers talk.

		Linus
