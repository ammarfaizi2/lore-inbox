Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbQLOHx4>; Fri, 15 Dec 2000 02:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130191AbQLOHxg>; Fri, 15 Dec 2000 02:53:36 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:53786 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129421AbQLOHx2>; Fri, 15 Dec 2000 02:53:28 -0500
From: "LA Walsh" <law@sgi.com>
To: "Alexander Viro" <viro@math.psu.edu>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Subject: RE: Linus's include file strategy redux
Date: Thu, 14 Dec 2000 23:21:31 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHCENKCJAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.GSO.4.21.0012141900140.10441-100000@weyl.math.psu.edu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Huh?
> % ls -ld /usr/include/linux
> drwxr-xr-x    6 root     root        18432 Sep  2 22:35
> /usr/include/linux/
>
> > So if we create a separate /usr/src/linux/include/kernel dir, does that
> > imply that we'll have a 2nd link:
>
> What 2nd link? There should be _no_ links from /usr/include to the
> kernel tree. Period. Case closed.
---

> ll -d /usr/include/linux
lrwxrwxrwx   1 root     root           26 Dec 25  1999 /usr/include/linux ->
../src/linux/include/linux/
---

	I've seen this setup on RH, SuSE and Mandrake systems.  I thought
this was somehow normal practice?


> Stuff in /usr/include is private libc copy extracted from some kernel
> version. Which may have _nothing_ to the kernel you are developing for.
> In the situation above they should have
> -I<wherever_the_tree_lives>/include
> in CFLAGS. Always had to. No links, no pain in ass, no interference with
> userland compiles.
>
> IOW, let them fix their Makefiles.
---

	Why would Linus want two separate directories -- one for 'kernel-only'
include files and one for kernel files that may be included in user
land?  It seems to me, if /usr/include/linux was normally a separate
directory there would be no need for him to mention a desire to create
a separate kernel-only include directory, so my assumption was the
linked behavior was somehow 'normal'.

	I think many source packages only use "-I /usr/include" and
make no provision for compiling against kernel header files in
different locations that need to be entered by hand. It is difficult
to create an automatic package regeneration mechanism like RPM if such
details need to be entered for each package.

	So what you seem to be saying, if I may rephrase, is that
the idea of automatic package generation for some given kernel is
impractical because users should be expected to edit each package
makefile for their own setup with no expectation from the packages
designers of a standard kernel include location?

	I'm not convinced this is a desirable goal.

:-/
-linda



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
