Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQJ3R7U>; Mon, 30 Oct 2000 12:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129128AbQJ3R7L>; Mon, 30 Oct 2000 12:59:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10756 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129033AbQJ3R64>; Mon, 30 Oct 2000 12:58:56 -0500
Date: Mon, 30 Oct 2000 12:57:51 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tigran Aivazian <tigran@veritas.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.4.21.0010301632280.2555-100000@saturn.homenet>
Message-ID: <Pine.LNX.3.95.1001030124918.2540A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Tigran Aivazian wrote:

> On Mon, 30 Oct 2000, Richard B. Johnson wrote:
> > > So, if you don't need physically contiguous (and fast) allocations perhaps
> > > you could make use of vmalloc()/vfree() instead? There must be also some
> > > "exotic" allocation APIs like bootmem but I know nothing of them so I stop
> > > here.
> > 
> > Okay. Looks like I need a linked-list so I can use noncontiguous memory.
> 
> Just to remind, I was talking of physically and not just virtually
> contiguous. vmalloc will still give you a virtually-contiguous chunk. But
> if by "I need a linked-list" you mean that each node of the list may be
> talking to some hardware but the hardware won't know about the whole list,
> then you still need to use physically-contiguous allocator like
> __get_free_pages() for each data node, i.e. if your hardware actually
> needs physically contiguous chunk to talk to. Also, in this case, using
> vmalloc() to allocate just the "linkage/admin overhead" is silly, just
> using kmalloc or even creating a private slab object cache is probably a
> better idea.
> 
> Regards,
> Tigran
> 

If I can only get 128k bytes of RAM that is still present during
an interrupt, because of a kmalloc() limitation, then I need to
allocate multiple buffers and keep their pointers in a list, right?

It doesn't actually have to be a linked list, the buffers are
never deallocated until the module is removed.

	char *ram_128k[16];

16 buffers with 128k in each.

In the interrupt, I just write to the previously-allocated 16 buffers.
In the read(), I just read from them.


Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
