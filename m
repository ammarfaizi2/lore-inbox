Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280815AbRKLSU3>; Mon, 12 Nov 2001 13:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280911AbRKLSUJ>; Mon, 12 Nov 2001 13:20:09 -0500
Received: from mail010.mail.bellsouth.net ([205.152.58.30]:47352 "EHLO
	imf10bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280815AbRKLSUC>; Mon, 12 Nov 2001 13:20:02 -0500
Message-ID: <3BF012BE.E82911C0@mandrakesoft.com>
Date: Mon, 12 Nov 2001 13:19:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>,
        Anton Blanchard <anton@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] arbitrary size memory allocator, memarea-2.4.15-D6
In-Reply-To: <Pine.LNX.4.33.0111121714100.14093-200000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> the attached memarea-2.4.15-D6 patch does just this: it implements a new
> 'memarea' allocator which uses the buddy allocator data structures without
> impacting buddy allocator performance. It has two main entry points:
> 
>         struct page * alloc_memarea(unsigned int gfp_mask, unsigned int pages);
>         void free_memarea(struct page *area, unsigned int pages);
> 
> the main properties of the memarea allocator are:
> 
>  - to be an 'unlimited size' allocator: it will find and allocate 100 GB
>    of physically continuous memory if that much RAM is available.
[...]
> Obviously, alloc_memarea() can be pretty slow if RAM is getting full, nor
> does it guarantee allocation, so for non-boot allocations other backup
> mechanizms have to be used, such as vmalloc(). It is not a replacement for
> the buddy allocator - it's not intended for frequent use.

What's wrong with bigphysarea patch or bootmem?  In the realm of frame
grabbers this is a known and solved problem...

With bootmem you know that (for example) 100GB of physically contiguous
memory is likely to be available; and after boot, memory get fragmented
and the likelihood of alloc_memarea success decreases drastically...
just like bootmem.

Back when I was working on the Matrox Meteor II driver, which requires
as large of a contiguous RAM area as you can give it, bootmem was
suggested as the solution.

IMHO your patch is not needed.  If someone needs a -huge- slab of
memory, then they should allocate it at boot time when they are sure
they will get it.  Otherwise it's an exercise in futility, because they
will be forced to use a fallback method like vmalloc anyway.

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

