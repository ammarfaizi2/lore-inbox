Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbQJ3QiX>; Mon, 30 Oct 2000 11:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbQJ3QiE>; Mon, 30 Oct 2000 11:38:04 -0500
Received: from [62.172.234.2] ([62.172.234.2]:36434 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129053AbQJ3QiA>;
	Mon, 30 Oct 2000 11:38:00 -0500
Date: Mon, 30 Oct 2000 16:38:35 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.3.95.1001030112739.1186B-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0010301632280.2555-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Richard B. Johnson wrote:
> > So, if you don't need physically contiguous (and fast) allocations perhaps
> > you could make use of vmalloc()/vfree() instead? There must be also some
> > "exotic" allocation APIs like bootmem but I know nothing of them so I stop
> > here.
> 
> Okay. Looks like I need a linked-list so I can use noncontiguous memory.

Just to remind, I was talking of physically and not just virtually
contiguous. vmalloc will still give you a virtually-contiguous chunk. But
if by "I need a linked-list" you mean that each node of the list may be
talking to some hardware but the hardware won't know about the whole list,
then you still need to use physically-contiguous allocator like
__get_free_pages() for each data node, i.e. if your hardware actually
needs physically contiguous chunk to talk to. Also, in this case, using
vmalloc() to allocate just the "linkage/admin overhead" is silly, just
using kmalloc or even creating a private slab object cache is probably a
better idea.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
