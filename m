Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUFDSuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUFDSuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265938AbUFDSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:48:37 -0400
Received: from webmail.cs.unm.edu ([64.106.20.39]:54962 "EHLO mail.cs.unm.edu")
	by vger.kernel.org with ESMTP id S265955AbUFDSrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:47:55 -0400
Date: Fri, 4 Jun 2004 12:47:40 -0600 (MDT)
From: Sharma Sushant <sushant@cs.unm.edu>
To: Bart Trojanowski <bart@jukie.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: modifying struct sk_buff
In-Reply-To: <20040604123652.GI29389@jukie.net>
Message-ID: <Pine.LNX.4.56.0406041233120.6320@chawla.cs.unm.edu>
References: <40BFCA4C.2000904@cs.unm.edu> <20040604123652.GI29389@jukie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *1BWJjB-0004v9-00*vkXk/34LJQg*
X-Scanner: exiscan *1BWJjB-0004v9-00*vkXk/34LJQg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Bart
thanks for replying.
I was thinking functions calling the alloc_skb will not
consider the size of new variable which I will add, thats
why I thought of adding the size my self while allocating
space.

I am using kernel 2.6.3 and here are few line from skbuff.h

> 	/*
>         * This is the control buffer. It is free to use for every
>         * layer. Please put your private variables there. If you
>         * want to keep them across layers you have to do a skb_clone()
>         * first. This is owned by whoever has the skb queued ATM.
>         */
>        uint32_t                skBufId; /* by sushant */
>        char                    cb[48];

skBufId is the variable i added and I want to assign unique value
to this id whenever alloc_skb is called.
Do you think it will be fine to modify alloc_skb(..)
and just assigning a unique value to this new variable which I added
or will there be some side effects of this.

Thanks
Sushant





On Fri, 4 Jun 2004, Bart Trojanowski wrote:

> * Sushant Sharma <sushant@cs.unm.edu> [040603 20:24]:
> > Hi
> > I want to add a new member (say uint32_t) in the
> > struct sk_buff{...}
> > in the file include/linux/skbuff.h.
> <snip>
> > Do I need to allocate memory for this member
> > (  ie add sizeof(_new-member_) to *size* while doing kmalloc()  )
>
> Hi Sushant,
>
> I think you are confusing the allocation of 'data' with the allocation
> of 'skb'.
>
> If you add the uint32_t to struct sk_buff you don't have to modify
> alloc_skb.  The skbuff_head_cache is informed what size the sk_buff
> structure is in skb_init().
>
> -Bart
>
> --
> 				WebSig: http://www.jukie.net/~bart/sig/
>
