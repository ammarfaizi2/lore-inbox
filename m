Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318154AbSHKJF6>; Sun, 11 Aug 2002 05:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318155AbSHKJF6>; Sun, 11 Aug 2002 05:05:58 -0400
Received: from dsl-213-023-020-163.arcor-ip.net ([213.23.20.163]:12187 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318154AbSHKJF6>;
	Sun, 11 Aug 2002 05:05:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 19/21] introduce L1_CACHE_SHIFT_MAX
Date: Sun, 11 Aug 2002 11:11:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
References: <3D5614DC.635ED602@zip.com.au>
In-Reply-To: <3D5614DC.635ED602@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dokf-0001f5-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 August 2002 09:40, Andrew Morton wrote:
> zone->lock and zone->lru_lock are two of the hottest locks in the
> kernel.  Their usage patterns are quite independent.  And they have
> just been put into the same structure.  It is essential that they not
> fall into the same cacheline.
> 
> That could be fixed by padding with L1_CACHE_BYTES.  But the problem
> with this is that a kernel which was configured for (say) a PIII will
> perform poorly on SMP PIV.  This will cause problems for kernel
> vendors.  For example, RH currently ship PII and Athlon binaries.  To
> get best SMP performance they will end up needing to ship a lot of
> differently configured kernels.
> 
> To solve this we need to know, at compile time, the maximum L1 size
> which this kernel will ever run on.
> 
> This patch adds L1_CACHE_SHIFT_MAX to every architecture's cache.h.
> 
> Of course it'll break when newer chips come out with increased
> cacheline sizes.   Better suggestions are welcome.

I think you're being too paranoid.  You pushed the performance degradation 
from the PIV to the PIII (because it will tend to hit more cachelines than it 
should) and you won't be able to build a kernel that is optimal for the PIII 
any more.  I'd say that is PIII kernel is *supposed* to suck to some degree 
when run on a PIV, otherwise why bother having the PIV option?

I expect the performance difference you're talking about is marginal anyway.  
Maybe you've measured it?

-- 
Daniel
