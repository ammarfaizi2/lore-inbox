Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTIPBu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 21:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTIPBu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 21:50:58 -0400
Received: from coffee.creativecontingencies.com ([210.8.121.66]:53127 "EHLO
	coffee.cc.com.au") by vger.kernel.org with ESMTP id S261733AbTIPBu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 21:50:57 -0400
Message-Id: <5.1.0.14.2.20030916113642.00b4d538@caffeine.cc.com.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 16 Sep 2003 11:49:30 +1000
To: jdike@karaya.com
From: Peter Lieverdink <lkml@cafuego.net>
Subject: UM Linux 2.6.0-test5 (-mm2) fails to build 
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

I'm having a play with UML (on Debian testing, gcc 2.95.4, x86 box) and the 
um kernel fails to build. Same on Debian unstable with gcc-3.3. Looks like 
either a missing include or changed struct. (or both) My experience extends 
about as far as trying to include <asm/cache.h> (which defines 
CONFIG_X86_L1_CACHE_SHIFT) in "include/linux/sched.h" but that didn't work, 
oh well :-)

Hopefully a more or less useful bugreport.

- Peter.
--
make -f scripts/Makefile.build obj=arch/um/util
gcc -o arch/um/util/mk_task_user.o -c arch/um/util/mk_task_user.c
   CC      arch/um/util/mk_task_kern.o
In file included from include/asm/thread_info.h:13,
                  from include/linux/thread_info.h:21,
                  from include/linux/spinlock.h:12,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/um/util/mk_task_kern.c:1:
include/asm/processor.h:66: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here 
(not in a function)
include/asm/processor.h:66: requested alignment is not a constant
In file included from include/linux/gfp.h:4,
                  from include/linux/slab.h:15,
                  from include/linux/percpu.h:4,
                  from include/linux/sched.h:31,
                  from arch/um/util/mk_task_kern.c:1:
include/linux/mmzone.h:60: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here (not 
in a function)
include/linux/mmzone.h:60: requested alignment is not a constant
arch/um/util/mk_task_kern.c: In function `main':
arch/um/util/mk_task_kern.c:13: structure has no member named `regs'
make[1]: *** [arch/um/util/mk_task_kern.o] Error 1
make: *** [arch/um/util] Error 2

