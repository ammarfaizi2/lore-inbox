Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261586AbSI0Ahh>; Thu, 26 Sep 2002 20:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSI0Ahh>; Thu, 26 Sep 2002 20:37:37 -0400
Received: from tomts9.bellnexxia.net ([209.226.175.53]:2761 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261586AbSI0Ahg>; Thu, 26 Sep 2002 20:37:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [patch 3/4] slab reclaim balancing
Date: Thu, 26 Sep 2002 20:41:11 -0400
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <3D931608.3040702@colorfullife.com> <3D9372D3.3000908@colorfullife.com> <3D937E87.D387F358@digeo.com>
In-Reply-To: <3D937E87.D387F358@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209262041.11227.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 26, 2002 05:39 pm, Andrew Morton wrote:
> Manfred Spraul wrote:
> > Andrew Morton wrote:
> > Btw, 140 cycles for kmem_cache_alloc+free is inflated - someone enabled
> > kmem_cache_alloc_head() even in the no-debugging version.
> > As expected, done by Andrea, who neither bothered to cc me, nor actually
> > understood the code.
>
> hm, OK.  Sorry, I did not realise that you were this closely
> interested/involved with slab, so things have been sort of
> going on behind your back :(

Nor did I realize this...  The reasoning behind quickly giving pages back to the 
system was fairly simple.  Previous vm experiements showed that lazy freeing
of pages from the lru was not a good performer.  When the first versions of
slablru went into mm we noticed that large numbers of pages (thousands) were
free but not reclaimed.  This was working as designed - the conclusion was that
slablru was over designed and that lazy removal was probably not such a good
idea.  The slabasap patch that started this thread was the fix for this.

There is no dispute that in some cases it will be slower from a slab perspective.  As
Andrew and you have discussed there are things that can be done to speed things 
up.  Is not the question really, "Are the vm and slab faster together when slab pages 
are freed asap?"

As it stands now we could remove quite a bit of code from slab.  There is no longer
a need for most of the kmem_cache_shrink family, nor is kmem_cache_reap needed
any more.  This simpilifes slab.  If we also enable the per cpu arrays for UP the code
is even cleaner (and hopefully faster).

Manfred, slab is currently using typedefs.  Andrews has stated that he and Linus are
trying to remove these from the kernel.  When I code the cleanup patches for slabasap
(provided it proves itself) shall I clean them out too?

Ed Tomlinson
