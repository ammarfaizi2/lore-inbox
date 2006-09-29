Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422834AbWI2VpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422834AbWI2VpE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422835AbWI2VpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:45:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:53965 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422834AbWI2VpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:45:02 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] fix !apic build breakage
Date: Fri, 29 Sep 2006 23:44:55 +0200
User-Agent: KMail/1.9.3
Cc: Jim Cromie <jim.cromie@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609292258.24546.ak@suse.de> <20060929211417.GA11834@elte.hu>
In-Reply-To: <20060929211417.GA11834@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609292344.55363.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> so please do it. The fact that there are /other/ reductions possible 
> doesnt mean we can be lax. 

Well with that argument we would put ifdefs nearly everywhere
because most subsystem have some code that you don't need in some
obscure configuration.

Do we do that? No. Clean and maintainable code is more important.

This particular case of APIC CONFIG is just a historical ward.
I eliminated it on 64bit a long time ago (and it undoubtedly
saved me hours of fixing compilation issues and it made the code
cleaner too) and i386 is definitely ripe for that soon too.

> It's like: "oh, the buddy allocator scales  
> better now, so we can slow down the SLAB allocator". No, kernel size is 
> like scalability: we need a million small steps.

Sure you could do a million steps. Just for each step you need 
to look at the ratio of maintainability impact:usefulness
IMHO microconfig loses there usually badly.

[As terminology i call microconfig anything that requires ifdefs 
inside .c or .h files. CONFIGs that only appear in Makefiles are usually
not a problem]

There are lots of other steps to less bloat that make sense, but please don't
advocate that microCONFIG disease.

> the panic_on_unrecovered_nmi thing is gross anyway: it has no place in 
> kernel.h, it should go into include/[asm-i386|x86_64]/nmi.h and not the 
> generic headers. There the prototype can be made #ifdef APIC, hence 
> eliminating the #ifdefs from traps.c. (that's all we care about anyway)

Yes I fixed it already in a cleaner way (without ugly ifdefs) 

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/nmi-sysctl-cleanup
 
> please dont throw away a perfectly fine config option.

I can't count how many that silly option already got broken by 
changes in the APIC code. I definitely wouldn't describe it as "perfectly fine",
more as "fragile and tends to fall over when you even look at it".

-Andi
