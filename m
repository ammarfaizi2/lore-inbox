Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265985AbSKDIcp>; Mon, 4 Nov 2002 03:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265988AbSKDIcp>; Mon, 4 Nov 2002 03:32:45 -0500
Received: from dp.samba.org ([66.70.73.150]:28322 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265985AbSKDIco>;
	Mon, 4 Nov 2002 03:32:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Fix BUG() decl warning in smp.h for UP
Date: Mon, 04 Nov 2002 18:32:05 +1100
Message-Id: <20021104083918.39BA52C2CB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86 always seems to include asm/page.h, PPC (and presumably others) don't.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22822-2.5.45-bk-module-ppc.pre/include/linux/smp.h .22822-2.5.45-bk-module-ppc/include/linux/smp.h
--- .22822-2.5.45-bk-module-ppc.pre/include/linux/smp.h	2002-10-15 15:19:44.000000000 +1000
+++ .22822-2.5.45-bk-module-ppc/include/linux/smp.h	2002-11-04 18:28:52.000000000 +1100
@@ -79,6 +79,7 @@ extern void unregister_cpu_notifier(stru
 
 int cpu_up(unsigned int cpu);
 #else /* !SMP */
+#include <asm/page.h> /* For BUG() */
 
 /*
  *	These macros fold the SMP functionality into a single CPU system

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
