Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVAAEXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVAAEXG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 23:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVAAEXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 23:23:06 -0500
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:55128 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S262192AbVAAEXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 23:23:02 -0500
Date: Fri, 31 Dec 2004 23:21:04 -0500 (EST)
From: Michael Hines <mhines@cs.fsu.edu>
To: Roland Dreier <roland@topspin.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: can you switch between GFP_ATOMIC and GFP_KERNEL?
In-Reply-To: <523bxlaimn.fsf@topspin.com>
Message-ID: <Pine.GSO.4.33.0412312320500.28251-100000@diablo.cs.fsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh, that's right.

Stupid me =)

Thanks,
/*********************************/
Michael R. Hines
Grad Student, Florida State
Dept. Computer Science
http://www.cs.fsu.edu/~mhines/
Jusqu'a ce que le futur vienne...
/*********************************/


On Fri, 31 Dec 2004, Roland Dreier wrote:

>     Michael> My question is, new sk_buffs are always allocated with
>     Michael> GFP_KERNEL and can be swapped out. Is it possible to
>     Michael> change the allocation status of already-allocated memory
>     Michael> to GFP_ATOMIC on the fly? (i.e. both the slab-cache
>     Michael> sk_buff header memory as well as the kmalloc'd data
>     Michael> area).
>
> This question is ill-posed -- kernel memory can never be swapped out,
> whether it's allocated with GFP_KERNEL or GFP_ATOMIC.  The difference
> between GFP_KERNEL and GFP_ATOMIC is whether the actual allocation can
> sleep, that is:
>
> 	foo = kmalloc(sizeof foo, GFP_ATOMIC);	/* will not sleep */
> 	foo = kmalloc(sizeof foo, GFP_KERNEL);	/* can sleep */
>
> However, whichever gfp flags are used to allocate memory, the memory
> is the same once the allocation is done.  Neither kmalloc'ed memory
> nor sk_buffs will ever be swapped.
>
>  - Roland
>

