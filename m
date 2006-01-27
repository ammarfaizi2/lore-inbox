Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWA0JBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWA0JBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 04:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWA0JBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 04:01:40 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:36049 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932427AbWA0JBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 04:01:39 -0500
Message-ID: <43D9E15B.9000407@cosmosbay.com>
Date: Fri, 27 Jan 2006 10:01:15 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
CC: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 2/4] net: Percpufy frequently used variables -- struct
 proto.memory_allocated
References: <20060126185649.GB3651@localhost.localdomain> <20060126190212.GD3651@localhost.localdomain>
In-Reply-To: <20060126190212.GD3651@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 27 Jan 2006 10:01:14 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai a écrit :
> Change struct proto->memory_allocated to a batching per-CPU counter 
> (percpu_counter) from an atomic_t.  A batching counter is better than a 
> plain per-CPU counter as this field is read often.
> 
> Signed-off-by: Pravin B. Shelar <pravins@calsoftinc.com>
> Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
> Signed-off-by: Shai Fultheim <shai@scalex86.org>
> 

Hello Ravikiran

I like this patch, but I'm not sure current percpu_counter fits the needs.

The percpu_counter_read() can return a value that is off by +-
FBC_BATCH*NR_CPUS, ie 2*(NR_CPUS^2) or 4*(NR_CPUS^2)

if NR_CPUS = 128, the 'error' from percpu_counter_read() is +- 32768

Is it acceptable ?

Thank you
Eric
