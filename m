Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWHXK67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWHXK67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWHXK65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:58:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39050 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751094AbWHXK64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:58:56 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Beulich <jbeulich@novell.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Date: Thu, 24 Aug 2006 03:58:46 -0700
Message-Id: <20060824105846.23508.59971.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH] x86_64: mm fix x86 cpuid keys used in alternative_smp fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

The x86_64 crosstool build was failing due to:

  kernel/built-in.o(.smp_altinstructions+0x58): \
    include/asm/spinlock.h:54: undefined reference to `X86_FEATURE_UP'

This reference to X86_FEATURE_UP was added to the definition of
the alternative_smp() macro in alternative.h by the patch:
  x86_64-mm-fix-x86-cpuid-keys-used-in-alternative_smp

The alternative_smp() macro is used in spinlock.h.

The definition of X86_FEATURE_UP is in asm-x86_64/cpufeature.h.
If this is included in alternative.h, then the build succeeds.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/asm-x86_64/alternative.h |    1 +
 1 files changed, 1 insertion(+)

--- 2.6.18-rc4-mm2.orig/include/asm-x86_64/alternative.h	2006-08-24 03:37:22.000000000 -0700
+++ 2.6.18-rc4-mm2/include/asm-x86_64/alternative.h	2006-08-24 03:38:09.000000000 -0700
@@ -4,6 +4,7 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
+#include <asm/cpufeature.h>
 
 struct alt_instr {
 	u8 *instr; 		/* original instruction */

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
