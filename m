Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267921AbTBYLL5>; Tue, 25 Feb 2003 06:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267932AbTBYLL5>; Tue, 25 Feb 2003 06:11:57 -0500
Received: from dp.samba.org ([66.70.73.150]:48049 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267921AbTBYLL4>;
	Tue, 25 Feb 2003 06:11:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Add module load profile hook 
In-reply-to: Your message of "Tue, 25 Feb 2003 02:58:52 -0000."
             <20030225025852.GB49589@compsoc.man.ac.uk> 
Date: Tue, 25 Feb 2003 19:07:41 +1100
Message-Id: <20030225112211.9A8142C247@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030225025852.GB49589@compsoc.man.ac.uk> you write:
> On Tue, Feb 25, 2003 at 12:25:23PM +1100, Rusty Russell wrote:
> > That would be because that was a HACK, and it's my job to say "no",
> > even when that means we're not "feature complete" by someone's
> > definition.
> 
> You've yet to explain why it's a hack as opposed to a reasonable level
> of discoverability. This includes your comments on IRC where you agreed
> I had a point.

You're still mistaking politeness for agreement.  Of course you have a
point: there *is* benefit in being able to tell where modules are
without changing any code, otherwise you wouldn't be asking for it.

But it's not going to happen.

It's the bit where you add it a "store this filename" and "get the
filename" kernel which makes no sense whatsoever: the kernel has no
need for the information, why should it hold it?

Making modprobe store this somewhere kind of makes sense, but since
the algorithm that modprobe uses to map names to filenames is trivial,
I'm not convinced that the complexity is sensible (unless you want to
handle special cases like module renaming with -o).

Making insmod store this information, since insmod is supposed to be
the dumb workhorse util (ie. "use modprobe") doesn't make as much
sense.  But this is exactly the tool that kernel hackers are likely to
use when they want fine control over their own modules (ie. likely to
be used with oprofile).

The way that gdb solves this is to have a path directive, where you
can say "look here for source".  Or you could send me a patch for
modprobe to put the information somewhere sensible if you prefer that.
What makes most sense to you?

> > You seem to have taken the politeness of my previous response as an
> > indication of uncertainty.
> 
> I took your point and agreed to translate into whatever you like.

And you took a pot-shot at me for being inconsistent: did you expect
me not to clarify?

> I'm not a kernel hacker and I don't particularly give a shit ...

Huh?  You sent a patch.  If you don't care, noone will.

Confused,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
