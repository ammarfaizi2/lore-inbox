Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWHHISp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWHHISp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWHHISp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:18:45 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:19250 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S932565AbWHHISo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:18:44 -0400
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <200608080714.21151.ak@suse.de>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	 <20060807194159.f7c741b5.akpm@osdl.org>
	 <17624.7310.856480.704542@cargo.ozlabs.ibm.com>
	 <200608080714.21151.ak@suse.de>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 08 Aug 2006 10:17:53 +0200
Message-Id: <1155025073.26277.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 07:14 +0200, Andi Kleen wrote:
> > > > Drawback would be some more TLB misses.
> > > 
> > > yup.  On some (important) architectures - I'm not sure which architectures
> > > do the bigpage-for-kernel trick.
> > 
> > I looked at optimizing the per-cpu data accessors on PowerPC and only
> > ever saw fractions of a percent change in overall performance, which
> > says to me that we don't actually use per-cpu data all that much.  So
> > unless you make per-cpu data really really slow, I doubt that we'll
> > see any significant performance difference.
> 
> The main problem is that we would need a "vmalloc reserve first; allocate pages
> later" interface. On x86 it would be easy by just splitting up vmalloc/vmap a bit
> again. Does anybody else see problems with implementing that on any
> other architecture? 

"vmalloc reserve first; allocate pages later" would be a really nice
feature. We could use this on s390 to implement the virtual mem_map
array spanning the whole 64 bit address range (with holes in it). To
make it perfect a "deallocate pages; keep vmalloc reserve" should be
added, then we could free parts of the mem_map array again on hot memory
remove. 
I don't see a problem for s390.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


