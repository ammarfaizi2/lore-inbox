Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286769AbSABExD>; Tue, 1 Jan 2002 23:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286765AbSABEwx>; Tue, 1 Jan 2002 23:52:53 -0500
Received: from hera.cwi.nl ([192.16.191.8]:49540 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S286744AbSABEwm>;
	Tue, 1 Jan 2002 23:52:42 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 2 Jan 2002 04:52:15 GMT
Message-Id: <UTC200201020452.EAA175954.aeb@cwi.nl>
To: neilb@cse.unsw.edu.au, torvalds@transmeta.com, trond.myklebust@fys.uio.no
Subject: Re: NFS "dev_t" issues..
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I made a pre6, which contains a new-and-anal "kdev_t".

Nice! And even in my original form, with these heavy kdev_same
and kdev_none things :-).

I booted a kernel but had quite a lot to change, the patch
is large. I can send it, but instead:

(i) I changed almost every single MKDEV to mk_kdev.
Of course, the kernel was rather kdev_t clean, it was
not difficult to run with kdev_t a different type, so
there are very few places where this is inappropriate,
and the number of correct places is so large that a
global command, followed by a revert in these very few
places, seems more appropriate than a large patch.
Moreover, probably you and others did part of this already.

Not to be changed:
./init/do_mounts.c: sys_mknod("/dev/console", S_IFCHR|0600, MKDEV(TTYAUX_MAJOR, 1));
./arch/sparc64/solaris/fs.c: sys_mknod((const char *)A(path), mode, MKDEV(major,minor));
./include/linux/kdev_t.h

All else should be changed (or at least: did I change, I may have
overlooked sth).

In do_mounts.c there is a real_root_dev set via /proc, and I left it
an integer, while ROOT_DEV is a kdev_t, which implies the
appropriate conversions there.

(ii) Then there are MAJOR and MINOR. I did not change these to
major and minor, mainly because in some possible futures
it will be necessary to do a lot of grepping for these again -
almost all occurrences should be removed - and major and minor
are such common words. It is nicer to have something more unique,
like kmajor and kminor. Moreover, major and minor do at present
also occur as ordinary variables.
Are kmajor, kminor acceptable?

Andries

