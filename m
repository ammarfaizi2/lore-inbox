Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWEZTzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWEZTzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWEZTzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:55:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:30535 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750803AbWEZTzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:55:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=MMtd5Ea0N4gW8CmVW3fz+m8IDFXI5Onn+5HenotYsLIVVkSeBz+z6fxkU6T2hTZj0BdPSpaN5du/yh4GUuvOChGTCNOn0lcESMtVFHVIMLmd2vMp+DyY5/K+JDGV4kNcF+I9jq/NHHwSbXkap0auRpPlWEKGOlFJrhT4oyKC5zU=
Date: Fri, 26 May 2006 21:55:17 +0200
From: Luca <kronos.it@gmail.com>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: linux-kernel@vger.kernel.org, Pekka J Enberg <penberg@cs.helsinki.fi>,
       akpm@osdl.org
Subject: Re: [PATCH] kmalloc man page before 2.6.17
Message-ID: <20060526195517.GA12756@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e6b2150605260344l1ba91d56we2d224d49bde4d8e@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Drynoff <pauldrynoff@gmail.com> ha scritto:
> Thanks everyone for comments.
> Here is new patch: it make possible creation of kmalloc(9)
> and kzalloc(9).
[...]

A few of minor things:

> Index: linux-2.6.17-rc4/include/linux/slab.h
> ===================================================================
> --- linux-2.6.17-rc4.orig/include/linux/slab.h
> +++ linux-2.6.17-rc4/include/linux/slab.h
> @@ -87,6 +87,45 @@ extern void *__kmalloc_track_caller(size
>     __kmalloc_track_caller(size, flags, __builtin_return_address(0))
> #endif
> 
> +/**
> + * kmalloc - allocate memory
> + * @size: how many bytes of memory are required.
> + * @gfp: the type of memory to allocate.
> + *
> + * kmalloc is the normal method of allocating memory
> + * in the kernel.
> + *
> + * The @gfp argument may be one of:
> + *
> + * %GFP_USER - Allocate memory on behalf of user.  May sleep.
> + *
> + * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
> + *
> + * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
> + * %GFP_HIGHUSER - Allocate pages from high memory.
> + * %GFP_NOIO - Do not do any I/O at all while trying to get memory.
> + * %GFP_NOFS - Do not make any fs calls while trying to get memory.
> + *
> + * Also it is possible set different flags by OR'ing
> + * in one or more of the following:
> + * %__GFP_COLD
> + *  - Request cache-cold pages instead of trying to return cache-warm pages.
> + * %__GFP_DMA
> + *  - Request memory from the DMA-capable zone

Missing dot at EOL.

> + * %__GFP_HIGH
> + *  - This allocation is high priority and may use emergency pools.

Not sure about this one, but: is "allocation is high priority" correct?
"This allocation has high priority" sounds better to me.

> + * %__GFP_HIGHMEM
> + *   - Allocated memory may be from highmem.
> + * %__GFP_NOFAIL
> + *  - Indicate that this allocation is in no way allowed to fail
> + * (think twice before using).
> + * %__GFP_NORETRY
> + * - If memory is not imidiately available, then give up at once.

immediately

> + * %__GFP_NOWARN
> + * - If allocation fails, don't issue any warnings.
> + * %__GFP_REPEAT
> + * - If allocation fails initially, try once more before failing.
> + */
> static inline void *kmalloc(size_t size, gfp_t flags)
> {
>        if (__builtin_constant_p(size)) {
> @@ -112,6 +151,11 @@ found:
> 
> extern void *__kzalloc(size_t, gfp_t);
> 
> +/**
> + * kzalloc - allocate memory. The memory is set to zero.
> + * @size: how many bytes of memory are required.
> + * @flags: the type of memory to allocate(see kmalloc).

Space before opening '('?


Luca
-- 
Home: http://kronoz.cjb.net
"La vita potrebbe non avere alcun significato. Oppure, ancora peggio,
 potrebbe averne uno che disapprovo". -- Ashleigh Brilliant
