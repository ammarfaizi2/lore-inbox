Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129803AbQKOVew>; Wed, 15 Nov 2000 16:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbQKOVeq>; Wed, 15 Nov 2000 16:34:46 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:48878 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129803AbQKOVee>; Wed, 15 Nov 2000 16:34:34 -0500
Date: Wed, 15 Nov 2000 19:04:13 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: shm swapping in 2.4 again
In-Reply-To: <qwwem0dyn3x.fsf@sap.com>
Message-ID: <Pine.LNX.4.21.0011151854150.1111-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2000, Christoph Rohland wrote:
> On Wed, 15 Nov 2000, Rik van Riel wrote:
> > On 15 Nov 2000, Christoph Rohland wrote:

> >> 2) Integrating it into the global lru lists and/or the page cache. 
> >> 
> >> I think the second approach is the way to go but I do not
> >> understand the global lru list handling enough to do this and I
> >> do not know if we can do this in the short time.
> > 
> > Indeed, this is the way to go. However, for 2.4 ANY change
> > that makes the system work would be a good one ;)
> 
> That's what I think. But from my observations I get the impression
> that balancing the vm for big shm loads will not work. So the second
> approach is perhaps what we have to do to get it working.
> 
> Actually I would appreciate some hints, where I could hook into
> the vm if I implement a swap_shm_page() which could be called
> from the vm. Can I simply call add_to_lru_cache or do I need to
> add it to the page cache...

You really want to have it in the swap cache, so we have
a place for it allocated in cache, etc...

Basically, when we unmap it in try_to_swap_out(), we
should add the page to the swap cache, and when the
last user stops using the page, we should push the
page out to swap.

[I'll code up the same thing for normal swap pages]

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
