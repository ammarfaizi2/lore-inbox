Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319206AbSIDQNU>; Wed, 4 Sep 2002 12:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319209AbSIDQNU>; Wed, 4 Sep 2002 12:13:20 -0400
Received: from [209.249.170.16] ([209.249.170.16]:56580 "EHLO dns1.nvidia.com")
	by vger.kernel.org with ESMTP id <S319206AbSIDQNT>;
	Wed, 4 Sep 2002 12:13:19 -0400
From: Terence Ripperda <TRipperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Terence Ripperda <TRipperda@nvidia.com>, linux-kernel@vger.kernel.org
Date: Wed, 4 Sep 2002 11:17:43 -0500
Subject: Re: lockup on Athlon systems, kernel race condition?
Message-ID: <20020904161743.GB750@hygelac>
References: <3D752DA3.6030000@colorfullife.com> <20020903220424.GL2343@hygelac> <3D762156.5050907@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D762156.5050907@colorfullife.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 05:05:58PM +0200, manfred@colorfullife.com wrote:
> What was cpu1 doing? There are 3 loops in smp_call_function:
> spin_lock(&call_lock), and 2 while loops with barrier() [first one for 
> IPI arrival, second one for synchroneous ipi's. TLB flush is sync].

it was spinning on the first barrier loop, waiting for verification of the IPI arrival:

        /* Wait for response */
        while (atomic_read(&data.started) != cpus)
                barrier();


Terence
