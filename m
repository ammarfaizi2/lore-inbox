Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318898AbSG1D31>; Sat, 27 Jul 2002 23:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318899AbSG1D31>; Sat, 27 Jul 2002 23:29:27 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:37055 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318898AbSG1D30>;
	Sat, 27 Jul 2002 23:29:26 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, torvalds@transmeta.com
Subject: Re: [PATCH] automatic initcalls 
In-reply-to: Your message of "Sat, 27 Jul 2002 22:22:59 +0200."
             <3D430123.739CA34D@linux-m68k.org> 
Date: Sun, 28 Jul 2002 13:31:20 +1000
Message-Id: <20020728033359.7B2A2444C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D430123.739CA34D@linux-m68k.org> you write:
> - I only look at modules which contain an initcall
> - I only order initcalls of level 6 and 7

You don't seem to handle the ordering of initcalls within a module
though: see net/ipv4/netfilter/ip_conntrack.o for an example of
multiple inits which would be much better as separate initcalls.

The more I play with these magic approaches, the more I prefer an
explicit "Must be done after this" and "must be done before this":
otherwise we're going to need to keep adding new levels as we discover
something that doesn't fit in the magic 7.

Especially since you don't cover any of the really interesting cases.
Maybe if you could slowly extend it to cover the rest?  (Hah, I
know!).

> +init/generated-initcalls.c: .allinit.defs
> +	set -e; echo '#include <linux/init.h>' > $@; \
> +	sed -n < $< "s,^T ,,p" | sort > .defined.all; \

I think you mean something like:

	sed -n "s,^T ,,p" < $<

> -__initcall(spawn_ksoftirqd);
> +fs_initcall(spawn_ksoftirqd);

See, this is exacly the kind of thing that makes me doubt that the
current "magic 7 initcall levels" are useful in the long term 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
