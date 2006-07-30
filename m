Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWG3RAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWG3RAg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWG3RAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:00:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:34516 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751227AbWG3RAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:00:35 -0400
From: Andi Kleen <ak@suse.de>
To: sam@ravnborg.org
Subject: Building external modules against objdirs
Date: Sun, 30 Jul 2006 18:46:07 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, agruen@suse.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301846.07797.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It looks like building external modules against separate objdirs doesn't work 
anymore in 2.6.18.

tmod is a simple module I use for some testing.

obj-* are objdirs tree built against separate source with make O=$(pwd) -C ../linux-...

> cat Makefile 
obj-m := tmod.o

KERNELDIR := /lib/modules/`uname -r`/build

all:
        $(MAKE) -C ${KERNELDIR} M=`pwd`

With 2.6.17 it works great:

> make KERNELDIR=/home/lsrc/obj-2.6.17
make -C /home/lsrc/obj-2.6.17 M=`pwd`
make[1]: Entering directory `/home/lsrc/obj-2.6.17'
make -C /home/lsrc/linux-2.6.17 O=/home/lsrc/obj-2.6.17
  Building modules, stage 2.
  MODPOST
  CC      /home/andi/tsrc/tmod/tmod.mod.o
  LD [M]  /home/andi/tsrc/tmod/tmod.ko
make[1]: Leaving directory `/home/lsrc/obj-2.6.17'


But with 2.6.18-rc3 it doesn't work anymore. I saw this for at least a few weeks already
with 2.6.17-git*, but only realized now it wasn't some stupid mistake on my side.

> make -C /home/lsrc/quilt/obj M=`pwd`
make[1]: Entering directory `/home/lsrc/quilt/obj'
make -C /basil/home/lsrc/quilt/linux O=/basil/home/lsrc/quilt/obj
/home/lsrc/quilt/linux/Makefile:456: *** kernel configuration not valid - run 'make prepare' in /home/lsrc/quilt/linux to update it.  Stop.
make[2]: *** [_all] Error 2
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/lsrc/quilt/obj'
make: *** [all] Error 2

Is there a workaround? It would be good to fix it for 2.6.18 because it will
likely cause trouble for a lot of external projects.

-Andi
