Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269351AbRHQBVw>; Thu, 16 Aug 2001 21:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269354AbRHQBVm>; Thu, 16 Aug 2001 21:21:42 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:36997 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269351AbRHQBVf>; Thu, 16 Aug 2001 21:21:35 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 16 Aug 2001 11:21:45 -0700
Message-Id: <200108161821.LAA02805@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.9: atomic_dec_and_lock sometimes used while not defined
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	If I try to build a kernel that can do SMP and run on a 386,
the linux-2.4.9 NFS client gets compiled with an undefined reference
to atomic_dec_and_lock().  I imagine that the correct fix is to
change the ifdefs that bracket the following line in include/linux/spinlock.h:

#define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)

	However, I'm really not clear enough on the semantics of
atomic_dec_and_lock vs. atomic_dec_and_test to know whether this
is safe.

	Also, it looks like arch/sparc64/sparc64_ksyms.c references
atomic_dec_and_test without it every being defined on any architecture
other than x86, so I am suspicious of a partially applied patch here.

	If nobody has a better idea, I'm going to move the
#define statement that I mentioned above out of its current
ifdef logic and just bracket it like so:

#ifndef CONFIG_HAVE_DEC_LOCK
#define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
#endif

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
