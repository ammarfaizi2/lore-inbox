Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWBBSOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWBBSOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 13:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWBBSOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 13:14:43 -0500
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:199 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750773AbWBBSOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 13:14:42 -0500
Date: Thu, 2 Feb 2006 13:12:37 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16-rc1-mm4 i386 atomic operations broken on SMP (in
  modules at least)
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Gerd Hoffman <kraxel@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602021314_MC3-1-B765-7FAF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <17377.24090.486443.865483@cse.unsw.edu.au>

On Thu, 2 Feb 2006 at 12:19:22 +1100, Neil Brown wrote:

> My guess is there is there is something wrong with the 'alternative'
> stuff which strips out the lock prefix, but I couldn't see anything
> obviously wrong.  The CPUs don't have FEATURE_UP (see below) so it
> cannot possibly be removing the 'lock' prefix... but it certainly acts
> like it is.

Look closer:

> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
> constant_tsc pni monitor ds_cpl cid xtpr
  ^^^^^^^^^^^^

SMP alternatives is re-using the constant_tsc X86 feature bit.

--- 2.6.16-rc1-mm4-386.orig/include/asm-i386/cpufeature.h
+++ 2.6.16-rc1-mm4-386/include/asm-i386/cpufeature.h
@@ -71,7 +71,7 @@
 #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
 #define X86_FEATURE_CONSTANT_TSC (3*32+ 8) /* TSC ticks at a constant rate */
 
-#define X86_FEATURE_UP		(3*32+ 8) /* smp kernel running on up */
+#define X86_FEATURE_UP		(3*32+ 9) /* smp kernel running on up */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
-- 
Chuck
