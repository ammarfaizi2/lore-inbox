Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267694AbTAMBCj>; Sun, 12 Jan 2003 20:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267709AbTAMBCj>; Sun, 12 Jan 2003 20:02:39 -0500
Received: from dp.samba.org ([66.70.73.150]:19369 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267694AbTAMBCi>;
	Sun, 12 Jan 2003 20:02:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: Mike Stephens <mike.stephens@intel.com>, linux-kernel@vger.kernel.org,
       bjornw@axis.com, geert@linux-m68k.org, ralf@gnu.org, mkp@mkp.net,
       willy@debian.org, anton@samba.org, gniibe@m17n.org,
       kkojima@rr.iij4u.or.jp, Jeff Dike <jdike@karaya.com>
Subject: Re: Userspace Test Framework for module loader porting 
In-reply-to: Your message of "Fri, 10 Jan 2003 17:47:20 -0800."
             <15903.30632.576801.904652@napali.hpl.hp.com> 
Date: Mon, 13 Jan 2003 11:27:21 +1100
Message-Id: <20030113011128.76CDC2C052@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15903.30632.576801.904652@napali.hpl.hp.com> you write:
> >>>>> On Wed, 08 Jan 2003 22:44:15 +1100, Rusty Russell <rusty@rustcorp.com.a
u> said:
> Yeah, I'm lazy: I don't really want to have to deal with two new
> module loaders: one for 2.6, soon to be followed by one for 2.7.  But
> if someone volunteers to do and _maintain_ an interim kernel loader,
> that's fine with me.

Well, "soon" here is > 12 months away, of course.  And most of it
involves removing, rather than adding, code.

>   Rusty> I thought about letting archs choose which one they wanted to
>   Rusty> use, but it would really mess up the core code.  Of course,
>   Rusty> the transition won't break userspace (kind of the whole point
>   Rusty> of the in-kernel module loader).
> 
> But it would be more in keeping with the Linux philosophy: do the
> Right Thing, fix up "broken" stuff by doing whatever is necessary.

I think you missed the "work around what we can't change" (eg. always
initializing per-cpu variables because Sparc's toolchain is broken, or
adding that crazy restart stuff so we didn't have to create a one-arg
re-enterable nanosleep then make glibc use it).

And, of course, the other Golden Rule: "if it's not x86, it doesn't
matter" 8)

> I'm also a bit worried about changing module loaders so often.  Yeah,
> once you switch to a kernel-loader, presumably users won't be
> affected, but (kernel-module) developers will be.

While ET_DYN modules are a reasonably serious win for ia64 (and
probably hppa) (ie. -300 lines or so), they're a minor win for alpha
and ppc64 (-100 lines or so), and no real change for arm, i386, ppc,
sparc, and sparc64.  It's a lose for x86_64 (toolchain fixes, unless
they want to use -fPIC for modules), mips and mips64 (major toolchain
fixes, unless they want to use -fPIC for modules and stop using r28
for current inside modules).

So, if I were ia64 maintainer, I'd be lobbying for ET_DYN modules now,
too, but I don't it's a big enough general win to outweigh the other
problems.

Sorry,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
