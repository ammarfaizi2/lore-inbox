Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUHEM5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUHEM5I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266743AbUHEM4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:56:52 -0400
Received: from holomorphy.com ([207.189.100.168]:1731 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267393AbUHEMuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:50:25 -0400
Date: Thu, 5 Aug 2004 05:50:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-ID: <20040805125018.GB14358@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
> +consolidate-prof_cpu_mask.patch
> +profile_pc.patch
> +profile_tick.patch
> +profile-tick-fix.patch
> +move-profile-operations.patch
> +make-private-profile-state-static.patch
> +make-prof_buffer-atomic_t.patch
>  Consolidate a lot of the kernel profiling code.

Minor gaffe on my part:

--- mm1-2.6.8-rc3/include/asm-ia64/ptrace.h.orig	2004-08-05 22:42:16.312957563 -0700
+++ mm1-2.6.8-rc3/include/asm-ia64/ptrace.h	2004-08-05 22:46:36.284634066 -0700
@@ -232,11 +232,11 @@
 /* Conserve space in histogram by encoding slot bits in address
  * bits 2 and 3 rather than bits 0 and 1.
  */
-static inline unsigned long profile_pc(struct pt_regs *regs)
-{
-	unsigned long ip = instruction_pointer(regs);
-	return (ip & ~3UL) + ((ip & 3UL) << 2);
-}
+#define profile_pc(regs)						\
+({									\
+	unsigned long __ip = instruction_pointer(regs);			\
+	(__ip & ~3UL) + ((__ip & 3UL) << 2);				\
+})
 
   /* given a pointer to a task_struct, return the user's pt_regs */
 # define ia64_task_regs(t)		(((struct pt_regs *) ((char *) (t) + IA64_STK_OFFSET)) - 1)
