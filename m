Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318144AbSG2XxH>; Mon, 29 Jul 2002 19:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318145AbSG2XxG>; Mon, 29 Jul 2002 19:53:06 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:55174 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318144AbSG2XxD>;
	Mon, 29 Jul 2002 19:53:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] automatic initcalls 
In-reply-to: Your message of "Sat, 27 Jul 2002 21:47:24 MST."
             <Pine.LNX.4.44.0207272145050.6125-100000@home.transmeta.com> 
Date: Tue, 30 Jul 2002 09:39:51 +1000
Message-Id: <20020729235746.4CC354155@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0207272145050.6125-100000@home.transmeta.com> you wri
te:
> 
> 
> On Sat, 27 Jul 2002, Jeff Garzik wrote:
> >
> > I've always preferred a system where one simply lists dependencies [as
> > you describe above], and some program actually does the hard work of
> > chasing down all the initcall dependency checking and ordering.
> >
> > Linus has traditionally poo-pooed this so I haven't put any work towards
> > it...
> 
> I don't hate the notion, but at the same time every time it comes up I
> feel that there are reasonably simple ways to just avoid the ordering
> problems.

I think that the best hope is a combination of Roman's module depends
work (based on Kai's "everything which is a module is trivial", and
Stephen and my first depends hack) and explicit depends.

Linkage ordering doesn't work in general, for things like "I want to
be initialized before the non-boot cpus have come up", but for
non-core code it's simple.

> Rusty had a script, but somebody complained about the speed of it. I
> haven't looked at it myself.

Yes, it'll slow the build by a few seconds: but if the linker ever
decides not to preserve ordering, we'll need it.  My original shell
script is suboptimal but we *don't* want the kernel build relying on
libbfd.

Roman and I will come up with something and send it to you later this
week.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
