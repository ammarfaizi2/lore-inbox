Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263155AbUKTTQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbUKTTQg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 14:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUKTTQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 14:16:34 -0500
Received: from marfik.cc.upv.es ([158.42.249.16]:8135 "EHLO smtpsal.upv.es")
	by vger.kernel.org with ESMTP id S263155AbUKTTQU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 14:16:20 -0500
Date: Sat, 20 Nov 2004 20:16:17 +0100 (MET)
From: Linux Mailing Lists <linux@aiind.upv.es>
To: linux-kernel@vger.kernel.org
Subject: Problem compiling 2.4.28 [dn_neigh.c]
Message-ID: <Pine.LNX.4.58.0411201948310.18643@andercheran.aiind.upv.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

While compiling the lastest 2.4 kernel I stumbled on this error:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.28/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i586  -DMODULE  -nostdinc
-iwithprefix include -DKBUILD_BASENAME=dn_dev  -c -o dn_dev.o dn_dev.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.28/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i586  -DMODULE  -nostdinc
-iwithprefix include -DKBUILD_BASENAME=dn_neigh  -c -o dn_neigh.o
dn_neigh.c
dn_neigh.c:584: `THIS_MODULE' undeclared here (not in a function)
dn_neigh.c:584: initializer element is not constant
dn_neigh.c:584: (near initialization for `dn_neigh_seq_fops.owner')
make[2]: *** [dn_neigh.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.28/net/decnet'
make[1]: *** [_modsubdir_decnet] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.28/net'
make: *** [_mod_net] Error 2

I followed the same steps as always to do the compilation:

- I copied linux-2.4.27/.config to linux-2.4.28/.config
- I made an "make oldconfig" in the 2.4.28 directory
- Then I tried to compile the kernel and the modules, as usual, with "make
dep; make clean; make bzImage; make modules"

I Googled the archives of the list to see if someone had reported this
error, but I didn't seem to find anything about it. I found a patch for a
similar error (from quite a while ago) and tried it, and the compilation
went fine.

The patch is very simple, I just added the line:

#include <linux/module.h>

To dn_neigh.c and ¡voilá! the compilation went without a single warning at
that point.

I got this error in three different Linux machines.

Greetings.
