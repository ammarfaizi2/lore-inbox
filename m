Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSKNDTK>; Wed, 13 Nov 2002 22:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSKNDSL>; Wed, 13 Nov 2002 22:18:11 -0500
Received: from dp.samba.org ([66.70.73.150]:2745 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261416AbSKNDSD>;
	Wed, 13 Nov 2002 22:18:03 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module mess in -CURRENT 
In-reply-to: Your message of "Thu, 14 Nov 2002 00:02:06 -0000."
             <20021114000206.A8245@infradead.org> 
Date: Thu, 14 Nov 2002 15:06:42 +1100
Message-Id: <20021114032456.2E2342C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021114000206.A8245@infradead.org> you write:
> Linus, Rusty,
> 
> what the hell is going on with the modules code in 2.5-CURRENT?
> 
> Rusty's monsterpatch breaks basically everything (and remember we're
> in feature freeze!) instead of doing one thing at a time [1], and it
> is doing three things that are absolutely separate issues.

<sigh>.  I did do it one at a time.  I replaced the module loading
code as stage I.

> We had an almost useable 2.5 and now exactly when we're feature freezing
> and people are expected to test it we break everything?
> 
> Linus, please backout that patch until we a) have modutils that support
> both the new and old code

It works for me.  This is becoming an FAQ, but I thought the code was
obvious: eg. insmod execvp "insmod.old" when it detects an older
kernel, and "make install" moves insmod to insmod.old etc. if
insmod.old doesn't already exist.

> and b) support at least such basic features
> as parsing modules.conf and supporting parameters.

I'm sorry if I'm feeding the patches to Linus too slowly for you, but
you know where to find them, I've posted the URL often enough.  It
hasn't even hit a release yet, so I wasn't worried.

I implemented an in-kernel module loader, implemented the linking code
for 6 architectures, re-implemented all the module cruft cleanly on
top of it, and kept it uptodate through all the changes in Linus'
tree.

And you wonder why I held back fleshing out the implementation of
modprobe, until (if) the code was in the kernel?

> The inkernel loader, generic boot-time option and your - umm - strange
> idea of module unload race reduction are absolute separate things.

I rewrote module.c to make it an in-kernel linker so insmod was 20
lines.  And you think I should have re-implemented races in the
loading and unloading stages too, so I could remove them in a future
patch?

What an odd concept!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
