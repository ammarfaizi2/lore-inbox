Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbTD0CLk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 22:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTD0CLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 22:11:40 -0400
Received: from zero.aec.at ([193.170.194.10]:57613 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263253AbTD0CLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 22:11:38 -0400
Date: Sun, 27 Apr 2003 04:23:46 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Support worst case cache line sizes as config option
Message-ID: <20030427022346.GA27933@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This mirrors a change that has been in the SuSE/aa 2.4 kernel for a long time.

For a generic binary kernel you really want to assume the worst case
cache line size.  That's the P4's 128 byte currently.

The overhead of having the cache line size bigger on other CPUs is not
that bad, but if it is too small it will cost you dearly on SMP and
even a bit on UP in device drivers. 

This patch adds a new CONFIG_X86_GENERIC option for this. It currently
only forces 128byte cache lines, but could be used for more in the future.

diff -u linux-gencpu/arch/i386/Kconfig-o linux-gencpu/arch/i386/Kconfig
--- linux-gencpu/arch/i386/Kconfig-o	2003-04-27 02:40:32.000000000 +0200
+++ linux-gencpu/arch/i386/Kconfig	2003-04-27 03:50:08.000000000 +0200
@@ -273,6 +273,13 @@
 
 endchoice
 
+config X86_GENERIC
+       bool "Generic x86 support" 
+       help
+       	  Include some tuning for non selected x86 CPUs too.
+	  when it has moderate overhead. This is intended for generic 
+	  distributions kernels.
+
 #
 # Define implied options from the CPU selection here
 #
@@ -288,10 +295,10 @@
 
 config X86_L1_CACHE_SHIFT
 	int
+	default "7" if MPENTIUM4 || X86_GENERIC
 	default "4" if MELAN || M486 || M386
 	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
 	default "6" if MK7 || MK8
-	default "7" if MPENTIUM4
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
