Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVGaP44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVGaP44 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 11:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVGaP44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 11:56:56 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:24278 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261682AbVGaP4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 11:56:53 -0400
Date: Sun, 31 Jul 2005 11:56:50 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-05
In-reply-to: <20050731104418.GA5318@elte.hu>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Message-id: <200507311156.50150.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050730160345.GA3584@elte.hu> <1122796996.15033.9.camel@twins>
 <20050731104418.GA5318@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 July 2005 06:44, Ingo Molnar wrote:
>* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>> because end_buffer_async_read/write use bit_spin_(un)lock and I do
>> not know how those interact with -RT.
>
>bit_spin_lock is preemptible too - but it's not a too nice
> construct. What seems to have happened in your trace is that
> local_irq_disable() was used too in combination with bit-spinlocks,
> and a spinlock was taken from within it. The best fix would be to
> get rid of bit-spinlocks ...
>
> Ingo

And that refuses to build here, mode 4 for 52-05:

fs/nfsd/nfs4state.c:125: error: `SPIN_LOCK_UNLOCKED' undeclared here 
(not in a function)
make[2]: *** [fs/nfsd/nfs4state.o] Error 1
make[1]: *** [fs/nfsd] Error 2
make: *** [fs] Error 2

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
