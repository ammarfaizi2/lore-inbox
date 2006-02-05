Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWBEEKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWBEEKr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 23:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWBEEKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 23:10:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53394 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932165AbWBEEKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 23:10:46 -0500
Date: Sat, 4 Feb 2006 20:10:33 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 4/5] cpuset memory spread slab cache optimizations
Message-Id: <20060204201033.5a2200f1.pj@sgi.com>
In-Reply-To: <20060204155038.3191a8c0.akpm@osdl.org>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071927.10021.75308.sendpatchset@jackhammer.engr.sgi.com>
	<20060204155038.3191a8c0.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We're adding even more goop into the NUMA __cache_alloc() fastpath.  This bad.

Huh?  I'm only adding more goop (beyond a single inline bit test
of current->flags) in the:
	NUMA and (MEMPOLICY or MEM_SPREAD)
path.

>  @@ -2703,20 +2704,9 @@ static inline void *____cache_alloc(stru
> ...
>  +	if (unlikely(current->flags & (PF_MEM_SPREAD|PF_MEMPOLICY)))
>  +		if ((objp = alternate_node_alloc(cachep, flags)) != NULL)
>  +			return objp;

There are three copies of ____cache_alloc() in mm/slab.c, once
compiled.  Do you really want three copies of alternate_node_alloc()
routine in the kernel, just to avoid a subroutine call in the "NUMA and
(MEMPOLICY or MEM_SPREAD)" case?

I doubt you want that.

In other words, I don't understand yet.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
