Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314465AbSECPq1>; Fri, 3 May 2002 11:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314469AbSECPq0>; Fri, 3 May 2002 11:46:26 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:57608 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314465AbSECPqZ>; Fri, 3 May 2002 11:46:25 -0400
Date: Fri, 3 May 2002 17:45:54 +0200
From: tomas szepe <kala@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20020503154554.GB15883@louise.pinerecords.com>
In-Reply-To: <20020503143738.GC14121@louise.pinerecords.com> <14454.1020439786@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 11 days, 9:32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 3 May 2002 16:37:38 +0200, 
> tomas szepe <kala@pinerecords.com> wrote:
>
> >kala@nibbler:~$ tar xzf /usr/src/linux-2.5.13.tgz 
> >kala@nibbler:~$ cd linux-2.5.13 
> >kala@nibbler:~/linux-2.5.13$ zcat /usr/src/kbuild-2.5-core-10.gz /usr/src/kbuild-2.5-common-2.5.13-1.gz /usr/src/kbuild-2.5-i386-2.5.13-1.gz |patch -sp1
> >kala@nibbler:~/linux-2.5.13$ cp /lib/modules/2.5.13/.config .
> >kala@nibbler:~/linux-2.5.13$ make -f Makefile-2.5 oldconfig
> >Makefile-2.5:251: /no_such_file-arch/i386/Makefile.defs.noconfig: No such file or directory
> 
> The trailing '/' is omitted in one case.  Workaround for common source and object
> 
> export KBUILD_SRCTREE_000=`pwd`/
> make -f Makefile-2.5 oldconfig

Another problem/question:

$ cd build
$ export KBUILD_OBJTREE=$PWD
$ export KBUILD_SRCTREE_000=/usr/src/linux-2.5.13
$ alias M="make -f $KBUILD_SRCTREE_000/Makefile-2.5"
$ cp /lib/modules/2.5.13/.config .
$ M oldconfig
...

$ M installable
...

[so far so good]

$ make -f Makefile-2.5 menuconfig
[enable RAMDISK support, tweak ramdisk size, enable initrd]
...

Now, issuing "M installable" will result in nearly all files getting rebuilt.
The same happens when switching ramdisk off again. How's that?

I tried enabling/disabling many other config options and doing rebuilds but
couldn't find anything as damaging buildtime-wise as the ramdisk stuff.

Hopefully I'm causing no headaches,
T.
