Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261198AbRFWQZq>; Sat, 23 Jun 2001 12:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbRFWQZh>; Sat, 23 Jun 2001 12:25:37 -0400
Received: from Expansa.sns.it ([192.167.206.189]:7178 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S261198AbRFWQZV>;
	Sat, 23 Jun 2001 12:25:21 -0400
Date: Sat, 23 Jun 2001 18:25:18 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "D. Stimits" <stimits@idcomm.com>
cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: Is this part of newer filesystem hierarchy?
In-Reply-To: <3B341D4D.D54103B9@idcomm.com>
Message-ID: <Pine.LNX.4.33.0106231809040.28120-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jun 2001, D. Stimits wrote:

> Luigi Genoni wrote:
> >
> > Again i am confused.
> >
> > /usr/bin/ld is linker at compilation time, at it works how i told in
> > second part
> > of my mail, (just try to compile it, it comes with binutils,
> > ftp.kernel.org/pub/linux/devel/binutils).
> >
> > /lib/d-2.2.X.so  is what you are talking about.
> > So should i think os an hack to ld-2.2.3.so ??
>
> The RH 7.1 comes with:
> :~# ld --version
> GNU ld 2.10.91
> Copyright 2001 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms
> of
> the GNU General Public License.  This program has absolutely no
> warranty.
>   Supported emulations:
>    elf_i386
>    i386linux
>    elf_i386_glibc21
Ok, this is the linker for compilation time, it
is not related to the loader for shared libraries. You can even remove
/usr/bin/ld, and the system will run anyway binaries, but you will not be
able to link compiled objects.
try a find for the directory ldscripts or for those files,

elf_i386.x    elf_i386.xs   i386coff.xn  i386linux.xbn
elf_i386.xbn  elf_i386.xu   i386coff.xr  i386linux.xn
elf_i386.xn   i386coff.x    i386coff.xu  i386linux.xr
elf_i386.xr   i386coff.xbn  i386linux.x  i386linux.xu

you could not find the *coff* ones....
those are the configuration file (unproper definition, i ask
excuse for my english), for /usr/bin/ld you are running
doing ld --version.
>
> The glibc rpm is version 2.2.2-10.
>
> >
> > to see how it works loock at /usr/bin/ldd, it's an interesting script.
> >
> > I can understand why old glibc 2.1 is not isered in the directories
> > where ldconfig has to loock to create its db for loader, but there should
> > be a corrispective /usr/i386-(redhat/glibc2.2???)-linux/ (with its
> > subdirectories)
> > for glibc 2.2, since it is necessary at compilation
> > time.
>
> There is *no* /usr/i386-xxx except for:
> /usr/i386-glibc21-linux/
name could be different, just could you e-mail the output for
the command tree inside of /usr?
>
> No glibc22 version exists.
>
> > This do not change the problem which is related to /lib/ld-2.2.X.so.
> > doing a strings /lib/ld-2.XXX
> > you will find also
> >
> > info[19]->d_un.d_val == sizeof (Elf32_Rel)
> > info[20]->d_un.d_val == 17
> > /lib/
> > /usr/lib/
> > {ORIGIN}
> > {PLATFORM}
> > expand_dynamic_string_token
> > dl-load.c
>
> "i686" is visible on a line by itself, but so are i386, i486, and i586.
this is another thing...
> The full path of /lib/i686/ is not mentioned anywhere. So it looks like
> strings of /lib/ld-2* does not offer any hints as to how the i686
> subdirectory is being chosen without it being specified anywhere else. I
> think this will end up just being one of those mysteries, and the boot
> software coder will have to find some non-trivial workaround. It sounds
> like the /lib/i686/ path was hardcoded in the linker when it was
> compiled, which means there are no simple config file checks.
and then they compiled ALL other binaries from scratch with new linker,
passing /lib/i686/libc.so.6 explivitally, or changing the script
/usr/lib/libc.so?

boh! I do not know, and I am not thinking I am going to install a Red Hat
right now (simply it is not suitable for my needs, it is a great
distribution, of course, but it is not what my users need).

want my suggestion?
upgrade to glibc 2.2.3 and to binutils 2.11.90.0.19 building
them from sources against 2.4.X kernel includes. And you wil see if it
works how you would expect.

Luigi


