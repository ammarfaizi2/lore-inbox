Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136401AbREDOe6>; Fri, 4 May 2001 10:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136403AbREDOes>; Fri, 4 May 2001 10:34:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:10571 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136401AbREDOeh>; Fri, 4 May 2001 10:34:37 -0400
Date: Fri, 4 May 2001 16:33:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010504163359.F3762@athlon.random>
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru> <20010503192848.V1162@athlon.random> <20010504131528.A2228@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010504131528.A2228@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, May 04, 2001 at 01:15:28PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 01:15:28PM +0400, Ivan Kokshaysky wrote:
> However, there are 3 reasons why I prefer 16-bit counters:

I assume you mean 32bit counter. (that gives max 2^16 sleepers)

> a. "max user processes" ulimit is much lower than 64K anyway;

the 2^16 limit is not a per-user limit it is a global one so the max
user process ulimit is irrelevant.

Only the number of pid and the max number of tasks supported by the
architecture is a relevant limit for this.

> b. "long" count would cost extra 8 bytes in the struct rw_semaphore;

correct but that's the "feature" to be able to support 2^32 concurrent
sleepers at not relevant runtime cost 8).

> c. I can use existing atomic routines which deal with ints.

I was thinking at a dedicated routine that implements the slow path by
hand as well like x86 just do. Then using ldq instead of ldl isn't
really a big deal programmer wise.

Andrea
