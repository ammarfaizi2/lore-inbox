Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWEZJtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWEZJtB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 05:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWEZJtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 05:49:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:49117 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751356AbWEZJtA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 05:49:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pdYJ5eV9qYj09Lazfzldo/M0FXHTzTKpEtgmfeM+rt0sewxzlHJw4t5EWSeI0XcHYTvs7YPtYEcx0+NjSlpuxYJdj6dwiW5NHEIFnGdeddpECentZ5bWIBLPkWt29xCbQSNo3+T7x3wSAMykR2Fc/7OcmfpAjOao0EbIFg12kug=
Message-ID: <9a8748490605260248i68a1eb84hc241068ae1f012bb@mail.gmail.com>
Date: Fri, 26 May 2006 11:48:59 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Paul Drynoff" <pauldrynoff@gmail.com>
Subject: Re: [PATCH] kmalloc man page before 2.6.17
Cc: "Pekka J Enberg" <penberg@cs.helsinki.fi>, akpm@osdl.org,
       "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <36e6b2150605260120s2fb692fegf4fef1eecf7c4674@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com>
	 <84144f020605260017i4682c409vc4a004d016c31270@mail.gmail.com>
	 <36e6b2150605260058h5c1fbc0cla686a37d5bf3e34e@mail.gmail.com>
	 <Pine.LNX.4.58.0605261059360.30386@sbz-30.cs.Helsinki.FI>
	 <36e6b2150605260120s2fb692fegf4fef1eecf7c4674@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/06, Paul Drynoff <pauldrynoff@gmail.com> wrote:
> Currently kernel-doc doesn't produce the man page for "kmalloc",
> I think that is a big lack of documentation. This patch should help.
> Now
> scripts/kernel-doc -man -function kmalloc include/linux/slab.h  |
> nroff -man | less
> creates suitable "man page".
>
> Signed-off-by: Paul Drynoff <pauldrynoff@gmail.com>
>
> ---
>
> Index: linux-2.6.17-rc4/mm/slab.c
> ===================================================================
> --- linux-2.6.17-rc4.orig/mm/slab.c
> +++ linux-2.6.17-rc4/mm/slab.c
> @@ -3244,26 +3244,10 @@ EXPORT_SYMBOL(kmalloc_node);
>  #endif
>
>  /**
> - * kmalloc - allocate memory
> + * __do_kmalloc - allocate memory
>   * @size: how many bytes of memory are required.
> - * @flags: the type of memory to allocate.
> + * @flags: the type of memory to allocate(see kmalloc).
>   * @caller: function caller for debug tracking of the caller
> - *
> - * kmalloc is the normal method of allocating memory
> - * in the kernel.
> - *
> - * The @flags argument may be one of:
> - *
> - * %GFP_USER - Allocate memory on behalf of user.  May sleep.
> - *
> - * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
> - *
> - * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
> - *
> - * Additionally, the %GFP_DMA flag may be set to indicate the memory
> - * must be suitable for DMA.  This can mean different things on different
> - * platforms.  For example, on i386, it means that the memory must come
> - * from the first 16MB.

You seem to be missing :

   GFP_HIGHUSER
      - Allocate pages from high memory.
   GFP_NOIO
      - Do not do any I/O at all while trying to get memory.
   GFP_NOFS
      - Do not make any fs calls while trying to get memory.

It might also make sense to document the fact that you can set
different flags by OR'ing in one or more of the following :

   __GFP_COLD
      - Request cache-cold pages instead of trying to return cache-warm pages.
   __GFP_DMA
      - Request memory from the DMA-capable zone
   __GFP_HIGH
      - This allocation is high priority and may use emergency pools.
   __GFP_HIGHMEM
      - Allocated memory may be from highmem.
   __GFP_NOFAIL
      - Indicate that this allocation is in no way allowed to fail
(think twice before using).
   __GFP_NORETRY
      - If memory is not imidiately available, then give up at once.
   __GFP_NOWARN
      - If allocation fails, don't issue any warnings.
   __GFP_REPEAT
      - If allocation fails initially, try once more before failing.


Btw: how about vmalloc() do we need to document that one as well
(didn't check) ?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
