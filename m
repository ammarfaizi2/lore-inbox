Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWBWSCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWBWSCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWBWSCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:02:12 -0500
Received: from fmr19.intel.com ([134.134.136.18]:46278 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751693AbWBWSCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:02:10 -0500
Message-ID: <43FDF88F.4030501@linux.intel.com>
Date: Thu, 23 Feb 2006 19:01:51 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <1140707358.4672.67.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230843020.3771@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602230843020.3771@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 23 Feb 2006, Arjan van de Ven wrote:
>> I think that to get to a better list we need to invite people to submit
>> their own profiles, and somehow add those all up and base the final list on
>> that. I'm willing to do that effort if this is ends up being the prefered
>> approach. Such an effort probably needs to be repeated like once a year or
>> so to adopt to the changing nature of the kernel.
> 
> I suspect we need architecture-specific profiles.
> 
> For example, on x86(-64), memcpy() is mostly inlined for the interesting 
> cases. That's not always so. Other architectures will have things like the 
> page copying and clearing as _the_ hottest functions. Same goes for 
> architecture-specific things like context switching etc, that have 
> different names on different architectures.
> 
> So putting the profile data in scripts/ doesn't sound very good.

ok fair enough; that's easy to fix.


> That said, this certainly seems simple enough. I'd like to hear about 
> actual performance improvements with it before I'd apply anything like 
> this.

the results were sort of inconclusive (eg some wins, but some losses, 
but mostly in the noise) in the "large" run done by the perf guys, so 
I'm hoping to get another slot in testing soonish.

> 
> Also, since it's quite possible that being dense in the I$ is more of an 
> issue than being dense in the TLB (especially since almost everybody has 
> super-pages for kernel TLB entries and thus uses just a single entry - or 
> maybe a couple - for the kernel), it would probably make sense to try to 
> take calling patterns into account some way.

or keep the existing order for a "hot set", but move all the cold ones 
out. That way it'll at least not be worse than today
