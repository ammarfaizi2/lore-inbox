Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSIIFgX>; Mon, 9 Sep 2002 01:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSIIFgW>; Mon, 9 Sep 2002 01:36:22 -0400
Received: from dp.samba.org ([66.70.73.150]:48099 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316500AbSIIFgW>;
	Mon, 9 Sep 2002 01:36:22 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
In-reply-to: Your message of "Fri, 06 Sep 2002 09:57:43 GMT."
             <20020906095743.A35@toy.ucw.cz> 
Date: Mon, 09 Sep 2002 13:45:02 +1000
Message-Id: <20020909054106.19E762C0C4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020906095743.A35@toy.ucw.cz> you write:
> Hi!
> 
> > > Actually Rusty what's the big deal, add an "initializer"
> > > arg to the macro.  It doesn't hurt anyone, it doesn't lose
> > > any space in the kernel image, and the macro arg reminds
> > > people to do it.
> > > 
> > > I think it's a small price to pay to keep a longer range
> > > of compilers supported :-)
> > 
> > I disagree.  They might not have a convenient (static) initializer, in
> > which case it's simply cruel and unusual, to work around an obscure
> > compiler bug.
> 
> Ugh? of course it will always have convient initializer, namely zero.

What if you really need to initialize them at runtime?  You're putting
a static initializer there simply to mask an obscure toolchain bug.
I'd really prefer dotting:

	/* FIXME: Initializer required so gcc 2.96 doesn't put in BSS */
	DEFINE_PER_CPU(int, xxx) = 0;

everywhere, which can be deleted later, to enforcing it for everyone
in the infrastructure when it doesn't always make sense.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
