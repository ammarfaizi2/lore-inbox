Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbQKOPuC>; Wed, 15 Nov 2000 10:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129996AbQKOPtw>; Wed, 15 Nov 2000 10:49:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:42992 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129788AbQKOPtj>; Wed, 15 Nov 2000 10:49:39 -0500
Date: Wed, 15 Nov 2000 13:19:26 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: shm swapping in 2.4 again
In-Reply-To: <qwwpujx383v.fsf@sap.com>
Message-ID: <Pine.LNX.4.21.0011151308140.5584-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2000, Christoph Rohland wrote:

> -  shm_swap is called from swap_out. Actually on my machine after a
>    while it only gets called without __GFP_IO set, which means it will
>    not do anything which again leads to deadlock.

Only _without_ __GFP_IO ?  That's not quite right since
that way the system will never get around to swapping out
dirty pages...

> -  If I call this from page_launder it will work much better, but after a
>    while it gets stuck on prepare_highmem_swapout and will again lock
>    up under heavy load.

So calling it from page_launder() is just a workaround to
make the deadlock more difficult to trigger and not a fix?

> 2) Integrating it into the global lru lists and/or the page cache. 
> 
> I think the second approach is the way to go but I do not
> understand the global lru list handling enough to do this and I
> do not know if we can do this in the short time.

Indeed, this is the way to go. However, for 2.4 ANY change
that makes the system work would be a good one ;)

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
