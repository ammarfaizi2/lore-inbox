Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbSKZHdS>; Tue, 26 Nov 2002 02:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbSKZHdS>; Tue, 26 Nov 2002 02:33:18 -0500
Received: from dp.samba.org ([66.70.73.150]:24027 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266270AbSKZHdP>;
	Tue, 26 Nov 2002 02:33:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@freya.yggdrasil.com>
Subject: Re: modutils for both redhat kernels and 2.5.x 
In-reply-to: Your message of "Mon, 25 Nov 2002 23:44:20 CDT."
             <Pine.GSO.4.33.0211252320530.6708-100000@sweetums.bluetronic.net> 
Date: Tue, 26 Nov 2002 18:38:38 +1100
Message-Id: <20021126074032.242242C28B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.33.0211252320530.6708-100000@sweetums.bluetronic.net> yo
u write:
> I'm using a fresh redhat 8.0 install.  With the standard modutils, nothing
> loads.  With the updated 2.4.22 modutils, again, nothing loads.  With
> module-init-tool 0.7, none of the redhat startup scripts will work because
> they depend on "modprobe -c"

That's going to be problematic then.  Could you send me an example of
how they use modprobe -c?

> Well excuse me if I get more than a little ticked off after seeing people
> break prefectly functional systems that have been so for years.

I understand your anger, certainly.  Naturally I disagree with
perfectly functional, but yes, I agree that we have currently taken a
step backwards (particularly wrt the userspace tools).  That's why I'm
working with others to get humpty-dumpty back together again.

> Exactly what does a new "in kernel module loader" provide that
> demands it be included in the kernel right-this-very-minute?

What does any feature provide?  I could list the extensions that this
makes possible without breaking userspace again, but I've listed them
elsewhere.

> What's so important that everything gets broken right at the moment
> things are supposed to be settling down? (I often wonder if Linus
> completely skipped source code management class.)

Linus chose the feature freeze date as the date at which no new
patches were to be submitted.  He then worked through the backlog (and
he told me he wanted everything else out of the way first).  Seems
fair enough to me.

> >> Depmod no longer exists.
> >
> >This is true.  It doesn't need to for 0.7, but it's being reintroduced
> >in 0.8 for speed.
> 
> And along those lines, we don't "need" modules either.

No, what I'm saying is that up to 0.7 read the modules directly for
their dependencies.

> >> Modprobe blindly loads a string of modules without even looking to see
> >> if it's already loaded.
> >
> >Yes, this is a bug (and one not reported by anyone, either).  Should
> >be fixed in 0.8.
> 
> You call it a bug; I call it a lame oversite.

No, there was a bug in the code which parsed /proc/modules to see if
the module was already there.

> >> The command line args for modprobe are laughingly few (and none of
> >> the ones a redhat system needs to boot are implemented.)
> >
> >Really?  I don't recall seeing a bug report from you about it.  My
> >Debian system boots fine.
> 
> Read the man page for "modprobe".  How much of your version comes anywhere
> near that?  One cannot blindly change the command line interface of an
> integral tool without knowing they are going to seriously break things.

No need to be insulting.  Needless to say, I've read the code, as
well.  When reimplementing modprobe, would you have me (a) reimplement
the entire thing, warts and all, or (b) take the chance to implement
only those parts which are still required?

Note that modprobe has grown significantly over time, so some features
obsolete other features.

> >Um, we always had a flat module namespace.  *ALWAYS*.  We did put the
> >modules into subdirectories though.  Due to Adam Richter's hard work,
> >with 0.8 we can restore this (basically for the benifit of mkinitrd,
> >which I also don't use).
> 
> Really.

Yes, really.

> Then why the months of holy wars for and against directories?

Because people like to argue.  They'll probably be coming back.  0.8
shouldn't get confused by the presence of directories, so

> And at various points throughout history, there have been totally separate
> modules with the same name.

And it is, and was, a bug.  They're simply not allowed.

> >> And every single object that forms a module will need to be
> >> retooled to adhere to the new module API
> >
> >Really?  How fascinating.  I must admit that I hadn't noticed that.
> 
> So, are *you* going to go rewrite every single one of those drivers?

You clearly don't understand sarcasm.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
