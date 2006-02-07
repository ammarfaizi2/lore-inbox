Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWBGMO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWBGMO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWBGMOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:14:55 -0500
Received: from mail.suse.de ([195.135.220.2]:9180 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965038AbWBGMOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:14:55 -0500
From: Andi Kleen <ak@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Cleanup possibility in asm-i386/string.h
Date: Tue, 7 Feb 2006 13:08:59 +0100
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <200602071215.46885.ak@suse.de> <Pine.LNX.4.61.0602071230520.9696@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0602071230520.9696@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071308.59827.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 13:00, Roman Zippel wrote:
> Hi,
> 
> On Tue, 7 Feb 2006, Andi Kleen wrote:
> 
> > If you feel the need to remove some more code: Now that gcc 2.95 isn't supported
> > anymore there isn't really a need to keep the handwritten inline string functions
> > in asm-i386/string.h around. Just declaring them as normal externs will cause
> > gcc to use its builtin expansions, which are typically better than these old inline
> > functions with inline assembly.
> > 
> > For out of line the C versions in lib/string.c can be used (by not setting __ARCH_*) 
> > x86-64 did it like this forever and I guess it would be valuable cleanup for i386 too.
> 
> The only problem is that we compile with -ffreestanding which implies 
> -fno-builtin, so just declaring them as normal externs is not enough and 
> you have to something like this:
> 
> #define __HAVE_ARCH_MEMSET
> extern void *memset(void *, int, __kernel_size_t);
> #define memset(d, c, n) __builtin_memset(d, c, n)
> 
> (BTW you do this already in x86-64.)

Yes thinking about it the x86-64 string.h could just be copied over to i386.
It should already do everything correctly and I don't think there is 
anything really 64bit specific in there.

> Another problem here is because of -fno-builtin it's not easy to use the 
> generic functions as fallback. x86-64 basically does this: 
> 
> #define strlen __builtin_strlen
> size_t strlen(const char * s);
> 
> #ifndef __HAVE_ARCH_STRLEN
> extern __kernel_size_t strlen(const char *);
> #endif
> 
> This means you define a prototype for the builtin function and not for the 
> normal function. I'm not sure this is really intended.

What good would be a prototype for a symbol that is defined to a different symbol?

-Andi

