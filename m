Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267701AbTBGEos>; Thu, 6 Feb 2003 23:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267714AbTBGEor>; Thu, 6 Feb 2003 23:44:47 -0500
Received: from dp.samba.org ([66.70.73.150]:20948 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267701AbTBGEok>;
	Thu, 6 Feb 2003 23:44:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Restore module support. 
In-reply-to: Your message of "Fri, 07 Feb 2003 00:10:07 -0000."
             <20030207001006.A19306@flint.arm.linux.org.uk> 
Date: Fri, 07 Feb 2003 15:53:44 +1100
Message-Id: <20030207045419.9A11B2C0F8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030207001006.A19306@flint.arm.linux.org.uk> you write:
> And I'll promptly provide you with the other view.  I'm still trying to
> sort out the best thing to do for ARM.  We have the choice of:
> 
> 1. load modules in the vmalloc region and build two jump tables, one for
>    the init text and one for the core text.

Yes.  PPC and PPC64 have the same issues: currently this is done by
(1) putting nothing in the .init sections (on PPC64), and (2) with
stubs when jumping outside the module code.

This gives the same effect as the previous userspace loader: for PPC64
noone cares about discarding init stuff, so it's firmly on the TODO
list.  ARM's priorities are obviously different.

> 2. fix vmalloc and /proc/kcore to be able to cope with a separate module
>    region located below PAGE_OFFSET.  Currently, neither play well with
>    this option.

x86_64 has this, as does sparc64: they do their own allocation.  Does
ARM require something special in this regard?  I'd love to see what
you've got...

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
