Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVC1Mo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVC1Mo6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 07:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVC1Mo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 07:44:58 -0500
Received: from aurora.bayour.com ([212.214.70.50]:48787 "EHLO
	aurora.bayour.com") by vger.kernel.org with ESMTP id S261707AbVC1Mol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 07:44:41 -0500
To: linux-kernel@vger.kernel.org
Subject: Compile fails on SPARC64 - include/linux/sched.h:1171: request for
 member `break_lock' in something not a structure or union
X-PGP-Fingerprint: B7 92 93 0E 06 94 D6 22  98 1F 0B 5B FE 33 A1 0B
X-PGP-Key-ID: 0x788CD1A9
X-URL: http://www.bayour.com/
From: Turbo Fredriksson <turbo@bayour.com>
Organization: Bah!
Date: Mon, 28 Mar 2005 14:41:34 +0200
Message-ID: <87d5tk2b9d.fsf@pumba.bayour.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried 2.6.11.6, 2.6.11.6-bk1 and 2.6.12-rc1.

----- s n i p -----
CHROOT Aurora/Woody-devel# make
  CHK     include/linux/version.h
  CC      init/main.o
In file included from include/linux/module.h:10,
                 from init/main.c:16:
include/linux/sched.h: In function `lock_need_resched':
include/linux/sched.h:1171: request for member `break_lock' in something not a structure or union
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2
----- s n i p -----

rgrep'ing in include/ shows that it's defined in all
but 'include/asm-sparc64/spinlock.h':

----- s n i p -----
CHROOT Aurora/Woody-devel# rgrep break_lock include | sort | uniq
include/asm-alpha/spinlock.h:   unsigned int break_lock;
include/asm-arm/spinlock.h:     unsigned int break_lock;
include/asm-i386/spinlock.h:    unsigned int break_lock;
include/asm-ia64/spinlock.h:    unsigned int break_lock;
include/asm-m32r/spinlock.h:    unsigned int break_lock;
include/asm-mips/spinlock.h:    unsigned int break_lock;
include/asm-parisc/spinlock.h:  unsigned int break_lock;
include/asm-parisc/system.h:    unsigned int break_lock;
include/asm-ppc/spinlock.h:     unsigned int break_lock;
include/asm-ppc64/spinlock.h:   unsigned int break_lock;
include/asm-s390/spinlock.h:    unsigned int break_lock;
include/asm-sh/spinlock.h:      unsigned int break_lock;
include/asm-sparc/spinlock.h:   unsigned int break_lock;
include/asm-x86_64/spinlock.h:  unsigned int break_lock;
include/linux/sched.h:# define need_lockbreak(lock) ((lock)->break_lock)
----- s n i p -----

Kernel config can be found at http://www.bayour.com/config-2.6.12-rc1.txt.
