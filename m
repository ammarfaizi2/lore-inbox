Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWEQKBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWEQKBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 06:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWEQKBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 06:01:32 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:24207 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932520AbWEQKB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 06:01:29 -0400
Date: Wed, 17 May 2006 06:01:01 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: LKML <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Paul Mackerras <paulus@samba.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, davem@davemloft.net, arnd@arndb.de,
       kenneth.w.chen@intel.com, sam@ravnborg.org, clameter@sgi.com,
       kiran@scalex86.org
Subject: [RFC PATCH 07/09] robust VM per_cpu i386 VM area
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605170600250.8408@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allocates the percpu VM area using the fix addresses.
It defines currently 1 meg per cpu.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-test/include/asm-i386/fixmap.h
===================================================================
--- linux-2.6.16-test.orig/include/asm-i386/fixmap.h	2006-05-17 04:32:27.000000000 -0400
+++ linux-2.6.16-test/include/asm-i386/fixmap.h	2006-05-17 04:59:34.000000000 -0400
@@ -32,6 +32,10 @@
 #include <asm/kmap_types.h>
 #endif

+/* One meg per cpu of VM space */
+#define PERCPU_PAGES 256
+#define PERCPU_SIZE (PERCPU_PAGES << PAGE_SHIFT)
+
 /*
  * Here we define all the compile-time 'special' virtual
  * addresses. The point is to have a constant address at
@@ -83,6 +87,8 @@ enum fixed_addresses {
 #ifdef CONFIG_PCI_MMCONFIG
 	FIX_PCIE_MCFG,
 #endif
+	FIX_PERCPU_BEGIN,
+	FIX_PERCPU_END = FIX_PERCPU_BEGIN+(PERCPU_PAGES*NR_CPUS)-1,
 	__end_of_permanent_fixed_addresses,
 	/* temporary boot-time mappings, used before ioremap() is functional */
 #define NR_FIX_BTMAPS	16

