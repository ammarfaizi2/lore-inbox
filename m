Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267635AbSKTHUN>; Wed, 20 Nov 2002 02:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbSKTHUL>; Wed, 20 Nov 2002 02:20:11 -0500
Received: from dp.samba.org ([66.70.73.150]:51667 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267635AbSKTHTt>;
	Wed, 20 Nov 2002 02:19:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: module-init-tools-0.6/modprobe.c - support subdirectories 
In-reply-to: Your message of "Tue, 19 Nov 2002 14:55:02 -0000."
             <20021119145502.B5535@flint.arm.linux.org.uk> 
Date: Wed, 20 Nov 2002 08:34:36 +1100
Message-Id: <20021120072654.09CAE2C075@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021119145502.B5535@flint.arm.linux.org.uk> you write:
> On Tue, Nov 19, 2002 at 05:42:38PM +1100, Rusty Russell wrote:
> > A: The total linking code is about 200 generic lines, 100
> >    x86-specific lines.
> 
> Should we be bounds-checking the relocations?  Maybe we are (I'm not
> familiar enough with this new module code yet.)  I'm specifically
> thinking about the following:
> 
> 		/* This is where to make the change */
> 		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
> 			+ rel[i].r_offset;
> 		/* This is the symbol it is referring to */
> 		sym = (Elf32_Sym *)sechdrs[symindex].sh_offset
> 			+ ELF32_R_SYM(rel[i].r_info);
> 		if (!sym->st_value) {

No, you didn't miss anything: I do minimal checking.  I figured it was
worth preventing mistakes (eg. insmod randomcrap.o), but in the end
you're going to trust the module.

I'd say definitely if you know that it has happened (eg. binutils bugs
or something).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
