Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131847AbQLRRjp>; Mon, 18 Dec 2000 12:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131844AbQLRRjf>; Mon, 18 Dec 2000 12:39:35 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:2821 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131776AbQLRRjT>; Mon, 18 Dec 2000 12:39:19 -0500
Date: Mon, 18 Dec 2000 11:08:47 -0600
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
Message-ID: <20001218110847.J3199@cadcamlab.org>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com> <91bnoc$vij$2@enterprise.cistron.net> <20001215155741.B4830@ping.be> <01cf01c066ab$036fc030$890216ac@ottawa.loran.com> <20001216164151.J3199@cadcamlab.org> <024701c0690a$56f9ba10$890216ac@ottawa.loran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <024701c0690a$56f9ba10$890216ac@ottawa.loran.com>; from dana.lacoste@peregrine.com on Mon, Dec 18, 2000 at 10:51:09AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Dana Lacoste]
> - I write an external/third party kernel module
> - For various reasons, I must have this kernel module installed to boot
>   (i can't compile without my module running)

In that case "compile script for dummies" will probably fail anyway.
If you need it to boot, you probably need to either (a) compile it
directly into the kernel (not modular) or (b) use a custom initrd after
compiling.  Neither option is easy to automate for the clueless user.

> How can I know where the 'correct' Linux kernel headers are in such a
> way that is as transparent as possible to the user doing the
> compiling?

The official correct answer is

  /lib/modules/{version}/build/include

The only time this fails is if the user has moved or deleted his kernel
tree since installing, and if he does that, obviously he doesn't want
to compile any external modules.

The difficulty here is determining {version}.  It is `uname -r` for the
currently running kernel, but could be anything at all for other
kernels.

So when in doubt, generate a list of `cd /lib/modules; echo *` and have
the user pick one.

> I think the biggest problem so far has been that many developers
> don't recognize just how varied the linux development universe is!
> For me personally, it's nothing to cross-compile for other hardware
> platforms, and any solution that doesn't take that possibility into
> account is just being silly :)

I think the biggest problem is trying to cater to users who don't know
how the kernel compile process works.  If you're going to compile your
own kernel and/or modules, you had better do your homework, is what I
say.  All the problems we are discussing magically go away as soon as
you assume a user with a quarter of a clue.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
