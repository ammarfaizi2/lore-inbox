Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261952AbSJITpP>; Wed, 9 Oct 2002 15:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbSJITpP>; Wed, 9 Oct 2002 15:45:15 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:54154 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261952AbSJIToi>;
	Wed, 9 Oct 2002 15:44:38 -0400
Message-ID: <3DA48875.6020604@colorfullife.com>
Date: Wed, 09 Oct 2002 21:50:13 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] CONFIG_DEBUG_SLAB broken on SMP
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem appears to be in the SMP version of __kmem_cache_alloc()
> and __kmem_cache_free(), where it simply sticks the obj in the per-CPU
> list without doing the poison or redzone stuff that is done inside
> kmem_cache_free_one_tail().
> 
The simplest solution is to skip the code that enables the per-cpu 
caches if debugging is enabled:

Search for enable_all_cpucaches in mm/slab.c, and skip the call if DEBUG 
is enabled.

2.5.41-mm1 contains a partially rewritten slab, which performs the 
poisoning before adding an object into the cpu caches. Additionally, 
even caches with constructors are not poisoned - ctor and dtor calls are 
performed in kmem_cache_alloc/free.

--
	Manfred

