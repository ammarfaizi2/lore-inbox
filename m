Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265432AbRFVOxw>; Fri, 22 Jun 2001 10:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265436AbRFVOxl>; Fri, 22 Jun 2001 10:53:41 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:34691 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S265432AbRFVOxd>; Fri, 22 Jun 2001 10:53:33 -0400
Date: Fri, 22 Jun 2001 08:53:25 -0600
Message-Id: <200106221453.f5MErPg22986@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads) 
In-Reply-To: <Pine.GSO.4.21.0106211949280.209-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0106211931180.209-100000@weyl.math.psu.edu>
	<Pine.GSO.4.21.0106211949280.209-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> BTW, proc_net_create() is also not a good idea if you block the
> interrupts.  Ditto for netlink_kernel_create(), AFAICS (due to
> netlink_kernel_creat() -> sock_alloc() -> get_empty_inode() ->
> kmem_cache_alloc() with SLAB_KERNEL).
> 
> That, BTW, is a nice illustration - it's easy to get a preemption
> point without noticing, so holding spinlocks, let alone disabling
> interrupts over the large area is going to hurt like hell.

Here's an idea: add a CONFIGable debug mode for spinlock/cli
interaction with GFP_KERNEL and other (known) blocking operations.
Keep a per-CPU flag or bitmask that's manipulated by lock/cli
operations and checked by memory allocators and other key blocking
operations. Generate an Oops upon violation.

Make the CONFIG option initially set to 'y' for a patch level or two.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
