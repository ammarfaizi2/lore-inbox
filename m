Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267547AbUHEEwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267547AbUHEEwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUHEEvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:51:17 -0400
Received: from holomorphy.com ([207.189.100.168]:65472 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267499AbUHEEsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:48:45 -0400
Date: Wed, 4 Aug 2004 21:48:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [7/13] remove references to num_context_patch2
Message-ID: <20040805044839.GY2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org> <20040805043817.GS2334@holomorphy.com> <20040805043957.GT2334@holomorphy.com> <20040805044130.GU2334@holomorphy.com> <20040805044427.GV2334@holomorphy.com> <20040805044627.GW2334@holomorphy.com> <20040805044736.GX2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805044736.GX2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 09:47:36PM -0700, William Lee Irwin III wrote:
> This looks rather unusual, however, this is what sparc32 really wants.
> The function pointer argument to kernel_thread() is irrelevant here;
> the execution state of the thread is established in the SMP trampoline.

num_context_patch2 is never defined, only declared. However, these
declarations generate an undefined symbol reference. So remove it.

Index: mm2-2.6.8-rc2/arch/sparc/kernel/entry.S
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/kernel/entry.S
+++ mm2-2.6.8-rc2/arch/sparc/kernel/entry.S
@@ -858,7 +858,7 @@
 vac_hwflush_patch2_on:		sta	%g0, [%l3 + %l7] ASI_HWFLUSHSEG
 
 	.globl	invalid_segment_patch1, invalid_segment_patch2
-	.globl	num_context_patch1, num_context_patch2
+	.globl	num_context_patch1
 	.globl	vac_linesize_patch, vac_hwflush_patch1
 	.globl	vac_hwflush_patch2
 
Index: mm2-2.6.8-rc2/arch/sparc/mm/sun4c.c
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/mm/sun4c.c
+++ mm2-2.6.8-rc2/arch/sparc/mm/sun4c.c
@@ -379,7 +379,7 @@
 extern unsigned long invalid_segment_patch2, invalid_segment_patch2_ff;
 extern unsigned long invalid_segment_patch1_1ff, invalid_segment_patch2_1ff;
 extern unsigned long num_context_patch1, num_context_patch1_16;
-extern unsigned long num_context_patch2, num_context_patch2_16;
+extern unsigned long num_context_patch2_16;
 extern unsigned long vac_linesize_patch, vac_linesize_patch_32;
 extern unsigned long vac_hwflush_patch1, vac_hwflush_patch1_on;
 extern unsigned long vac_hwflush_patch2, vac_hwflush_patch2_on;
