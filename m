Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSEDK7M>; Sat, 4 May 2002 06:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312449AbSEDK7M>; Sat, 4 May 2002 06:59:12 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:11530 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S312447AbSEDK7L>; Sat, 4 May 2002 06:59:11 -0400
Date: Sat, 4 May 2002 12:58:57 +0200
From: tomas szepe <kala@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 release 2.4
Message-ID: <20020504105857.GC17252@louise.pinerecords.com>
In-Reply-To: <20020503154554.GB15883@louise.pinerecords.com> <15755.1020441446@ocs3.intra.ocs.com.au> <20020503164104.GC15883@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 11 days, 12:58)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> $ cd ~ && rm -rf build && mkdir build && cd build
> $ export KBUILD_SRCTREE_000=/usr/src/linux-2.5.13
> $ export KBUILD_OBJTREE=$PWD
> $ alias M="make -f $KBUILD_SRCTREE_000/Makefile-2.5"
> $ touch foo bar baz
> $ M mrproper
> spec value %p not found
> $ ls foo bar baz
> /bin/ls: foo: No such file or directory
> /bin/ls: bar: No such file or directory
> /bin/ls: baz: No such file or directory
> $ # oh my! wherez mah precious files gone!


Duh... I failed to demonstrate the real problem: kbuild-2.5's mrproper
also erases *non-zero-size* files in the object tree:

$ pwd
/home/kala/build
$ set| grep KBUILD
KBUILD_OBJTREE=/home/kala/build
KBUILD_SRCTREE_000=/usr/src/linux-2.5.13
$ alias M='make -f /usr/src/linux-2.5.13/Makefile-2.5'
$ echo foo >bar
$ ls -l bar
-rw-r--r--    1 kala     users           4 May  4 12:56 bar
$ M mrproper
spec value %p not found
$ ls -la
total 3
drwxr-xr-x    2 kala     users          48 May  4 12:56 ./
drwx--x--x   26 kala     users        1664 May  3 19:58 ../


T.
