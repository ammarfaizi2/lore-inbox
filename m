Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUHBObn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUHBObn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUHBObl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:31:41 -0400
Received: from holomorphy.com ([207.189.100.168]:52396 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266546AbUHBO24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:28:56 -0400
Date: Mon, 2 Aug 2004 07:28:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Message-ID: <20040802142854.GG2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802015527.49088944.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 01:55:27AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm2/

Nuke the real undefined symbol in sparc32. This is the only real hit
from ldchk on sparc32; the rest are all btfixup-related (Sam Ravnborg
and I are working on addressing that).


Index: mm1-2.6.8-rc2/arch/sparc/kernel/entry.S
===================================================================
--- mm1-2.6.8-rc2.orig/arch/sparc/kernel/entry.S
+++ mm1-2.6.8-rc2/arch/sparc/kernel/entry.S
@@ -858,7 +858,7 @@
 vac_hwflush_patch2_on:		sta	%g0, [%l3 + %l7] ASI_HWFLUSHSEG
 
 	.globl	invalid_segment_patch1, invalid_segment_patch2
-	.globl	num_context_patch1, num_context_patch2
+	.globl	num_context_patch1
 	.globl	vac_linesize_patch, vac_hwflush_patch1
 	.globl	vac_hwflush_patch2
 
Index: mm1-2.6.8-rc2/arch/sparc/mm/sun4c.c
===================================================================
--- mm1-2.6.8-rc2.orig/arch/sparc/mm/sun4c.c
+++ mm1-2.6.8-rc2/arch/sparc/mm/sun4c.c
@@ -379,7 +379,7 @@
 extern unsigned long invalid_segment_patch2, invalid_segment_patch2_ff;
 extern unsigned long invalid_segment_patch1_1ff, invalid_segment_patch2_1ff;
 extern unsigned long num_context_patch1, num_context_patch1_16;
-extern unsigned long num_context_patch2, num_context_patch2_16;
+extern unsigned long num_context_patch2_16;
 extern unsigned long vac_linesize_patch, vac_linesize_patch_32;
 extern unsigned long vac_hwflush_patch1, vac_hwflush_patch1_on;
 extern unsigned long vac_hwflush_patch2, vac_hwflush_patch2_on;
