Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264004AbSKYXi2>; Mon, 25 Nov 2002 18:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSKYXhb>; Mon, 25 Nov 2002 18:37:31 -0500
Received: from dp.samba.org ([66.70.73.150]:5096 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264004AbSKYXhZ>;
	Mon, 25 Nov 2002 18:37:25 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Module Refcount & Stuff mini-FAQ 
In-reply-to: Your message of "Mon, 25 Nov 2002 03:39:06 -0300."
             <20021125033906.B1549@almesberger.net> 
Date: Tue, 26 Nov 2002 09:43:06 +1100
Message-Id: <20021125234442.07F392C26E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021125033906.B1549@almesberger.net> you write:
> Rusty Russell wrote:
> > At the cost of exposing the module to initialization races.
> 
> Hmm, what races are there that don't correspond to a bug in
> some module ?

Ah, see other thread (weren't you at the kernel summit?).  There's
currently no way to abort if you've exposed interfaces and then
something fails ("don't do that" is great except noone knows that, and
it's not always possible or nice)

The old module code used to just ignore it.  My code tries to catch it
and leaves the module stuck (except if !CONFIG_MODULE_UNLOAD, in which
case it can't really detect it).

Since we have a way of isolating modules for the symmetric race on
exit, it makes sense to use it on entry (of course, try_inc_mod_count
would have to keep violating the rule during the transition).

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
