Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUHEEij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUHEEij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267481AbUHEEij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:38:39 -0400
Received: from holomorphy.com ([207.189.100.168]:59328 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267484AbUHEEiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:38:22 -0400
Date: Wed, 4 Aug 2004 21:38:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sparc32] [1/13] turbosparc flush warnings
Message-ID: <20040805043817.GS2334@holomorphy.com>
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

viro needs to do sparse work on sparc32, so this series of patches
fixes up the compile for him.


FLUSH_BEGIN() is a nop at the moment, so the mm variable for its
argument trips a warning. Pass vma->vm_mm directly instead.


Index: mm2-2.6.8-rc2/arch/sparc/mm/srmmu.c
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/mm/srmmu.c
+++ mm2-2.6.8-rc2/arch/sparc/mm/srmmu.c
@@ -1697,9 +1697,7 @@
 
 static void turbosparc_flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
-	struct mm_struct *mm = vma->vm_mm;
-
-	FLUSH_BEGIN(mm)
+	FLUSH_BEGIN(vma->vm_mm)
 	flush_user_windows();
 	turbosparc_idflash_clear();
 	FLUSH_END
@@ -1750,9 +1748,7 @@
 
 static void turbosparc_flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
-	struct mm_struct *mm = vma->vm_mm;
-
-	FLUSH_BEGIN(mm)
+	FLUSH_BEGIN(vma->vm_mm)
 	srmmu_flush_whole_tlb();
 	FLUSH_END
 }
