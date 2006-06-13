Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932863AbWFME25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932863AbWFME25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbWFME25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:28:57 -0400
Received: from xenotime.net ([66.160.160.81]:60386 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932863AbWFME24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:28:56 -0400
Date: Mon, 12 Jun 2006 21:31:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc, kzalloc comments cleanup and fix
Message-Id: <20060612213142.d84da136.rdunlap@xenotime.net>
In-Reply-To: <20060610233942.6c96f557.pauldrynoff@gmail.com>
References: <20060610233942.6c96f557.pauldrynoff@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006 23:39:42 +0400 Paul Drynoff wrote:

> It seems that previous patch was lost, so I resent patch,
> I also folded Randy Dunlap <rdunlap@xenotime.net>'s patch to make things more simple.

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

Thanks.  I was going to resend this to Andrew as well.
You just got to it before I did.

> Changes:
> 1)Move comments for kmalloc to right place, currently it near __do_kmalloc
> 2)Comments for kzalloc
> 3)More detailed comments for kmalloc
> 4)Appearance of "kmalloc" and "kzalloc" man pages after "make mandocs"
> 
> Signed-off-by: Paul Drynoff <pauldrynoff@gmail.com>
> 
> ---
> 
> Index: linux-2.6.17-rc6-mm1/mm/slab.c
> ===================================================================
> --- linux-2.6.17-rc6-mm1.orig/mm/slab.c
> +++ linux-2.6.17-rc6-mm1/mm/slab.c
> @@ -3317,26 +3317,10 @@ EXPORT_SYMBOL(kmalloc_node);
>  #endif
>  
>  /**
> - * kmalloc - allocate memory
> + * __do_kmalloc - allocate memory
>   * @size: how many bytes of memory are required.
> - * @flags: the type of memory to allocate.
> + * @flags: the type of memory to allocate (see kmalloc).
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
>   */
>  static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
>  					  void *caller)
> Index: linux-2.6.17-rc6-mm1/include/linux/slab.h
> ===================================================================
> --- linux-2.6.17-rc6-mm1.orig/include/linux/slab.h
> +++ linux-2.6.17-rc6-mm1/include/linux/slab.h
> @@ -86,6 +86,51 @@ extern void *__kmalloc_track_caller(size
>      __kmalloc_track_caller(size, flags, __builtin_return_address(0))
>  #endif
>  
> +/**
> + * kmalloc - allocate memory
> + * @size: how many bytes of memory are required.
> + * @flags: the type of memory to allocate.
> + *
> + * kmalloc is the normal method of allocating memory
> + * in the kernel.
> + *
> + * The @flags argument may be one of:
> + *
> + * %GFP_USER - Allocate memory on behalf of user.  May sleep.
> + *
> + * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
> + *
> + * %GFP_ATOMIC - Allocation will not sleep.
> + *   For example, use this inside interrupt handlers.
> + *
> + * %GFP_HIGHUSER - Allocate pages from high memory.
> + *
> + * %GFP_NOIO - Do not do any I/O at all while trying to get memory.
> + *
> + * %GFP_NOFS - Do not make any fs calls while trying to get memory.
> + *
> + * Also it is possible to set different flags by OR'ing
> + * in one or more of the following additional @flags:
> + *
> + * %__GFP_COLD - Request cache-cold pages instead of
> + *   trying to return cache-warm pages.
> + *
> + * %__GFP_DMA - Request memory from the DMA-capable zone.
> + *
> + * %__GFP_HIGH - This allocation has high priority and may use emergency pools.
> + *
> + * %__GFP_HIGHMEM - Allocated memory may be from highmem.
> + *
> + * %__GFP_NOFAIL - Indicate that this allocation is in no way allowed to fail
> + *   (think twice before using).
> + *
> + * %__GFP_NORETRY - If memory is not immediately available,
> + *   then give up at once.
> + *
> + * %__GFP_NOWARN - If allocation fails, don't issue any warnings.
> + *
> + * %__GFP_REPEAT - If allocation fails initially, try once more before failing.
> + */
>  static inline void *kmalloc(size_t size, gfp_t flags)
>  {
>  	if (__builtin_constant_p(size)) {
> @@ -111,6 +156,11 @@ found:
>  
>  extern void *__kzalloc(size_t, gfp_t);
>  
> +/**
> + * kzalloc - allocate memory. The memory is set to zero.
> + * @size: how many bytes of memory are required.
> + * @flags: the type of memory to allocate (see kmalloc).
> + */
>  static inline void *kzalloc(size_t size, gfp_t flags)
>  {
>  	if (__builtin_constant_p(size)) {
> Index: linux-2.6.17-rc6-mm1/Documentation/DocBook/kernel-api.tmpl
> ===================================================================
> --- linux-2.6.17-rc6-mm1.orig/Documentation/DocBook/kernel-api.tmpl
> +++ linux-2.6.17-rc6-mm1/Documentation/DocBook/kernel-api.tmpl
> @@ -117,6 +117,7 @@ X!Ilib/string.c
>    <chapter id="mm">
>       <title>Memory Management in Linux</title>
>       <sect1><title>The Slab Cache</title>
> +!Iinclude/linux/slab.h
>  !Emm/slab.c
>       </sect1>
>       <sect1><title>User Space Memory Access</title>
> -

---
~Randy
