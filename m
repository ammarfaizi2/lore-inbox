Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270817AbTHFRWK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270765AbTHFRWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:22:10 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:17067 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S270817AbTHFRVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:21:23 -0400
Message-ID: <3F31390B.2000605@colorfullife.com>
Date: Wed, 06 Aug 2003 19:21:15 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Scott L. Burson" <gyro@zeta-soft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP performance problem in 2.4 (was: Athlon spinlock performance)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott wrote:

>The problem is in `try_to_free_pages' and its associated routines,
>`shrink_caches' and `shrink_cache', in `mm/vmscan.c'.  After I made some
>changes to greatly reduce lock contention in the slab allocator and
>`shrink_cache',
>
How did you change the slab locking?

> and then instrumented `shrink_cache' to see what it was
>doing, the problem showed up very clearly.
>
>In one approximately 60-second period with the problematic workload running, 
>`try_to_free_pages' was called 511 times.  It made 2597 calls to
>`shrink_caches', which made 2592 calls to `shrink_cache' (i.e. it was very
>rare for `kmem_cache_reap' to release enough pages itself).
>
2.6 contains a simple fix: I've removed kmem_cache_reap. Instead the 
code checks for empty pages in the slab caches every other second.

--
    Manfred

