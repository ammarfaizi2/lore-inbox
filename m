Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSJOFWG>; Tue, 15 Oct 2002 01:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSJOFVF>; Tue, 15 Oct 2002 01:21:05 -0400
Received: from dp.samba.org ([66.70.73.150]:16833 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262415AbSJOFVB>;
	Tue, 15 Oct 2002 01:21:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Mon, 30 Sep 2002 17:32:36 +0200."
             <E17w2XF-0005oW-00@starship> 
Date: Tue, 15 Oct 2002 13:25:10 +1000
Message-Id: <20021015052656.5ED272C18E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17w2XF-0005oW-00@starship> you write:
> On Thursday 19 September 2002 22:11, Greg KH wrote:
> > On Thu, Sep 19, 2002 at 07:58:15PM +0100, Alan Cox wrote:
> > > On Thu, 2002-09-19 at 19:38, Greg KH wrote:
> > > > And with a LSM module, how can it answer that?  There's no way, unless
> > > > we count every time someone calls into our module.  And if you do that,
> > > > no one will even want to use your module, given the number of hooks, an
d
> > > > the paths those hooks are on (the speed hit would be horrible.)
> > > 
> > > So the LSM module always says no. Don't make other modules suffer
> > 
> > Ok, I don't have a problem with that, I was just trying to point out
> > that not all modules can know when they are able to be unloaded, as
> > Roman stated.
> 
> Not being able to unload LSM would suck enormously.  At last count, we
> knew how to do this:
> 
>   1) Unhook the function hooks (using a call table simplifies this)
>   2) Schedule on each CPU to ensure all tasks are out of the module
>   3) A schedule where the module count is incremented doesn't count
> 
> and we rely on the rule that and module code that could sleep must be
> bracketed by inc/dec of the module count.
> 
> Did somebody come up with a reason why this will not work?

It won't quite work if the hooks can sleep.  You can say "don't sleep"
or have a wedge which does the "try_inc_mod_count()" then calls into
the module (and returns some default if it can't inc the module count).

You can't disable preemption before calling in, because there is no
way to sleep with preemption disabled. 8(

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
