Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318911AbSIDPBN>; Wed, 4 Sep 2002 11:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318922AbSIDPBN>; Wed, 4 Sep 2002 11:01:13 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:58775 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S318911AbSIDPBN>;
	Wed, 4 Sep 2002 11:01:13 -0400
Message-ID: <3D762156.5050907@colorfullife.com>
Date: Wed, 04 Sep 2002 17:05:58 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Terence Ripperda <tripperda@nvidia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: lockup on Athlon systems, kernel race condition?
References: <3D752DA3.6030000@colorfullife.com> <20020903220424.GL2343@hygelac>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda wrote:
> 
> I don't have things caught in the debugger currently, but I did check the registers at the time. bit 9 of eflags was enabled on both cpus.
> 
That rules out a disabled interrupt flag.

What was cpu1 doing? There are 3 loops in smp_call_function:
spin_lock(&call_lock), and 2 while loops with barrier() [first one for 
IPI arrival, second one for synchroneous ipi's. TLB flush is sync].

--
	Manfred

