Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131171AbRCKGcq>; Sun, 11 Mar 2001 01:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131273AbRCKGcg>; Sun, 11 Mar 2001 01:32:36 -0500
Received: from linuxcare.com.au ([203.29.91.49]:48906 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131171AbRCKGcU>; Sun, 11 Mar 2001 01:32:20 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sun, 11 Mar 2001 17:26:29 +1100
To: Jonathan Lahr <lahr@sequent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability
Message-ID: <20010311172629.D1951@linuxcare.com>
In-Reply-To: <20010215104656.A6856@w-lahr.des.sequent.com> <20010305113807.A3917@linuxcare.com> <20010306144552.G6451@w-lahr.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010306144552.G6451@w-lahr.des.sequent.com>; from lahr@sequent.com on Tue, Mar 06, 2001 at 02:45:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 
> Thanks for looking into postgresql/pgbench related locking.  Yes, 
> apparently postgresql uses a synchronization scheme that uses select()
> to effect delays for backing off while attempting to acquire a lock.
> However, it seems to me that runqueue lock contention was not entirely due 
> to postgresql code, since it was largely alleviated by the multiqueue 
> scheduler patch.

Im not saying that the multiqueue scheduler patch isn't needed, just that
this test case is caused by a bug in postgres. We shouldn't run around
fixing symptoms - dropping the contention in the runqueue lock might not
change the overall performance of the benchmark, on the other hand
fixing the spinlocks in postgres probably will.

On the other hand, if postgres still pounds on the runqueue lock after
the bug has been fixed then we need to look at the multiqueue patch.

Cheers,
Anton
