Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269270AbUIYH6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269270AbUIYH6r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269273AbUIYH6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:58:46 -0400
Received: from holomorphy.com ([207.189.100.168]:3046 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269270AbUIYH6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:58:38 -0400
Date: Sat, 25 Sep 2004 00:58:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 6/6] for -mm only: remove remap_page_range() completely
Message-ID: <20040925075834.GJ9106@holomorphy.com>
References: <20040925074445.GD9106@holomorphy.com> <20040925074712.GE9106@holomorphy.com> <20040925074915.GF9106@holomorphy.com> <20040925075102.GG9106@holomorphy.com> <20040925075328.GH9106@holomorphy.com> <20040925075524.GI9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925075524.GI9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:55:24AM -0700, William Lee Irwin III wrote:
> This patch converts all users of remap_page_range() under sound/ to use
> remap_pfn_range(), with the exception of maestro3 changelogs, which are
> likely expected to be preserved intact apart from additions (as most
> changelogs are), regardless of API changes.

All in-tree references to remap_page_range() have been removed by prior
patches in the series. This patch, intended to be applied after some
waiting period for people to adjust to the API change, notice
__deprecated, etc., does the final removal of remap_page_range() as a
function symbol declared within kernel headers and/or implemented in
kernel sources.


Index: mm3-2.6.9-rc2/include/linux/mm.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/mm.h	2004-09-25 00:34:59.009495360 -0700
+++ mm3-2.6.9-rc2/include/linux/mm.h	2004-09-25 00:35:15.435998152 -0700
@@ -859,13 +859,6 @@
 int remap_pfn_range(struct vm_area_struct *, unsigned long,
 		unsigned long, unsigned long, pgprot_t);
 
-static inline __deprecated /* since 25 Sept 2004 -- wli */
-int remap_page_range(struct vm_area_struct *vma, unsigned long uvaddr,
-			unsigned long paddr, unsigned long size, pgprot_t prot)
-{
-	return remap_pfn_range(vma, uvaddr, paddr >> PAGE_SHIFT, size, prot);
-}
-
 #ifdef CONFIG_PROC_FS
 void __vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
 #else
