Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317187AbSFRAQG>; Mon, 17 Jun 2002 20:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSFRAQF>; Mon, 17 Jun 2002 20:16:05 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:37296 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317187AbSFRAQD>; Mon, 17 Jun 2002 20:16:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initcall depends 
In-reply-to: Your message of "Mon, 17 Jun 2002 17:43:11 EST."
             <Pine.LNX.4.44.0206171658470.22308-100000@chaos.physics.uiowa.edu> 
Date: Tue, 18 Jun 2002 10:17:10 +1000
Message-Id: <E17K6gI-0001Ga-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206171658470.22308-100000@chaos.physics.uiowa.edu> y
ou write:
> Parts of a solution could be (based on yours above).
> 
> o Define KBUILD_OBJECT during the build, which contains the
>   name of the module the file we're building will/would end up.
> 
> o Use that to rename the __initcall_whatever to
>   __initcall__module__whatever.
> 
> o Make a symlink tree pointing to the objects that will be linked in
>   (Basically $(obj-y))
> 
> o Go through the symlink tree and for all objects which export objects
>   and have __initcalls, record that relation.

Hmm... how about "put export symbols in __ksymtab in object file even
if CONFIG_MODULE=n", just discard them in the final link.

Then build up table from that (we're looking at the objects anyway).

> o For all __initcall__moduleA__ in the objects to be linked into 
>   vmlinux, find the object that defines it in the symlink tree (its name
>   will be moduleA.o).
> 
> o Find the unresolved symbols in that object moduleA.o.
> 
> o For each unresolved symbol in moduleA.o, if you find the symbol in the 
>   previously recorded pairs of (exported symbols, __initcall__moduleB), 
>   move __initcall_moduleA behind __initcall_moduleB.
> 
> Probably some issues come up when actually trying to do this, but it 
> sounds doable at least in principle.

I'll have to think some more and see if I can come up with something
along these lines.

> 
> Then again, there's also the possibility of completing initramsfs, making
> it mandatory, compiling things always as modules and leaving it to
> "depmod" in initramfs to do the right thing.

If that ever happens... 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
