Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263145AbUKTScw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbUKTScw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 13:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUKTScv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 13:32:51 -0500
Received: from holomorphy.com ([207.189.100.168]:3720 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263145AbUKTSbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 13:31:33 -0500
Date: Sat, 20 Nov 2004 10:31:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm2
Message-ID: <20041120183128.GW2714@holomorphy.com>
References: <20041118021538.5764d58c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118021538.5764d58c.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:15:38AM -0800, Andrew Morton wrote:
> +frv-kill-off-highmem_start_page.patch
> +frv-remove-obsolete-hardirq-stuff-from-includes.patch
> +further-nommu-changes.patch
> +further-nommu-proc-changes.patch
> +frv-arch-nommu-changes.patch

This patch converts FRV to use remap_pfn_range() in its
io_remap_page_range() function.


Index: mm2-2.6.10-rc2/include/asm-frv/pgtable.h
===================================================================
--- mm2-2.6.10-rc2.orig/include/asm-frv/pgtable.h	2004-11-20 00:57:54.000000000 -0800
+++ mm2-2.6.10-rc2/include/asm-frv/pgtable.h	2004-11-20 10:27:32.173203883 -0800
@@ -442,7 +442,8 @@
 #define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range	remap_page_range
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
