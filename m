Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262454AbSI2MIR>; Sun, 29 Sep 2002 08:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262455AbSI2MIR>; Sun, 29 Sep 2002 08:08:17 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:3487 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262454AbSI2MIR>;
	Sun, 29 Sep 2002 08:08:17 -0400
Message-ID: <3D96EE6B.9040605@colorfullife.com>
Date: Sun, 29 Sep 2002 14:13:31 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: Andrew Morton <akpm@digeo.com>,
       John Levon <movement@marcelothewonderpenguin.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 kmem_cache bug
References: <20020928201308.GA59189@compsoc.man.ac.uk> <3D961797.B4094994@digeo.com> <200209290745.20484.tomlins@cam.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> 
> Yes we can do this.  I would rather fix kmem_cache_destroy though.  Think that, if 
> we play our cards right, we can get rid of the cachep->slabs_free list with out too
> much pain.
> 
Please - lets check first if the free list is actually a problem, before 
deciding to kill it.

If you remove the free list, it becomes impossible to find the freeable 
slab, if another (partial) slab is added to the partial list afterwards.

And I'm definitively against locking up one slab in each cache - it 
coudl be a order=5 allocation. It would be possible to hack around that 
(if alloc is high-order, then partial slabs do not exist), but that's 
too ugly to think about.

--
	Manfred


