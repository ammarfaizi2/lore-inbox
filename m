Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267019AbSLKGv7>; Wed, 11 Dec 2002 01:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267028AbSLKGv6>; Wed, 11 Dec 2002 01:51:58 -0500
Received: from h-64-105-35-2.SNVACAID.covad.net ([64.105.35.2]:42912 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267019AbSLKGv5>; Wed, 11 Dec 2002 01:51:57 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 10 Dec 2002 22:50:20 -0800
Message-Id: <200212110650.WAA13780@adam.yggdrasil.com>
To: jchua@fedex.com
Subject: Re: 2.5.51 ide module problem
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>depmod will ecounter "Segmentation fault" if the ide.ko and ide-io.ps
>modules are in /lib/modules/2.5.51/kernel

	I think the new depmod recurses infinitely when it encounters
circular dependencies.  It eventually segfaults and leaves a huge
modules.dep file from the infinite loop.  If you look at the final
huge line in that file, you can see where the loop occurred.

	depmod has no need to do any recursion, since it only needs
to determine the immediate dependencies of each module.  However,
noticing such loops and printing them out would be a handy feature.

	I use IDE as a module, but I had to change the Makefile to
build a big ide-mod.o from most of the core objects rather than
allowing each one to be its own module.  I believe I posted IDE
modularization patches at least once a couple of months ago, but it
seems to have fallen between the cracks.  I could repost it if need
be, although I have not yet booted 2.5.51.

	Also note that I have not used the in kernel-based module
loader recently, as I have been patching my kernels to use the user
level module code.  I am planning to try the kernel-base module loader
in 2.5.51 once I fix other problems it has finding the root device
under devfs.  So, it's remotely possible that you may also see module
problems that I've missed.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
