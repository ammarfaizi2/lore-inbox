Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbSKOVWs>; Fri, 15 Nov 2002 16:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbSKOVWs>; Fri, 15 Nov 2002 16:22:48 -0500
Received: from dp.samba.org ([66.70.73.150]:13697 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266749AbSKOVWp>;
	Fri, 15 Nov 2002 16:22:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues 
In-reply-to: Your message of "Fri, 15 Nov 2002 04:51:46 -0800."
             <20021115045146.A23944@twiddle.net> 
Date: Sat, 16 Nov 2002 08:21:32 +1100
Message-Id: <20021115212941.7336E2C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021115045146.A23944@twiddle.net> you write:
> One more thing:
> 
> Are you really REALLY sure you don't want to load ET_DYN or ET_EXEC
> files (aka shared libraries or executables) instead of ET_REL files
> (aka .o files)?

AFAICT, that would hurt some archs.  Of course, you could say "modules
are meant to be slow" but I don't think that would win you any
friends 8)

I haven't thought about it hard: for some archs it might make perfect
sense, but I'm not sure what more than dropping the hdr->e_type check
would be required.

> This does reduce the freedom to allocate the init sections completely
> separately from the core sections, but that seems a small price to pay
> for the extreme reduction in complexity for the in-kernel loader.

Note: "extreme reduction" is probably overstating.  There are only
about 300 lines of linker code in the kernel (x86).  The rest of the
1400 lines is refcount manipulation, usage detection, symbol lookup,
system call code, /proc stuff.

But I think you could do this for any arch now by allocating the whole
module in the core alloc, and returning a pointer the the start of the
init section for the second "alloc".  The "free" of the init section
then only frees those trailing pages.

I have no problem with the idea, if we can keep the per-arch
flexibility.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
