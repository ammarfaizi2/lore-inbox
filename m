Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317718AbSGVWft>; Mon, 22 Jul 2002 18:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317842AbSGVWft>; Mon, 22 Jul 2002 18:35:49 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:64901 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S317718AbSGVWfs>; Mon, 22 Jul 2002 18:35:48 -0400
Date: Mon, 22 Jul 2002 15:36:33 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Steven Cole <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Steven Cole <scole@lanl.gov>,
       Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
In-Reply-To: <20020722222150.GF919@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0207221520301.14311-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, William Lee Irwin III wrote:

> The pte_chain mempool was ridiculously huge and the use of mempool for
> this at all was in error.

That's what I thoguht too -- but Steven tried making the pool 1/4th the
size and it still failed.  OTOH, he tried 2.5.27-rmap, which uses the
*same mempool patch* and he had no problem with the monster 128KB 
allocation.  Maybe it was all luck. :)  I can't yet see anything in the 
slablru patch that has anything to do with it...

On another note -- Steven did point out that the slablru patch has a
patchbug with regards to dquot.c.  I think this error is also in Ed's 
June 5th patch (at least as posted), and I didn't catch it.  
I believe that:

shrink_dqcache_memory(int priority, unsigned int gfp_mask)
	needs to be 
age_dqcache_memory(kmem_cache_t *cachep, int entries, int gfp_mask)

in dquot.c.  It'll be tested and fixed on the next go. :)

Best regards,
Craig Kulesa

