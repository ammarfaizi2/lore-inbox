Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTDXSoo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbTDXSoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:44:44 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:60059 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261783AbTDXSoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:44:44 -0400
Message-ID: <3EA8336F.2000609@colorfullife.com>
Date: Thu, 24 Apr 2003 20:56:47 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bob <bob@watson.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: RE: [patch] printk subsystems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert wrote:

>There is both a qualitative difference and quantitative difference in a
>lockless algorithm as described versus one that uses locking.  Most
>importantly for Linux, these algorithms in practice have better performance
>characteristics.
>
Do you have benchmark numbers that compare "lockless" and locking 
algorithms on large MP systems?

For example, how much faster is one 'lock;cmpxchg' compared to 
'spin_lock();if (x==var) var = y;spin_unlock();'.

So far I assumed that for spinlock that are only held for a few cycles, 
the cacheline trashing dominates, and not the spinning.
I've avoided to replace spin_lock+inc+spin_unlock with atomic_inc(). 
(Just look at the needed memory barriers: smp_mb__after_clear_bit & friends)

RCU uses per-cpu queues that are really lockless and avoid the cache 
trashing, that is a real win.

--
    Manfred

