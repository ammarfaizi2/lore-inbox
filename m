Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130193AbQKGQkh>; Tue, 7 Nov 2000 11:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130442AbQKGQk1>; Tue, 7 Nov 2000 11:40:27 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:49904 "EHLO
	toy.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130193AbQKGQkX>; Tue, 7 Nov 2000 11:40:23 -0500
Date: Tue, 7 Nov 2000 17:47:10 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: Abel Muñoz Alcaraz <abel@trymedia.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: A question about memory fragmentation
In-Reply-To: <CAEBJLAGJIDLDINHENLOOENBCGAA.abel@trymedia.com>
Message-ID: <Pine.LNX.4.21.0011071736250.18699-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Abel Muñoz Alcaraz wrote:

> 
> 	my question is about memory fragmentation when I allocate and free a lot of
> small memory pieces in a kernel module.
> 	Can it do a memory fragmentation problem?
> 	Can I solve it using 'linux/list.h' API?

Fragmentation is not really an issue there. Linux maintains a pool of pages of
different sizes, and you will be allocated a page with the next size superior
to what you ask for. Sizes are all powers of two, so the worst case would be
that you ask 2^n+1 bytes and get a 2^(n+1) size page. When you free such a
page, it is merged if needed with a coalescent page and put back in the "upper
size" pool (not sure about this, though). So, no fragmentation is to be feared.

As to whether you use list.h or not, it really doesn't have any influence,
except that the list.h implementation is the preferred and standard way to make
doubly linked lists under Linux.

So, no, there's no need to allocate one big pool and manage it yourself. Also
remember that you can only kmalloc() up to 128k - if you want to allocate
bigger amounts of memory, use vmalloc().

Another solution: create your own slab cache for your objects.

-- 
Francis Galiegue, fg@mandrakesoft.com
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
