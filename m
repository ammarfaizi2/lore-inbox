Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUAGIvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 03:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265423AbUAGIvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 03:51:46 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:62989 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S265422AbUAGIvj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 03:51:39 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: kernel buildsystem broken on RO medium
Date: Wed, 7 Jan 2004 09:51:27 +0100
User-Agent: KMail/1.5.94
References: <200401070041.41598.arekm@pld-linux.org> <20040107061628.GA2165@mars.ravnborg.org>
In-Reply-To: <20040107061628.GA2165@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401070951.27249.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 of January 2004 07:16, Sam Ravnborg wrote:
> On Wed, Jan 07, 2004 at 12:41:41AM +0100, Arkadiusz Miskiewicz wrote:
> > How to build external kernel modules using kernel buildsystem from RO
> > medium?
> >
> >
> > make[1]: Entering directory
> > `/home/users/misiek/rpm/BUILD/drbd-0.6.10/drbd'
> >
> >     Calling toplevel makefile of kernel source tree, which I believe is
> > in KDIR=/lib/modules/2.6.1/build
> >     NOTE: please ignore warnings regarding overriding of SUBDIRS
> >
> > /usr/bin/make -C /lib/modules/2.6.1/build
> > SUBDIRS=/home/users/misiek/rpm/BUILD/drbd-0.6.10/drbd  modules
>
> Use the O= option to specify a separate output directory,
> where you have RW permissions.
I forgot to write that O= option doesn't work too good:
[misiek@arm ~/rpm/BUILD/drbd-0.6.10/drbd]$ make -C /lib/modules/2.6.1/build SUBDIRS=`pwd` modules O=`pwd`/tmp
make: Entering directory `/usr/src/linux-2.6.1'
/usr/src/linux-2.6.1/Makefile:391: .config: No such file or directory

The present kernel configuration has modules disabled.
Type 'make config' and enable loadable module support.
Then build a kernel with module support enabled.

make[1]: *** [modules] Error 1
make: *** [modules] Error 2
make: Leaving directory `/usr/src/linux-2.6.1'
[misiek@arm ~/rpm/BUILD/drbd-0.6.10/drbd]$ ls -l /usr/src/linux-2.6.1/.config
-rw-r--r--    1 root     root        47918 Jan  5 18:31 /usr/src/linux-2.6.1/.config
[misiek@arm ~/rpm/BUILD/drbd-0.6.10/drbd]$ cp /usr/src/linux-2.6.1/.config ./tmp/
[misiek@arm ~/rpm/BUILD/drbd-0.6.10/drbd]$ make -C /lib/modules/2.6.1/build SUBDIRS=`pwd` modules O=`pwd`/tmp
make: Entering directory `/usr/src/linux-2.6.1'
  Using /usr/src/linux-2.6.1 as source for kernel
  /usr/src/linux-2.6.1 is not clean, please run 'make mrproper'
  in the '/usr/src/linux-2.6.1' directory.
make[1]: *** [prepare1] Error 1
make: *** [modules] Error 2
make: Leaving directory `/usr/src/linux-2.6.1'

and /usr/src/linux-2.6.1 is read-only.

But let's try:
[misiek@arm ~/rpm/BUILD/drbd-0.6.10/drbd]$ sudo make -C /usr/src/linux-2.6.1/ mrproper
Could not retrieve tty information.
make: Entering directory `/usr/src/linux-2.6.1'
  RM  $(CLEAN_FILES)
  Making mrproper in the srctree
  RM  $(MRPROPER_DIRS) + $(MRPROPER_FILES)
make: Leaving directory `/usr/src/linux-2.6.1'
[misiek@arm ~/rpm/BUILD/drbd-0.6.10/drbd]$ make -C /lib/modules/2.6.1/build SUBDIRS=`pwd` modules O=`pwd`/tmp

Wow now works but tell me, how to do make mrproper if /usr/src/linux-2.6.1 is really read-only?
I'm asking because I want to build rpms with kernel modules from non-root and root can have
non-mrproper state in /usr/src/linux-2.6.1.

> 	Sam

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
