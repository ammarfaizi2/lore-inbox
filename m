Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUHEEsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUHEEsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUHEEsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:48:19 -0400
Received: from holomorphy.com ([207.189.100.168]:64960 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267542AbUHEErl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:47:41 -0400
Date: Wed, 4 Aug 2004 21:47:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [6/13] remove references to start_secondary()
Message-ID: <20040805044736.GX2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org> <20040805043817.GS2334@holomorphy.com> <20040805043957.GT2334@holomorphy.com> <20040805044130.GU2334@holomorphy.com> <20040805044427.GV2334@holomorphy.com> <20040805044627.GW2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805044627.GW2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 09:46:27PM -0700, William Lee Irwin III wrote:
> smp_reschedule_irq() mysteriously vanished sometime after 2.4.
> This patch reinstates it so that the kernel will link properly
> and so cpus will set TIF_NEED_RESCHED when it's asked of them.

This looks rather unusual, however, this is what sparc32 really wants.
The function pointer argument to kernel_thread() is irrelevant here;
the execution state of the thread is established in the SMP trampoline.

Index: mm2-2.6.8-rc2/arch/sparc/kernel/sun4m_smp.c
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/kernel/sun4m_smp.c
+++ mm2-2.6.8-rc2/arch/sparc/kernel/sun4m_smp.c
@@ -124,7 +124,6 @@
 extern int cpu_idle(void *unused);
 extern void init_IRQ(void);
 extern void cpu_panic(void);
-extern int start_secondary(void *unused);
 
 /*
  *	Cycle through the processors asking the PROM to start each one.
@@ -174,7 +173,7 @@
 			int timeout;
 
 			/* Cook up an idler for this guy. */
-			kernel_thread(start_secondary, NULL, CLONE_IDLETASK);
+			kernel_thread(NULL, NULL, CLONE_IDLETASK);
 
 			cpucount++;
 
Index: mm2-2.6.8-rc2/arch/sparc/kernel/sun4d_smp.c
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/kernel/sun4d_smp.c
+++ mm2-2.6.8-rc2/arch/sparc/kernel/sun4d_smp.c
@@ -149,7 +149,6 @@
 extern int cpu_idle(void *unused);
 extern void init_IRQ(void);
 extern void cpu_panic(void);
-extern int start_secondary(void *unused);
 
 /*
  *	Cycle through the processors asking the PROM to start each one.
@@ -202,7 +201,7 @@
 			int no;
 
 			/* Cook up an idler for this guy. */
-			kernel_thread(start_secondary, NULL, CLONE_IDLETASK);
+			kernel_thread(NULL, NULL, CLONE_IDLETASK);
 
 			cpucount++;
 
