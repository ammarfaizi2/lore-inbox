Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSKYAWx>; Sun, 24 Nov 2002 19:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSKYAWx>; Sun, 24 Nov 2002 19:22:53 -0500
Received: from dp.samba.org ([66.70.73.150]:1210 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262038AbSKYAWu>;
	Sun, 24 Nov 2002 19:22:50 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Subject: Re: Module Refcount & Stuff mini-FAQ 
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
In-reply-to: Your message of "Mon, 18 Nov 2002 23:30:47 -0300."
             <20021118233047.P1407@almesberger.net> 
Date: Mon, 25 Nov 2002 09:50:46 +1100
Message-Id: <20021125003005.15F762C095@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021118233047.P1407@almesberger.net> you write:
> Rusty Russell wrote:
> > Q: When does try_module_get(owner) fail?
> > A: When the module is not ready to be entered (ie. still in
> >    init_module) or it is being removed.  It fails to prevent you
> >    entering the module as it is being discarded (init might fail, or
> >    it's being removed).
> 
> I'd suggest "It fails in order to [...]" to avoid the "does work
> exactly NOT as advertised" ambiguity ;-)

Ah, thanks, good catch.  I changed it to "This prevents you".

> > Q: But modules call my register() routine which wants to call back
> >    into one of the function pointers immediately, and so
> >    try_module_get() fails!
> > A: You're being called from the module, so someone already has a
> >    reference (unless there's a bug), so you don't need a
> >    try_module_get().
> 
> Hmm, I haven't really looked at your new code, but this sounds as
> if try_module_get gets an exclusive lock. Is this true ? Doesn't
> seem to make sense to me.

No, it doesn't.  The question is badly phrased.  How about:

Q: But the modules' init routine calls my register() routine which
   wants to call back into one of the function pointers immediately,
   and so try_module_get() fails! (because the module is not finished
   initializing yet)
A: You're being called from the module, so someone already has a
   reference (unless there's a bug), so you don't need a
   try_module_get().

   This does mean that if you were to register a structure for
   *another* module (does anyone do this?) you'd need to have a
   reference to it.

> > Hope that helps?
> 
> Don't you want to repeat the golden rule at the end, just as a
> polite reminder ? :-) (Just kidding.)

Heh.

Well, if we continue to start modules unisolated, I need to rewrite
the FAQ anyway...

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
