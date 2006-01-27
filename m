Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWA0IyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWA0IyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 03:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWA0IyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 03:54:13 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:1756 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S1750752AbWA0IyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 03:54:12 -0500
Message-ID: <43D9DFA1.9070802@cosmosbay.com>
Date: Fri, 27 Jan 2006 09:53:53 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
CC: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain>
In-Reply-To: <20060126190357.GE3651@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 27 Jan 2006 09:53:54 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai a écrit :
> Change the atomic_t sockets_allocated member of struct proto to a 
> per-cpu counter.
> 
> Signed-off-by: Pravin B. Shelar <pravins@calsoftinc.com>
> Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
> Signed-off-by: Shai Fultheim <shai@scalex86.org>
> 
Hi Ravikiran

If I correctly read this patch, I think there is a scalability problem.

On a big SMP machine, read_sockets_allocated() is going to be a real killer.

Say we have 128 Opterons CPUS in a box.

You'll need to bring 128 cache lines (plus 8*128 bytes to read the 128 
pointers inside percpu structure)

I think a solution 'a la percpu_counter' is preferable, or even better a 
dedicated per_cpu with a threshold management (see mm/swap.c , function 
vm_acct_memory() to see how vm_committed_space is updated without too bad SMP 
scalability)

Thank you

Eric

