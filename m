Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLRQYM>; Mon, 18 Dec 2000 11:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLRQYB>; Mon, 18 Dec 2000 11:24:01 -0500
Received: from marjorie.loran.com ([209.167.240.3]:52236 "HELO
	marjorie.loran.com") by vger.kernel.org with SMTP
	id <S129260AbQLRQXw>; Mon, 18 Dec 2000 11:23:52 -0500
Message-ID: <024701c0690a$56f9ba10$890216ac@ottawa.loran.com>
From: "Dana Lacoste" <dana.lacoste@peregrine.com>
To: "Peter Samuelson" <peter@cadcamlab.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com> <91bnoc$vij$2@enterprise.cistron.net> <20001215155741.B4830@ping.be> <01cf01c066ab$036fc030$890216ac@ottawa.loran.com> <20001216164151.J3199@cadcamlab.org>
Subject: Re: Linus's include file strategy redux
Date: Mon, 18 Dec 2000 10:51:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter Samuelson" <peter@cadcamlab.org> wrote :
> [Dana Lacoste]
> > 2 - programs that need to compile against the current kernel MUST
> >     be able to do so in a quasi-predictable manner.

> (2) is bogus.  NO program needs to compile against the current kernel
> headers.  The only things that need to compile against the current
> kernel headers are kernel modules and perhaps libc itself.  As I put it
> a few days ago--

>   http://marc.theaimsgroup.com/?l=linux-kernel&m=97658613604208&w=2

> So for your external modules, let me suggest the lovely
> /lib/modules/{version}/build/include/.  Recent-ish modutils required.

ok, i'll rephrase my request :)

For sake of argument (i.e. this might not be true, but pretend it is :)

- I write an external/third party kernel module
- For various reasons, I must have this kernel module installed to boot
  (i can't compile without my module running)
- I need to upgrade kernels to a new version, one where there are
  not-insignificant changes in the kernel headers.
- I distribute this module online, and thousands of people use this module
  with various platform and distribution combinations.

How can I know where the 'correct' Linux kernel headers are in such
a way that is as transparent as possible to the user doing the compiling?

Potential answers that have come up so far :
1 - /lib/modules/* directories that involve `uname -r`
    This won't work because i might not be compiling for the `uname -r` kernel
2 - /lib/modules/<version>/build/include/ :
    we could recommend that all kernel headers for all versions be put in
    the directory with the modules as listed above.  someone doesn't like
    the idea of symlinks (dangling symlinks ARE bad :) and someone else
pointed
    out that his root partition is only 30MB.  therefore this idea has flaws
    too.
3 - the script (Config.make, etc) approach : several people recommended one
    kind or another of script that could be run prior to compilation that
    could set all the relevant variables, including one that would point to
    where the kernel headers are, and one that would have the 'correct'
    compile flags, etc.
4 - a link in the /usr/include directory tree that points to the kernel
headers,
    so that /usr/include/linux would have the glibc-compiled headers, and this
    other directory would have the current kernel's headers : this doesn't
    really support cross-compiling.

#1 and #2 and #4 all seem to be limiting somehow.  I think the biggest problem
so far has been that many developers don't recognize just how varied the linux
development universe is!  For me personally, it's nothing to cross-compile for
other hardware platforms, and any solution that doesn't take that possibility
into account is just being silly :)

Can we get a #3 going?  I think it could really help both the cross-compile
people and those who just want to make sure their modules are compiling in
the 'correct' environment.  It also allows for things like 'kgcc vs. gcc' to
be 'properly' resolved by the distribution-creator as it should be, instead of
linux-kernel or the 3rd party module mailing lists.

So?  What do you think?

--
Dana Lacoste
Linux Developer
Peregrine Systems


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
