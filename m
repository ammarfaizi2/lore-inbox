Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSKYBFJ>; Sun, 24 Nov 2002 20:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSKYBFJ>; Sun, 24 Nov 2002 20:05:09 -0500
Received: from dp.samba.org ([66.70.73.150]:41676 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262214AbSKYBFI>;
	Sun, 24 Nov 2002 20:05:08 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modules as shared objects 
In-reply-to: Your message of "Sat, 23 Nov 2002 14:01:28 -0800."
             <20021123140128.A699@twiddle.net> 
Date: Mon, 25 Nov 2002 12:10:50 +1100
Message-Id: <20021125011223.74AC82C0F3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021123140128.A699@twiddle.net> you write:
>   * Freeing the .init.* sections.  Also requires the link script.
>     I believe the proper solution is to use a different program
>     header with a different load tag:
> 
> 	#define PT_INIT_LOAD	0x60000001
> 
>     In this way we don't make a mistake and discard a segment that
>     we're not supposed to.

Were you thinking of dropping the dynamic at the same time
(ie. putting the dynamic and init sections in the tail using the
linker script)?  Hmm, I guess not since you 

I think an "mod_arch_free_partial(struct module *mod, void *start,
void *end)" function which archs could use to do whatever fancy magic
they wanted (eg. trim exception and really drop the pages, or your
vmalloc_drop_pages() function, or nothing at all).  x86_64, sparc,
sparc64, ppc and arm do/will have their own allocators already.

> +module_core_size(const ElfW(Ehdr) *hdr, struct module *module,

I *really* hate this ElfW(type) notation.  I know it's used in
binutils etc, but it's a visual bitch to parse.  Please please please
at least use the #defines or typedefs within the generic
kernel/module.c so it's readable.

Other than some gratuitous reformatting 8), looks really good.
Implementing PPC now.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
