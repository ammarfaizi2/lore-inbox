Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314687AbSECQlQ>; Fri, 3 May 2002 12:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314689AbSECQlP>; Fri, 3 May 2002 12:41:15 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:17417 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314687AbSECQlO>; Fri, 3 May 2002 12:41:14 -0400
Date: Fri, 3 May 2002 18:41:04 +0200
From: tomas szepe <kala@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 release 2.4
Message-ID: <20020503164104.GC15883@louise.pinerecords.com>
In-Reply-To: <20020503154554.GB15883@louise.pinerecords.com> <15755.1020441446@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 11 days, 9:32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >$ make -f Makefile-2.5 menuconfig
> >[enable RAMDISK support, tweak ramdisk size, enable initrd]
> >...
> >
> >Now, issuing "M installable" will result in nearly all files getting rebuilt.
> >The same happens when switching ramdisk off again. How's that?
> >
> >I tried enabling/disabling many other config options and doing rebuilds but
> >couldn't find anything as damaging buildtime-wise as the ramdisk stuff.
> 
> CONFIG_BLK_DEV_INITRD is tested in include/linux/fs.h.  Because of the
> messy kernel include files, a config change to fs.h affects hundreds of
> other files and forces lots of rebuilds.  This is a separate problem
> from kbuild, other people are looking at cleaning up the include files.


Hold on, there's more :)

/1/

$ cd ~ && rm -rf build && mkdir build && cd build
$ export KBUILD_SRCTREE_000=/usr/src/linux-2.5.13
$ export KBUILD_OBJTREE=$PWD
$ alias M="make -f $KBUILD_SRCTREE_000/Makefile-2.5"
$ touch foo bar baz
$ M mrproper
spec value %p not found
$ ls foo bar baz
/bin/ls: foo: No such file or directory
/bin/ls: bar: No such file or directory
/bin/ls: baz: No such file or directory
$ # oh my! wherez mah precious files gone!

--> *BUUUURN*

/2/

$ cd ~ && rm -rf build && mkdir build && cd build
$ cp /lib/modules/2.5.13/.config .
$ M oldconfig installable
...

--> kbuild repeats launching "oldconfig" till I hit C-c,
never proceeds to "installable".

Of course, issuing "M oldconfig && M installable" works.


T.
