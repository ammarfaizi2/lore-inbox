Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbULIVQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbULIVQH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 16:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbULIVQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 16:16:00 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:9638 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261625AbULIVPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 16:15:47 -0500
From: kernel-stuff@comcast.net
To: Imanpreet Singh Arora <imanpreet@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question from Russells Spinlocks 
Date: Thu, 09 Dec 2004 21:15:46 +0000
Message-Id: <120920042115.25628.41B8C082000394E30000641C220076219400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Nov 22 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spinlocks are used in situations where multiple threads contend for a lock and they can possibly run on more than one CPU. Example - Thread A is executing on CPU-A, Thread B in executing on CPU-B. They contend for a lock L1.  A acquires the lock first. B tries (on CPU-B) to acquire the lock L1 and finds it is not free - so it just spins (executes a no-op kind of loop ) until Thread A relinquishes the lock L1. 
Spinlocks are used in cases where the operation performed under a lock is short one - takes very less time. In these type of cases, spinning is less costlier than sleeping which involves scheduler overhead.
So if we take out CPU-B from the above equation - there is no chance for Thread B to execute to contend for lock L1 without thread A going to sleep. That's why spinlocks are useless on 1 CPU machine.

 The comment about  atomic_t - It is due to the fact that some ( IA-32 for e.g.) architectures guarantees atomicity of integer operations for only 24 bits. So you could possibly manipulate only 24 out of the 32 bits atomically - that's the hardware guarantee. The comments reflect this fact. (Pointers are 32bits on IA32 so it applies to pointer as well.)

Correct me if I am wrong :) !

Parag


> 
> Hello there,
> 
>     I was reading Russell's guide on spinlocks, and I have some 
> questions regarding it.
> 
> 
>     Question-->    Russell says that in case of non-SMP machines 
> spinlocks don't exist _at_ALL_. Well they should do something don't they 
> like disable interrupts and premptations. I checked linux/spinlock well 
> they DO NOT do anything atleast not when DEBUG_SPINLOCKS == 0. My 
> understanding is that since they aren't used anywhere outside kernel and 
> drivers(?), they can't be prempted. At least that is what I have read.
> 
> 
> What does the comment about gcc while defining atomic_t signify?
>              --> What about the comment about the limit of 24 bits on 
> atomic_t?    
>              a)    Atomic operations on integers are guranteed only if 
> there value can be stored in 24 bits.
>              b)    Atomic operations are guranteed only if the pointer 
> has 8 MSbits set zero.
> 
> 
> -- 
> Imanpreet Singh Arora
> 
> Even if you are on the right track you are going to get runover if you just sit 
> there.
> 	-- Will Rogers
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
