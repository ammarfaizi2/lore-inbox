Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135959AbREDJQt>; Fri, 4 May 2001 05:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135987AbREDJQj>; Fri, 4 May 2001 05:16:39 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:3590 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S135959AbREDJQ1>; Fri, 4 May 2001 05:16:27 -0400
Date: Fri, 4 May 2001 13:15:28 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010504131528.A2228@jurassic.park.msu.ru>
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru> <20010503192848.V1162@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010503192848.V1162@athlon.random>; from andrea@suse.de on Thu, May 03, 2001 at 07:28:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 07:28:48PM +0200, Andrea Arcangeli wrote:
> I'd love if you could port it on top of this one and to fix it so that
> it can handle up to 2^32 sleepers and not only 2^16 like we have to do
> on the 32bit archs to get good performance:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4aa3/00_rwsem-11

It could be done without much pain for both "official" and your rwsem
implementations.
However, there are 3 reasons why I prefer 16-bit counters:
a. "max user processes" ulimit is much lower than 64K anyway;
b. "long" count would cost extra 8 bytes in the struct rw_semaphore;
c. I can use existing atomic routines which deal with ints.

Actually I'm more anxious about a __builtin_expect() problem,
and I'd like to hear Richard's comment on this...

Ivan.
