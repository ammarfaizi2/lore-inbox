Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267218AbUHENi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267218AbUHENi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267677AbUHENhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:37:20 -0400
Received: from holomorphy.com ([207.189.100.168]:20931 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267683AbUHENgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:36:18 -0400
Date: Thu, 5 Aug 2004 06:36:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-ID: <20040805133615.GF14358@holomorphy.com>
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
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc3/2.6.8-rc3-mm1/
> - Added David Woodhouse's MTD tree to the "external trees" list
> - Dropped the staircase scheduler, mainly because the schedstats patch broke
>   it.
>   We learned quite a lot from having staircase in there.  Now it's time for
>   a new scheduler anyway.

sparc64 needs profile.h and to terminate comments describing %o7.

Index: mm1-2.6.8-rc3/arch/sparc64/kernel/time.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sparc64/kernel/time.c
+++ mm1-2.6.8-rc3/arch/sparc64/kernel/time.c
@@ -29,6 +29,7 @@
 #include <linux/jiffies.h>
 #include <linux/cpufreq.h>
 #include <linux/percpu.h>
+#include <linux/profile.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>
@@ -460,7 +461,7 @@
 	     pc < (unsigned long) &__bzero_end) ||
 	    (pc >= (unsigned long) &__bitops_begin &&
 	     pc < (unsigned long) &__bitops_end))
-		pc = regs->u_regs[UREG_RETPC]; /* o7/
+		pc = regs->u_regs[UREG_RETPC]; /* o7 */
 	return pc;
 }
 
Index: mm1-2.6.8-rc3/arch/sparc64/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sparc64/kernel/smp.c
+++ mm1-2.6.8-rc3/arch/sparc64/kernel/smp.c
@@ -19,6 +19,7 @@
 #include <linux/seq_file.h>
 #include <linux/cache.h>
 #include <linux/jiffies.h>
+#include <linux/profile.h>
 
 #include <asm/head.h>
 #include <asm/ptrace.h>
