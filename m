Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267480AbUHEEkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267480AbUHEEkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267484AbUHEEkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:40:25 -0400
Received: from holomorphy.com ([207.189.100.168]:60352 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267480AbUHEEkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:40:02 -0400
Date: Wed, 4 Aug 2004 21:39:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [2/13] sparc32 init_idle()
Message-ID: <20040805043957.GT2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org> <20040805043817.GS2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805043817.GS2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 09:38:17PM -0700, William Lee Irwin III wrote:
> viro needs to do sparse work on sparc32, so this series of patches
> fixes up the compile for him.

An analysis of the code determined that AP initialization called
init_idle() no less than three times, 2 out of the three with incorrect
numbers of arguments. This patch removes the superfluous calls.


Index: mm2-2.6.8-rc2/arch/sparc/kernel/sun4m_smp.c
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/kernel/sun4m_smp.c
+++ mm2-2.6.8-rc2/arch/sparc/kernel/sun4m_smp.c
@@ -95,8 +95,6 @@
 	 * the SMP initialization the master will be just allowed
 	 * to call the scheduler code.
 	 */
-	init_idle();
-
 	/* Allow master to continue. */
 	swap((unsigned long *)&cpu_callin_map[cpuid], 1);
 
Index: mm2-2.6.8-rc2/arch/sparc/kernel/sun4d_smp.c
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/kernel/sun4d_smp.c
+++ mm2-2.6.8-rc2/arch/sparc/kernel/sun4d_smp.c
@@ -100,8 +100,6 @@
 	 * the SMP initialization the master will be just allowed
 	 * to call the scheduler code.
 	 */
-	init_idle();
-
 	/* Get our local ticker going. */
 	smp_setup_percpu_timer();
 
Index: mm2-2.6.8-rc2/arch/sparc/kernel/trampoline.S
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/kernel/trampoline.S
+++ mm2-2.6.8-rc2/arch/sparc/kernel/trampoline.S
@@ -88,8 +88,6 @@
 	.align	4
 
 smp_do_cpu_idle:
-	call	init_idle
-	 nop
 	call	cpu_idle
 	 mov	0, %o0
 
