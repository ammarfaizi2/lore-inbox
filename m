Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSGZDo7>; Thu, 25 Jul 2002 23:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSGZDo7>; Thu, 25 Jul 2002 23:44:59 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:37285 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316750AbSGZDo6>;
	Thu, 25 Jul 2002 23:44:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] new module interface 
In-reply-to: Your message of "Thu, 25 Jul 2002 11:56:06 +0200."
             <Pine.LNX.4.44.0207251121310.28515-100000@serv> 
Date: Fri, 26 Jul 2002 13:43:39 +1000
Message-Id: <20020726034921.368CE4575@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0207251121310.28515-100000@serv> you write:
> Hi,
> 
> On Thu, 25 Jul 2002, Rusty Russell wrote:
> 
> > 	Firstly, I give up: what kernel is this patch against?  It's
> > hard to read a patch this big which doesn't apply to any kernel I can find 
8(
> 
> 2.4.18. Maybe pine garbled the patch... Here is a copy of the patch:
> http://www.xs4all.nl/~zippel/mod.diff

Much better: thanks!

> > Interesting approach.  Splitting init and start and stop and exit is
> > normal, but encapsulating the usecount is different.  I made start
> > and exit return void, though.
> 
> I introduced usecount() to gain more flexibility, currently one is forced
> to pass the module pointer everywhere.

Well, you substituted the module pointer for an atomic counter.  Bit
of a wash, really.

> Allowing exit to fail simplifies the interface. Normal code doesn't has
> to bother about the current state of the module, instead exit() is now the
> synchronization point. This also means the unload_lock via
> try_inc_mod_count is not needed anymore.

Except that rmmod fails rather frequently on busy modules.  Which
might be ok.

> > I chose the more standard "INIT(init, start)" & "EXIT(stop, exit)" which
> > makes it easier to drop the exit part if it's built-in.
> 
> I was thinking about it, but couldn't we just put these function in a
> seperate section and discard them during init (maybe depending on some
> hotplug switch)?

No, if you drop them newer binutils notices the link problem, hence
the __devexit_p(x) macro.

> > My favorite part is including the builtin-modules.  I assume this means
> > that "request_module("foo")" returns success if CONFIG_DRIVER_FOO=y now?
> 
> Not yet. The problem is the module name, e.g. ext2 is called
> fs_ext2_super, it will need some kbuild changes to get the right module
> name.

I need that too: the mythical "KBUILD_MODNAME".  Both Keith and Kai
promised it to me...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
