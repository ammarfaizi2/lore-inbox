Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272873AbRIXFh6>; Mon, 24 Sep 2001 01:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273693AbRIXFhs>; Mon, 24 Sep 2001 01:37:48 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:1028 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S272873AbRIXFhg>;
	Mon, 24 Sep 2001 01:37:36 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: dcinege@psychosis.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PART1: Proposed init & module changes for 2.5 
In-Reply-To: Your message of "Sun, 23 Sep 2001 23:57:24 -0400."
             <E15lMrA-0006ny-00@schizo.psychosis.com> 
Date: Mon, 24 Sep 2001 15:31:58 +1000
Message-Id: <E15lOLW-0000SC-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E15lMrA-0006ny-00@schizo.psychosis.com> you write:
> is initialised. GRUB does a fantastic job of this on x86. It's the first 
> bootloader I've seen 'get it right'.
> 
> I don't suggest implementing the complete module loading in the boot loader,
> (I'm still not even sure I really like it in the kernel.  ; > )

I was hoping someone would say this.  (Note that my userspace tools
are not as complete as the current ones, so take a pinch of salt):

Old kernel:
$ wc -l kernel/module.c
   1250 kernel/module.c
$ ls -l /sbin/insmod
-rwxr-xr-x    1 root     root        99824 Aug 30 09:35 /sbin/insmod
$ find modutils-2.4.1/ -name '*.[ch]' | xargs cat | wc -l
  20612

New kernel:
$ wc -l working-pmac-module/kernel/module.c         
    922 working-pmac-module/kernel/module.c
$ wc -l working-pmac-module/arch/ppc/kernel/module.c
    253 working-pmac-module/arch/ppc/kernel/module.c
$ ls -l modult-init-tools/insmod
-rwxrwxr-x    1 rusty    rusty        5240 Sep 24 15:23 insmod
$ find module-init-tools/ -name '*.[ch]' | xargs cat | wc -l
    661

Convinced yet?

> only loading the modules themselves into memory for the kernel access during 
> it's exec. (Like an initrd image is loaded) If a boot loader wants to 
> understand and use modules.dep or do on the fly dependency checking, or have 
> kernel userland utils to update it's conifg intelligently, that's it's 
> business. I only want to see a way modules can be preloaded before kernel 
> exec.

Why not just put them in the initrd image?  The kernel is not going to
use the entire module as it is, so it will have to copy it anyway...

> All the parts are there but you can't. Your only option is to use an initrd 
> that has the required modules *merged* into it. This is just disgusting and 
> silly.

Um, how do you get the modules into grub then?  If it can read ext2 at
boot, then it could create an initrd for me.  Otherwise, how is it
different from creating an initrd?

It'd be easy to implement now.  But it won't gain us anything, since
we'll all be using initrd-tng in 2.5 anyway.

Cheers,
Rusty.
PS.  Am big fan of LRP: it rocks.
--
Premature optmztion is rt of all evl. --DK
